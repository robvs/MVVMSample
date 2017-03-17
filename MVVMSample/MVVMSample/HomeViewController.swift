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

    fileprivate var viewModel: HomeViewModel!
    
    @IBOutlet fileprivate weak var genreDescriptionLabel: UILabel!
    @IBOutlet fileprivate weak var genreTableView: UITableView!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genreTableView.delegate   = self
        genreTableView.dataSource = self
        
        // Create the view model and populate the view from it.
        viewModel = HomeViewModel()
        populateView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "TitleListViewSegueId" {
            guard let titleListViewController = segue.destination as? TitleListViewController else { return }
            
            guard let indexPath = genreTableView.indexPathForSelectedRow else {
                    // no selectd genre, so we'll end up with an empty view.
                    titleListViewController.viewModel = TitleListViewModel(forGenreId: .none,
                                                                           delegate: titleListViewController)
                    return
            }
            
            // Notice that the home view model handles creation of the title
            // list view model. This helps keep keep logic out of the view
            // controller and improves testability.
            let titleListViewModel = viewModel.titleListViewModel(forIndex: indexPath.row,
                                                                  delegate: titleListViewController)
            titleListViewController.viewModel = titleListViewModel
        }
    }
}


// MARK: - UITableViewDelegate conformance

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        genreDescriptionLabel.text = viewModel.genreDescription(forIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if tableView.indexPathForSelectedRow == nil {
            genreDescriptionLabel.text = ""
        }
    }
}


// MARK: - UITableViewDataSource conformance

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.genreCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieGenreCellId", for: indexPath)
        cell.textLabel?.text = viewModel.genreName(forIndex: indexPath.row)
        return cell
    }
}


// MARK: - Helpers

fileprivate extension HomeViewController {
    
    func populateView() {
        
        genreDescriptionLabel.text = ""
        genreTableView.reloadData()
    }
}
