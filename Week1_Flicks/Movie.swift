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
    let voteAverage: Double
    var genres: [String]
    var runtime: Int? // length of film in minutes
    
//    int(){
//        self.id = 0
//        self.title = ""
//        self.overview = ""
//        self.posterFullPath = nil
//        self.releaseDate = nil
//        self.voteAverage = voteAverage
//        self.genres = genres
//        self.runtime = runtime
//    }
    init(id:Int, title: String, overview:String, posterPath: URL?, date: Date, voteAverage: Double, runtime: Int? = nil, genres:[String] = []){
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
