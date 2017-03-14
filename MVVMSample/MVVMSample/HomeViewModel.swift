//
//  HomeViewModel.swift
//  MVVMSample
//
//  Created by Rob Vander Sloot on 3/9/17.
//  Copyright © 2017 Random Visual. All rights reserved.
//


/// View model that drives the dynamic contents of the Home View screen.
struct HomeViewModel {
    
    /// Data model that drives the view model. Marked private because all 
    /// public/internal view model properties & methods should provide
    /// view-specific values.
    ///
    /// It is important to remember that the view model owns the data
    /// model, not the view controller.
    fileprivate let genres: [MovieGenre]
    
    init() {
        
        genres = [
            MovieGenre(id: .action, name: "action", description: "Fast-moving often involving fighting, violence, chaces, etc."),
            MovieGenre(id: .comedy, name: "comedy", description: "Desinged to make the audience laugh throughout the film."),
            MovieGenre(id: .horror, name: "horror", description: "Seeks to elicit a negative emotional reaction from viewers by player on their fears."),
            MovieGenre(id: .sciFi,  name: "sciFi",  description: "Uses speculative, fictional science-based elements.")
        ]
    }
}


// MARK: - Public interface

extension HomeViewModel {
    
    func genreName(forIndex index: Int) -> String? {
        
        guard genres.indices.contains(index) else { return nil }
        
        return genres[index].name.capitalized
    }
    
    func description(forGenreId genreId: MovieGenreId) -> String? {
        
        guard let elementIndex = genres.index(where: { $0.id == genreId } ) else { return nil }
        
        return genres[elementIndex].description
    }
}
