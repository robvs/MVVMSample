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
    
    init(genres: [MovieGenre]) {
        
        self.genres = genres
    }
}


// MARK: - Public interface

extension HomeViewModel {
    
    /// Get the number of genres in the list.
    var genreCount: Int {
        return genres.count
    }
    
    /// Get the name of the genre at the given index.
    ///
    /// Note that the name is capitalized before being retuned, which is
    /// how we want it to be displayed in the view. This is exaclty the
    /// type of logic that belongs in a view model, not the view controller.
    func genreName(forIndex index: Int) -> String? {
        
        guard let genre = genre(forIndex: index) else { return nil }

        return genre.name.capitalized
    }
    
    /// Get the description of the genre at the given index.
    func genreDescription(forIndex index: Int) -> String? {
        
        guard let genre = genre(forIndex: index) else { return nil }
        
        return genre.description
    }
    
    /// Get the view model for the desired title list view controller.
    ///
    /// Putting this logicr in a view model makes it easy to unit text.
    func titleListViewModel(forIndex index: Int,
                            delegate: TitleListViewModelDelegate) -> TitleListViewModel {
        
        guard let genre = genre(forIndex: index) else {
            return TitleListViewModel(forGenreId: .none, delegate: delegate)
        }
        
        return TitleListViewModel(forGenreId: genre.id, delegate: delegate)
    }
}


// MARK: - Private helpers

fileprivate extension HomeViewModel {
    
    /// Get the movie genre for the given index.
    ///
    /// Note that if this method was made internal or public, then
    /// the view controller would have direct access to the data
    /// model, which should be avoid if at all possible.
    func genre(forIndex index: Int) -> MovieGenre? {
        
        guard genres.indices.contains(index) else { return nil }
        
        return genres[index]
    }
}
