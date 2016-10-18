//
//  Movie.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/14/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import Foundation

class Movie{
    
    let id: Int
    let title: String // movie title
    let overview: String // movie overview
    let posterFullPath: URL? // full url path to image
    let releaseDate:Date?
    
    // get date as string of form "Oct 20, 2016"
    var releaseDateFormatted: String{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            return dateFormatter.string(from: self.releaseDate!)
        }
    }
    let voteAverage: Double
    
    // get vote average formatted to 1 decimal place
    var voteAverageFormatted: String{
        get{
            return String(format: "%.1f", voteAverage)
        }
    }
        
    var genres: [String]
    
    // get genres in the form of a comma separated string
    var genresFormatted: String{
        get{
            var flattenedgenres: String = ""
            if self.genres.count > 0{
                flattenedgenres = self.genres.joined(separator: ", ")
            }
            return flattenedgenres
        }
    }
    
    var runtime: Int? // length of film in minutes
    
    // get runtime string formatted to format "# hr # min
    var runtimeFormatted: String{
        get{
            if let runtimeMinutes = runtime{
                let runtimeHours = runtimeMinutes / 60
                let runtimeRemainingMinutes = runtimeMinutes % 60
                return "\(runtimeHours) hr \(runtimeRemainingMinutes) min"
            }
            return ""
        }
    }
    
    init(id:Int, title: String, overview:String, posterPath: URL?, date: Date?, voteAverage: Double, runtime: Int? = nil, genres:[String] = []){
        self.id = id
        self.title = title
        self.overview = overview
        self.posterFullPath = posterPath
        self.releaseDate = date
        self.voteAverage = voteAverage
        self.genres = genres
        self.runtime = runtime
    }
    
}
