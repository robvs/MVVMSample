//
//  TitleListViewController.swift
//  MVVMSample
//
//  Created by Rob Vander Sloot on 3/9/17.
//  Copyright © 2017 Random Visual. All rights reserved.
//

import UIKit

class TitleListViewController: UIViewController {
    
    /// The view model is expected to be assigned by the presenting code before it
    /// is displayed. It is declared as a forced unwrapped optional because the
    /// view can not function without it, much like outlets.
    var viewModel: TitleListViewModel!
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // At this point, we can assume that the view model has been assigned by
        // the presenting code and it is therefore safe to access.
        
        // This view model is based off of data retrieved via a web service, so
        // it would be a good idea to refresh it whenever the view is about to
        // appear, expecially the first time because the view model may be empty.
        //
        // Note that `refresh()` spawns delegate calls before and after the new
        // data is retrieved, where each repopulates the view.
        viewModel.refresh()
    }
}


// MARK: - Private helpers

fileprivate extension TitleListViewController {
    
    func populateView() {
        
    }
}


// MARK: - TitleListViewModelDelegate conformance

extension TitleListViewController: TitleListViewModelDelegate {
    
    func refreshDidStart() {
        
        populateView()
    }
    
    func relreshDidComplete() {
        
        populateView()
    }
}
