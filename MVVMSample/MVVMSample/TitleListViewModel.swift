//
//  TitleListViewModel.swift
//  MVVMSample
//
//  Created by Rob Vander Sloot on 3/9/17.
//  Copyright © 2017 Random Visual. All rights reserved.
//


// MARK: - Protocols that enable delegates to be injected into the view model.

/// Enables fetching titles for a specified genre.
protocol TitleFetchable {
    
    func fetchTitles(forGenre genre: MovieGenreId, completion: @escaping ([String]) -> Void)
}


/// Callbacks to inform the delegate of state changes.
protocol TitleListViewModelDelegate: class {
    
    func refreshDidStart()
    func relreshDidComplete()
}


// MARK: - View model definition

/// View model that drives the dynamic contents of the Title List view.
struct TitleListViewModel {
    
    fileprivate      let genreId:  MovieGenreId
    fileprivate weak var delegate: TitleListViewModelDelegate?
    fileprivate      let fetcher:  TitleFetchable
    
    /// Create a new instance based on the given information.
    /// - parameter genreId: The movie genre for which titles are retrieved.
    /// - parameter fetcher: Injectable service that fetches movie titles
    ///                      for a specified genre.
    init(forGenreId genreId: MovieGenreId,
         delegate: TitleListViewModelDelegate,
         fetcher: TitleFetchable = TitleFetcher()) {
        
        self.genreId  = genreId
        self.delegate = delegate
        self.fetcher  = fetcher
    }
}


// MARK: - Public interface

extension TitleListViewModel {
    
    func refresh() {
        
        delegate?.refreshDidStart()
        
        
        
    }
}
