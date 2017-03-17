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
}
