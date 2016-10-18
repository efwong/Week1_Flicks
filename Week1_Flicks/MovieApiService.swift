//
//  MovieApiService.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/14/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieApiService{
    static let service = MovieApiService()

    // MARK: public properties
    
    // MARK: private properties
    private let apiKey:String = "0a92f5a1bb8ee32a1c4b2e001c3ead8a"

    // MARK: Formatters
    
    // get filled in url for now playing movies
    // inputs: page -> for pagination; 1-> get first set of movies from movie db
    private func getNowPlayingUrl(page:Int = 1) ->String{
        return "https://api.themoviedb.org/3/movie/now_playing/?api_key=\(self.apiKey)&language=en-US&page=\(page)"
    }
    
    // get filled in url for top rated movies 
    // inputs: page -> for pagination; 1-> get first set of movies from movie db
    private func getTopRatedUrl(page:Int = 1) ->String{
        return "https://api.themoviedb.org/3/movie/top_rated?api_key=\(self.apiKey)&language=en-US&page=\(page)"
    }
    
    // get url for API to request more movie details
    private func getMovieDetailUrl(_ movieId: Int) -> String{
        return "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(self.apiKey)&language=en-US"
    }
    
    // get full image path when given a relative path
    private func getFullImagePath(_ relativePath: String) -> String{
        return "https://image.tmdb.org/t/p/w500/\(relativePath)"
    }
    
    // set default UrlSessionConfiguration
    var urlSessionConfig: URLSessionConfiguration
    
    // keep track if there previously was a network error
    var hasNetworkError: Bool = false
    
    private init(){
        // set urlsession to timeout after 5 seconds
        urlSessionConfig = URLSessionConfiguration.default
        urlSessionConfig.timeoutIntervalForRequest = 5
        urlSessionConfig.timeoutIntervalForResource = 5
    }
    
    
    // Load list of moives by either NowPlaying or TopRated
    // completion: movie Array, total pages, success
    func loadMovies(page:Int = 1, byMovieEnum: MovieEnum, completion: @escaping ([Movie]?, Int, Bool) -> Void){
        
        // Get Url by considering movie type
        let urlString:String = (byMovieEnum == MovieEnum.nowPlaying) ? getNowPlayingUrl(page: page) : getTopRatedUrl(page: page)
        
        let url:URL? = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: self.urlSessionConfig, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request){
            (dataOrNil, response, error) in
            if (error != nil){
                self.hasNetworkError = true
                completion(nil, 0, false) // not successful
            }
            else if let data = dataOrNil{
                var movies:[Movie] = []
                let jsonData = JSON(data: data)
                let results = jsonData["results"]
                for (_, subJSON):(String,JSON) in results{
                    if let parsedMovie = self.parseMovieJSON(subJSON){
                        movies.append(parsedMovie)
                    }
                    
                }
                if let totalPages = jsonData["total_pages"].int{
                    completion(movies, totalPages, true)
                }else{
                    completion(movies, 0, true)
                }
                
                self.hasNetworkError = false
            }
                
            
        }
        
        task.resume()
    }
    
    // Load Movie Details
    // Gets additional property (runtime and genres)
    // run callback in completion to execute update with Movie Properties
    func loadMovieDetails(movieId: Int, completion: @escaping (Movie?, Bool) -> Void) -> Void{
        
        let url:URL? = URL(string: getMovieDetailUrl(movieId))
        let request = URLRequest(url: url!)
        
        let session = URLSession(configuration: self.urlSessionConfig, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request){
            (dataOrNil, response, error) in
            if (error != nil){
                completion(nil, false) // not successful
                self.hasNetworkError = true
            }
            else if let data = dataOrNil{
                let jsonData = JSON(data: data)
                if let movieData = self.parseMovieJSON(jsonData){
                    completion(movieData, true)
                }
                self.hasNetworkError = false
                
            }
        }
        task.resume()
    }
    
    
    // parse Movie JSON
    private func parseMovieJSON(_ subJSON:JSON) -> Movie?{
        if let movieId = subJSON["id"].int,
            let movieTitle = subJSON["title"].string,
            let overview = subJSON["overview"].string,
            let releaseDateString = subJSON["release_date"].string,
            let voteAverage = subJSON["vote_average"].double,
            let posterPath = subJSON["poster_path"].string{
            
            // check extra details
            var runTime:Int? = nil
            var genreList:[String] = []
            
            // parse runtime if exists
            if subJSON["runtime"].exists(){
                runTime = subJSON["runtime"].int
            }
            
            // parse genres if exists
            if subJSON["genres"].exists(){
                // parse genre
                let genres = subJSON["genres"]
                for (_, genreObj):(String,JSON) in genres{
                    if let genreName = genreObj["name"].string{
                        genreList.append(genreName)
                    }
                }
                
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            // save list of movies
            if let movieReleaseDate = dateFormatter.date(from: releaseDateString){
                
                let curMovie = Movie(id: movieId, title: movieTitle, overview: overview, posterPath: URL(string: self.getFullImagePath(posterPath)), date: movieReleaseDate, voteAverage: voteAverage, runtime: runTime, genres: genreList)
                
                return curMovie
            }
        }
        return nil
    }
}
