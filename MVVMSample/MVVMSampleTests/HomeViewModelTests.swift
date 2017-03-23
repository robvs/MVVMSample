//
//  HomeViewModelTests.swift
//  MVVMSample
//
//  Created by Rob Vander Sloot on 3/17/17.
//  Copyright © 2017 Random Visual. All rights reserved.
//

import XCTest
//@testable import MVVMSample

class HomeViewModelTests: XCTestCase {
    
    // MARK: Setup/Teardown
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: Tests
    
    func testEmptyGenreList() {
        
        // setup
        let genres: [MovieGenre] = []
        
        // execute
        let homeVM = HomeViewModel(genres: genres)
        
        // validate
        XCTAssertEqual(homeVM.genreCount, 0)
        XCTAssertNil(homeVM.genreDescription(forIndex: 0))
        XCTAssertNil(homeVM.genreName(forIndex: 0))
        
        // since TitleListViewModel depends upon a service that can't be injected
        // via homeVM.titleListViewModel(forIndex:delegate:), we'll check only the
        // properties that do not rely on data being fetched.
        let titleListVM = homeVM.titleListViewModel(forIndex: 0, delegate: MockTitleListDelegate())
        XCTAssertEqual(titleListVM.headingTitle, "Movie Titles")
    }
    
    func testOneGenre() {
        
        // setup
        let genre0 = MovieGenre(id: .action, name: "Action", description: "Action genre")
        let genres: [MovieGenre] = [genre0]
        
        // execute
        let homeVM = HomeViewModel(genres: genres)
        
        // validate
        XCTAssertEqual(homeVM.genreCount, genres.count)
        
        guard let actualDescription0 = homeVM.genreDescription(forIndex: 0) else {
            XCTFail("genre should not be nil")
            return
        }
        XCTAssertEqual(actualDescription0, genre0.description)
        
        guard let actualName0 = homeVM.genreName(forIndex: 0) else {
            XCTFail("genre should not be nil")
            return
        }
        XCTAssertEqual(actualName0, genre0.name)
        
        // since TitleListViewModel depends upon a service that can't be injected
        // via homeVM.titleListViewModel(forIndex:delegate:), we'll check only the
        // properties that do not rely on data being fetched.
        let titleListVM0 = homeVM.titleListViewModel(forIndex: 0, delegate: MockTitleListDelegate())
        XCTAssertEqual(titleListVM0.headingTitle, genre0.name + " Movie Titles")
    }
    
    func testMultipleGenres() {
        
        // setup
        let genre0 = MovieGenre(id: .action, name: "Action", description: "Action genre")
        let genre1 = MovieGenre(id: .comedy, name: "Comedy", description: "Comedy genre")
        let genres: [MovieGenre] = [genre0, genre1]
        
        // execute
        let homeVM = HomeViewModel(genres: genres)
        
        // validate
        XCTAssertEqual(homeVM.genreCount, genres.count)
        
        guard let actualDescription0 = homeVM.genreDescription(forIndex: 0),
              let actualDescription1 = homeVM.genreDescription(forIndex: 1) else {
            XCTFail("description should not be nil")
            return
        }
        XCTAssertEqual(actualDescription0, genre0.description)
        XCTAssertEqual(actualDescription1, genre1.description)
        
        guard let actualName0 = homeVM.genreName(forIndex: 0),
              let actualName1 = homeVM.genreName(forIndex: 1) else {
            XCTFail("genre should not be nil")
            return
        }
        XCTAssertEqual(actualName0, genre0.name)
        XCTAssertEqual(actualName1, genre1.name)
        
        // since TitleListViewModel depends upon a service that can't be injected
        // via homeVM.titleListViewModel(forIndex:delegate:), we'll check only the
        // properties that do not rely on data being fetched.
        let titleListVM0 = homeVM.titleListViewModel(forIndex: 0, delegate: MockTitleListDelegate())
        let titleListVM1 = homeVM.titleListViewModel(forIndex: 1, delegate: MockTitleListDelegate())
        XCTAssertEqual(titleListVM0.headingTitle, genre0.name + " Movie Titles")
        XCTAssertEqual(titleListVM1.headingTitle, genre1.name + " Movie Titles")
    }
}


// MARK: - Mock TitleListViewModelDelegate

fileprivate final class MockTitleListDelegate: TitleListViewModelDelegate {
    
    func refreshDidStart() { }
    func relreshDidComplete() { }
}
