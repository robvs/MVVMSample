//
//  TitleListViewController.swift
//  MVVMSample
//
//  Created by Rob Vander Sloot on 3/9/17.
//  Copyright © 2017 Random Visual. All rights reserved.
//

import UIKit

class TitleListViewController: UIViewController {
    
    /// The view model that drives this view.
    var viewModel: TitleListViewModel!
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate the view from the view model, which at this point is expected
        // to be empty. This displays an empty or loading state while new info is
        // retrieved.
        populateView()

        // Tell the view model to refresh its contents using the injected service.
        // When complete, a delegate call will tell us to update the view.
        viewModel.refresh()
    }
}


// MARK: - Private helpers

fileprivate extension TitleListViewController {
    
    func populateView() {
        
    }
}
