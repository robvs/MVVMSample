//
//  MovieGenre.swift
//  MVVMSample
//
//  Created by Rob Vander Sloot on 3/14/17.
//  Copyright © 2017 Random Visual. All rights reserved.
//

enum MovieGenreId: Int {
    case none
    case action
    case comedy
    case horror
    case sciFi
}

/// Data model for movie genre information.
struct MovieGenre {
    
    let id: MovieGenreId
    let name: String
    let description: String
    
    static let allGenres = [
        MovieGenre(id: .action, name: "action", description: "Fast-moving often involving fighting, violence, chaces, etc."),
        MovieGenre(id: .comedy, name: "comedy", description: "Desinged to make the audience laugh throughout the film."),
        MovieGenre(id: .horror, name: "horror", description: "Seeks to elicit a negative emotional reaction from viewers by player on their fears."),
        MovieGenre(id: .sciFi,  name: "sciFi",  description: "Uses speculative, fictional science-based elements.")
    ]

}
