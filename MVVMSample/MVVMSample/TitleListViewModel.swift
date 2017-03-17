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
final class TitleListViewModel {
    
    fileprivate      let genreId:      MovieGenreId
    fileprivate weak var delegate:     TitleListViewModelDelegate?
    fileprivate      let fetcher:      TitleFetchable
    fileprivate      var titles:       [String]
    fileprivate      var isRefreshing: Bool
    
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
        titles        = []
        isRefreshing  = false
    }
}


// MARK: - Public interface

extension TitleListViewModel {
    
    /// Get the view's heading title.
    var headingTitle: String {
        
        guard genreId != .none else { return "Movie Titles" }
        
        return String(describing: genreId).capitalized + " Movie Titles"
    }
    
    /// Indicate whether the loading spinner should be displayed.
    var shouldShowLoadingSpinner: Bool {
        return isRefreshing
    }
    
    /// Get the number of titles in the list.
    var titleCount: Int {
        return titles.count
    }
    
    /// Refresh the view model's data based on the associated genre id.
    func refresh() {
        
        isRefreshing = true
        titles = []
        delegate?.refreshDidStart()
        
        fetcher.fetchTitles(forGenre: genreId) { [unowned self] titles in
            self.titles = titles
            self.isRefreshing = false
            self.delegate?.relreshDidComplete()
        }
        
    }
    
    /// Get the title for the given index.
    func title(forIndex index: Int) -> String {
        
        guard titles.indices.contains(index) else { return "" }
        
        return titles[index].capitalized
    }
}
