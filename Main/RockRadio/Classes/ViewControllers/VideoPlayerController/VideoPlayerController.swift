//
//  SideMenuViewController.swift
//  OneScreenRadio
//
//  Created by Faraz Rasheed on 17/05/2020.
//  Copyright © 2020 IBITWAY. All rights reserved.
//

import UIKit
import WebKit
import MediaPlayer
import AVKit

class VideoPlayerController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView1: WKWebView!
    @IBOutlet weak var textView: UITextView!
    
    var isAbout = false
    var urlString = ""
    var videoPlayer: AVPlayer!
    var playerViewController: AVPlayerViewController!
    @IBOutlet weak var playerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let videoURL = URL(string: "https://bit.ly/swswift")
        self.videoPlayer = AVPlayer(url: videoURL!)
        self.playerViewController = AVPlayerViewController()
        playerViewController.player = self.videoPlayer
        playerViewController.view.frame = self.playerView.frame
        playerViewController.view.frame = CGRect(x: 0, y: 0, width: self.playerView.frame.size.width, height: self.playerView.frame.size.height)
        playerViewController.player?.pause()
        self.playerView.addSubview(playerViewController.view)
        playerViewController.didMove(toParent: self)

    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
//        AppDelegate.sharedInstance()?.moveToHomeView()
//        self.navigationController?.popViewController(animated: true)
    }
}
