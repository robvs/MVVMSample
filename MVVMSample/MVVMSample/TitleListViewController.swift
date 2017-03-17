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
    
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var headingTitleNavItem: UINavigationItem!
    @IBOutlet weak var titlesTableView: UITableView!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titlesTableView.delegate   = self
        titlesTableView.dataSource = self
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
        
        headingTitleNavItem.title = viewModel.headingTitle
        
        viewModel.shouldShowLoadingSpinner ? loadingActivityIndicator.startAnimating() :
                                             loadingActivityIndicator.stopAnimating()
        
        titlesTableView.reloadData()
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


// MARK: - UITableViewDelegate conformance

extension TitleListViewController: UITableViewDelegate {
}


// MARK: - UITableViewDataSource conformance

extension TitleListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.titleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieTitleCellId", for: indexPath)
        cell.textLabel?.text = viewModel.title(forIndex: indexPath.row)
        return cell
    }
}
