//
//  Movie.swift
//  Dolfin
//
//  Created by igor on 27.11.2020.
//

import Foundation
import UIKit

class Movie {
    var title, year, type, imdbID: String?
    var poster: UIImage?
    var rated, released, runtime, genre, director, writer, actors, plot: String?
    var language, country, awards, imdbRating, imdbVotes, production: String?
    
    init(title: String = "", year: String = "", type: String = "", poster: UIImage = UIImage(), imdbID: String = "") {
        self.title = title
        self.year = year
        self.type = type
        self.poster = poster
        self.imdbID = imdbID
    }
}
