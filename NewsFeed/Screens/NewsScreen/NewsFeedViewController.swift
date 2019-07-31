//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by Ratheesh on 30/07/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = NewsFeedViewModel()
    var refreshControl = UIRefreshControl()
    
    private final let kNewsCellIdentifier = "newsCell"
    private final let kPullToRefresh = "Pull to refresh"
    private final let kError = "Error"
    private final let kTitle = "News"
    
    //MARK: ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = kTitle
        
        fetchItems()
        setupRefreshControl()
    }
    
    /*
     Setup refresh control to refresh the APi data
     */

    private func setupRefreshControl() {
        
        refreshControl.attributedTitle = NSAttributedString(string: kPullToRefresh)
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    /*
     Fetch the news from API and reload the tableview
     */

    private func fetchItems() {
        
        Utility.shared.showActivityIndicator()
        
        viewModel.getApiData { [weak self] (data) in
            
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async {
                
                Utility.shared.hideActivityIndicator()
                weakSelf.refreshControl.endRefreshing()
                weakSelf.tableView.isHidden = false

                guard data != nil else {
                    weakSelf.presentAlert(withTitle: weakSelf.kError, message: weakSelf.viewModel.errorMessage ?? "")
                    return
                }
                weakSelf.tableView.reloadData()
            }
        }
    }
    
    /*
     Refresh controller action
    */
    @objc func refresh(sender:AnyObject) {
        
        fetchItems()
    }
    
}

//MARK: UITableViewDataSource

extension NewsFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kNewsCellIdentifier, for: indexPath) as? NewsTableCell else {
            return UITableViewCell()
        }
        cell.cellViewModel = NewsCellViewModel()
        cell.cellViewModel?.news = viewModel.newsList[indexPath.row]
        cell.configureCell()
        
        return cell
    }
}
