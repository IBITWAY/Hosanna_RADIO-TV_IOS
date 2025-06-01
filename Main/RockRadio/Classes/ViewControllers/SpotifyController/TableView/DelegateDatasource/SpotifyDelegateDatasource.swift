//
//  PreferenceDelegateDatasource.swift
//  Flash
//
//  Created by Faraz Rasheed on 11/10/2020.
//  Copyright © 2020 OneByte. All rights reserved.
//

import UIKit

class SpotifyDelegateDatasource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var spotifyArray = [[String:Any]]()
    
    var didReceiveSelectedCallBack:((_ selectedArray: IndexPath)->Void)?
    var detailSuccessCallBack:((_ index: IndexPath)->Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.spotifyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:SpotifyTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "SpotifyTableViewCell") as? SpotifyTableViewCell
        
        if cell == nil {
            tableView.register(UINib(nibName: "SpotifyTableViewCell", bundle: nil), forCellReuseIdentifier: "SpotifyTableViewCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "SpotifyTableViewCell", for: indexPath) as? SpotifyTableViewCell
        }
        
        cell.index = indexPath
        let refferalObject = self.spotifyArray[indexPath.row]
        
        cell.titleLabel.text = refferalObject["name"] as? String
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        if let callBack = self.didReceiveSelectedCallBack {
            callBack(indexPath)
        }
    }
    
}
