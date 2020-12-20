//
//  MoviesFeed.swift
//  Dolfin
//
//  Created by igor on 28.11.2020.
//

import Foundation

struct MoviesFeed: Codable {
    var Search: [Movies]
}

struct Movies: Codable {
    var Title: String
    var Year: String
    var type: String
    var Poster: String
    var imdbID: String
    
    enum CodingKeys: String, CodingKey {
        case Title
        case Year
        case type = "Type"
        case Poster
        case imdbID
    }
}

struct MovieInfo: Codable {
    var Rated, Released, Runtime, Genre, Director, Writer, Actors, Plot: String
    var Language, Country, Awards, imdbRating, imdbVotes, Production: String
    
    enum CodingKeys: String, CodingKey {
        case Rated
        case Released
        case Runtime
        case Genre
        case Director
        case Writer
        case Actors
        case Plot
        case Language
        case Country
        case Awards
        case imdbRating
        case imdbVotes
        case Production
    }
}
