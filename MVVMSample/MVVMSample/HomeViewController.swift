//
//  HomeViewController.swift
//  MVVMSample
//
//  Created by Rob Vander Sloot on 3/9/17.
//  Copyright © 2017 Random Visual. All rights reserved.
//

import UIKit

/// View controller for the home (app startup) screen. It is a relatively simple 
/// view with straightforward view model.
class HomeViewController: UIViewController {

    /// View model is declared as a forced unwrapped optional because the view
    /// controller cannot function without it, much like outlets.
    fileprivate var viewModel: HomeViewModel!
    
    
    // MARK: - View lifecycle
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "TitleListViewSegueId" {
//            guard let titleListViewController = segue.destination as? TitleListViewController else { return }
//            
//            guard
//                let indexPath = tableView.indexPathForSelectedRow,
//                let genreId = viewModel.genreId(forIndex: indexPath.row) else {
//                    // no selectd genre, so we'll end up with an empty view.
//                    titleListViewController.viewModel = TitleListViewModel()
//                    return
//            }
//            
//            // Notice that the home view model handles creation of the title
//            // list view model. This helps keep keep logic out of the view
//            // controller and improves testability.
//            let titleListViewModel = viewModel.titleListViewModel(forGenreId: genreId)
//            titleListViewController.viewModel = titleListViewModel
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the view model and populate the view from it.
        viewModel = HomeViewModel()
        populateView()
    }
}


// MARK: - Table view delegate implementation

fileprivate extension HomeViewController {
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let genreId = viewModel.genreId(forIndex: indexPath.row)
//        self.performSegueWithIdentifier("TitleListViewSegueId", sender: self)
//    }
}

// MARK: - Helpers

fileprivate extension HomeViewController {
    
    func populateView() {
        
    }
}
