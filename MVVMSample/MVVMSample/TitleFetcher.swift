//
//  TitleFetcher.swift
//  MVVMSample
//
//  Created by Rob Vander Sloot on 3/9/17.
//  Copyright © 2017 Random Visual. All rights reserved.
//

import Foundation

/// A class that conforms to TitleFetchable so that it can be injected into
/// object that need to fetch movie titles.
final class TitleFetcher {
    
    init() {
    }
}


// MARK: - TitleFetchable conformance

extension TitleFetcher: TitleFetchable {
    
    /// Fetch movie titles for the given genre.
    func fetchTitles(forGenre genre: MovieGenreId, completion: @escaping ([String]) -> Void) {
        
        // To keep things simple, this fakes an asynchronous service call by waiting
        // a small amount of time before calling the completion closure.
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) {
            completion(TitleFetcher.getTitles(forGenre: genre))
        }
    }
}


// MARK: - Private helpers

fileprivate extension TitleFetcher {
    
    static func getTitles(forGenre genre: MovieGenreId) -> [String] {
        
        let titles: [String]
        
        switch genre {
        case .none:
            titles = []
        case .action:
            titles = [
                "Casino Royale",
                "Guardians of the Galaxy",
                "The Bourne Identity",
                "Apollo 13",
                "Raiders of the Lost Ark",
                "Enter the Dragon"
            ]
        case .comedy:
            titles = [
                "Space Balls",
                "Monty Python and the Holy Grail",
                "Dr. Strangelove...",
                "Airplane!",
                "Caddyshack",
                "The Princess Bride"
            ]
        case .horror:
            titles = [
                "Psycho",
                "Rosemary's Baby",
                "Aliens",
                "Evil Dead",
                "Gojira",
                "Night of the Living Dead"
            ]
        case .sciFi:
            titles = [
                "Alien",
                "Star Wars",
                "Mad Max 2: The Road Warrior",
                "Jurassic Park",
                "Guardians of the Galaxy",
                "Army of Darkness"
            ]
        }
        
        return titles
    }
}
