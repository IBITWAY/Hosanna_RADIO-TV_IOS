//
//  LogInController.swift
//  Covid19 App
//
//  Created by Sheraz Rasheed on 26/03/2020.
//  Copyright © 2020 Sheraz Rasheed. All rights reserved.
//

import UIKit

class SpotifyViewController: UIViewController {
    
    @IBOutlet var customView:SpotifyView!

    var spotifyArray = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @objc private func refreshListData(_ sender: Any) {
//        self.startAnimating()
//        self.handler.requestGetSummaryAPI(limit: self.limit, offset: self.offset)
    }
    
    func configureTableView() {
        self.customView.spotifyDelegateDatasource = SpotifyDelegateDatasource()
        self.customView.tableView.delegate = self.customView.spotifyDelegateDatasource
        self.customView.tableView.dataSource = self.customView.spotifyDelegateDatasource
        self.customView.spotifyDelegateDatasource.spotifyArray = self.spotifyArray
        
        self.customView.spotifyDelegateDatasource.didReceiveSelectedCallBack = { index in
            let refferalObject = self.spotifyArray[index.row]

            if let urlString = refferalObject["url"] as? String {
                if let url = URL(string: urlString) {
                    UIApplication.shared.open(url)
                }
            }
        }
        
        self.customView.tableView.reloadData()
    }
    
   
    
    @IBAction func backButtonTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}

