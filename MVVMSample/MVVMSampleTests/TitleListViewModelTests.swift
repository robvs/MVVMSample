//
//  TitleListViewModelTests.swift
//  MVVMSample
//
//  Created by Rob Vander Sloot on 3/21/17.
//  Copyright © 2017 Random Visual. All rights reserved.
//

import XCTest

class TitleListViewModelTests: XCTestCase {
    
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
    
    func testInitialState() {
        
        // setup
        let genreId      = MovieGenreId.action
        let actualTitles = ["casino royale", "john wick", "bourne identity"]
        let mockDelegate = MockTitleListDelegate()
        let mockFetcher  = MockTitleFetcher(titlesToReturn: actualTitles, fetchDelayMs: 0)
        
        // execute
        let titleListVM  = TitleListViewModel(forGenreId: genreId,
                                              delegate: mockDelegate,
                                              fetcher: mockFetcher)
        
        // validate
        let expectedHeading = String(describing: genreId).capitalized + " Movie Titles"
        XCTAssertEqual(titleListVM.headingTitle, expectedHeading)
        
        XCTAssertEqual(titleListVM.shouldShowLoadingSpinner, false)
        XCTAssertEqual(titleListVM.titleCount, 0)
    }
    
    func testMidRefreshState() {
        
        // setup
        
        // the cool thing with this test is that we can actually unit test
        // the mid-refresh state because we can tell our mock fetcher not
        // to complete until we've had enough time to check the model values.
        let fetchDelay   = 100  // 100ms should be enough time.
        
        let genreId      = MovieGenreId.action
        let actualTitles = ["casino royale", "john wick", "bourne identity"]
        let mockDelegate = MockTitleListDelegate()
        let mockFetcher  = MockTitleFetcher(titlesToReturn: actualTitles, fetchDelayMs: fetchDelay)
        let titleListVM  = TitleListViewModel(forGenreId: genreId,
                                              delegate: mockDelegate,
                                              fetcher: mockFetcher)
        
        // execute
        titleListVM.refresh()
        
        // validate (note: all asserts must run before fetchDelay ends)
        let expectedHeading = String(describing: genreId).capitalized + " Movie Titles"
        XCTAssertEqual(titleListVM.headingTitle, expectedHeading)
        XCTAssertEqual(titleListVM.shouldShowLoadingSpinner, true)
        XCTAssertEqual(titleListVM.titleCount, 0)
    }
    
    func testPostRefreshState() {
        
        // setup
        let expectation    = self.expectation(description: "async_test")
        let fetchDelay     = 0
        let genreId        = MovieGenreId.action
        let expectedTitles = ["casino royale", "john wick", "bourne identity"]
        let mockDelegate   = MockTitleListDelegate()
        let mockFetcher    = MockTitleFetcher(titlesToReturn: expectedTitles, fetchDelayMs: fetchDelay)
        let titleListVM    = TitleListViewModel(forGenreId: genreId,
                                                delegate: mockDelegate,
                                                fetcher: mockFetcher)
        
        // execute
        titleListVM.refresh()
        
        // validate
        // since we know that the mock fetcher immediately post refresh
        // completion on the main queue, we can dispatch our validation 
        // code onto the main queue, which means it will run AFTER the
        // refresh completion.
        DispatchQueue.main.async {
            let expectedHeading = String(describing: genreId).capitalized + " Movie Titles"
            XCTAssertEqual(titleListVM.headingTitle, expectedHeading)
            XCTAssertEqual(titleListVM.shouldShowLoadingSpinner, false)
            
            guard titleListVM.titleCount == expectedTitles.count else {
                XCTFail("title cound is wrong: \(titleListVM.titleCount)")
                return
            }
            XCTAssertEqual(titleListVM.titleCount, expectedTitles.count)
            
            let title0 = titleListVM.title(forIndex: 0)
            let title1 = titleListVM.title(forIndex: 1)
            let title2 = titleListVM.title(forIndex: 2)
            
            // notice that the expected title is capitalized here. this
            // validates that the view model not only returns the correct
            // list element, but that it also capitalizes the string.
            XCTAssertEqual(title0, expectedTitles[0].capitalized)
            XCTAssertEqual(title1, expectedTitles[1].capitalized)
            XCTAssertEqual(title2, expectedTitles[2].capitalized)
            
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }
}


// MARK: - Mock TitleListViewModelDelegate

fileprivate final class MockTitleListDelegate: TitleListViewModelDelegate {
    
    private (set) var refreshDidStartWasCalled:    Bool = false
    private (set) var relreshDidCompleteWasCalled: Bool = false
    
    func refreshDidStart() {
        refreshDidStartWasCalled = true
    }
    
    func relreshDidComplete() {
        relreshDidCompleteWasCalled = true
    }
}


// MARK: - TitleFetchable implementation

fileprivate struct MockTitleFetcher: TitleFetchable {
    
    var titlesToReturn: [String]
    var fetchDelayMs:   Int     // # of milliseconds before completion is called
    
    func fetchTitles(forGenre genre: MovieGenreId, completion: @escaping ([String]) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(fetchDelayMs)) {
            completion(self.titlesToReturn)
        }
    }
}
