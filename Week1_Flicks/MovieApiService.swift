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
    var movies: [Movie] = []
    
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
    
    // get full image path when given a relative path
    private func getFullImagePath(_ relativePath: String) -> String{
        return "https://image.tmdb.org/t/p/w500/\(relativePath)"
    }
    
    private init(){
        self.movies = []
    }
    
    
    // Load list of moives by either NowPlaying or To Rated
    func loadMovies(page:Int = 1, byMovieEnum: MovieEnum){
        
        // Get Url by considering movie type
        let urlString:String = (byMovieEnum == MovieEnum.nowPlaying) ? getNowPlayingUrl(page: page) : getTopRatedUrl(page: page)
        
        let url:URL? = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request){
            (dataOrNil, response, error) in
            if let data = dataOrNil{
                let jsonData = JSON(data: data)
                let results = jsonData["results"]
                for (_, subJSON):(String,JSON) in results{
                    if let movieId = subJSON["id"].int,
                        let movieTitle = subJSON["title"].string,
                        let overview = subJSON["overview"].string,
                        let releaseDateString = subJSON["release_date"].string,
                        let voteAverage = subJSON["vote_average"].double,
                        let posterPath = subJSON["poster_path"].string{
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        // save list of movies
                        if let movieReleaseDate = dateFormatter.date(from: releaseDateString){
                        
                            let curMovie = Movie(id: movieId, title: movieTitle, overview: overview, posterPath: URL(string: self.getFullImagePath(posterPath)), date: movieReleaseDate, voteAverage: voteAverage)
                            self.movies.append(curMovie)
                        }
                    }
                }
                
                
//                let results = jsonData["results"]
//                for (index, subJSON):(String,JSON) in results{
//                    print(index)
//                }
//                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
//                    NSLog("response: \(responseDictionary)")
//                    //let testJson =  JSON(data: responseDictionary)
//                    //let responseData = responseDictionary["results"] as? NSArray
//                    //self.postData = responseData?["posts"] as? NSArray
//                    //completion()
//                }
            }
            
        }
        
        task.resume()
    }
}
