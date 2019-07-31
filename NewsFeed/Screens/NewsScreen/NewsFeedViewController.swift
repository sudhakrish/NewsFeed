//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by Ratheesh on 30/07/19.
//  Copyright © 2019 Ratheesh. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = NewsFeedViewModel()
    var refreshControl = UIRefreshControl()
    
    private final let kNewsCellIdentifier = "newsCell"
    
    //MARK: ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News"
        
        fetchItems()
        setupRefreshControl()
    }
    
    private func setupRefreshControl() {
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    private func fetchItems() {
        
        activity.startAnimating()
        viewModel.getApiData { [weak self] (data) in
            
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async {
                
                weakSelf.activity.stopAnimating()
                weakSelf.refreshControl.endRefreshing()
                weakSelf.tableView.isHidden = false
                weakSelf.tableView.reloadData()
            }
        }
    }
    
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
