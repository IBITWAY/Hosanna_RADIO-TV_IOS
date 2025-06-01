//
//  SideMenuController.swift
//  RockRadio
//
//  Created by Faraz Rasheed on 22/08/2020.
//  Copyright © 2020 IBITWAY. All rights reserved.
//

import UIKit
import LGSideMenuController
import MessageUI
import MediaPlayer
import AVKit
import UserNotifications
import FRadioPlayer
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SDWebImage
//import SwiftGifOrigin
import Alamofire
import SwiftyJSON

class SideMenuController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var tableView:UITableView!
    var socialArray = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.socialArray = AppDelegate.sharedInstance()!.socialArray
        
        self.socialData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.socialArray = AppDelegate.sharedInstance()!.socialArray
    }
    
    
    @IBAction func nowPlayingButtonTapped(_ sender: Any) {
        sideMenuController?.hideLeftView()
    }
    
    @IBAction func fbButtonTapped(_ sender: Any) {
        
        if let url = URL(string: facebookUrl) {
            UIApplication.shared.open(url)
        }

//        let viewController = WebViewController(nibName: "WebViewController", bundle: nil)
//        viewController.urlString = facebookUrl
//        //        facebookUrl
//        viewController.modalPresentationStyle = .overFullScreen
//        self.present(viewController, animated: false, completion: nil)
        
        //        AppDelegate.sharedInstance()?.moveToSebView(urlString: "https://www.facebook.com/rexvanradio", isAbout: false)
    }
    
    @IBAction func fanButtonTapped(_ sender: Any) {
        
        if let url = URL(string: twitterUrl) {
            UIApplication.shared.open(url)
        }

//        let viewController = WebViewController(nibName: "WebViewController", bundle: nil)
//        viewController.urlString = twitterUrl
//        viewController.modalPresentationStyle = .overFullScreen
//        self.present(viewController, animated: false, completion: nil)
    }
    
    @IBAction func webButtonTapped(_ sender: Any) {
        
        if let url = URL(string: websiteUrl) {
            UIApplication.shared.open(url)
        }

//        let viewController = WebViewController(nibName: "WebViewController", bundle: nil)
//        viewController.urlString = websiteUrl
//        viewController.modalPresentationStyle = .overFullScreen
//        self.present(viewController, animated: false, completion: nil)
    }
    
    @IBAction func twitterButtonTapped(_ sender: Any) {
        if let url = URL(string: twitterUrl) {
            UIApplication.shared.open(url)
        }

//        let viewController = WebViewController(nibName: "WebViewController", bundle: nil)
//        viewController.urlString = twitterUrl
//        viewController.modalPresentationStyle = .overFullScreen
//        self.present(viewController, animated: false, completion: nil)
    }
    
    @IBAction func tuckerWeatherButtonTapped(_ sender: Any) {
        
        if let url = URL(string: schedule) {
            UIApplication.shared.open(url)
        }

//
//        let viewController = WebViewController(nibName: "WebViewController", bundle: nil)
//        viewController.urlString = schedule
//        //        ytUrl
//        viewController.modalPresentationStyle = .overFullScreen
//        self.present(viewController, animated: false, completion: nil)
    }
    
    @IBAction func instaButtonTapped(_ sender: Any) {
        
        if let url = URL(string: instaUrl) {
            UIApplication.shared.open(url)
        }

//        let viewController = WebViewController(nibName: "WebViewController", bundle: nil)
//        viewController.urlString = instaUrl
//        //        instaUrl
//        viewController.modalPresentationStyle = .overFullScreen
//        self.present(viewController, animated: false, completion: nil)
    }
    
    
    @IBAction func callButtonTapped(_ sender: Any) {
        
        if let url = URL(string: contact_us) {
            UIApplication.shared.open(url)
        }

//        let viewController = WebViewController(nibName: "WebViewController", bundle: nil)
//        viewController.urlString = contact_us
//        //        instaUrl
//        viewController.modalPresentationStyle = .overFullScreen
//        self.present(viewController, animated: false, completion: nil)

//        self.dialNumber(number: whatsApp)
    }
    
    @IBAction func sendEmail(_ sender: UIButton) {
        // Modify following variables with your text / recipient

        self.emailUS()
    }
    
    func emailUS() {
        let recipientEmail = email
        let subject = ""
        let body = ""
        
        // Show default mail composer
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipientEmail])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            
            present(mail, animated: true)
            
            // Show third party email composer if default Mail app is not present
        } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
            UIApplication.shared.open(emailUrl)
        }
    }
    
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
    func openWhatsApp(number: String) {
        let urlWhats = "https://api.whatsapp.com/send?phone=\(number)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    @IBAction func whatAppButtonTapped(_ sender: Any) {
        
        let urlWhats = "https://api.whatsapp.com/send?phone=\(whatsApp)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    func socialData() {
        
        Firestore.firestore().collection("social").getDocuments { (documentSnapshot, error) in
            if let err = error{
                print("Error getting documents: \(err)")
            }else{
                for document in documentSnapshot!.documents {
                    let data = document.data()
                    
                    if let isRadio = data["isRadio"] as? Bool {
                        if isRadio {
                            if let url = data["stream"] as? String {
                                radioURL = url
                            }
                        }
                    }

                    self.socialArray.append(data)
                    
                    self.socialArray = self.socialArray.sorted(by: { (($0["sort"] as? String) ?? "") < (($1["sort"] as? String) ?? "") })
                }
                
                AppDelegate.sharedInstance()?.socialArray = self.socialArray
                
                self.tableView.reloadData()
            }
        }
    }
    
    func positionSort(dict1: [String: Any], dict2: [String: Any]) -> Bool {
        let position1 = dict1["position"] as? Int ?? 0
        let position2 = dict2["position"] as? Int ?? 0
        return position1 < position2
    }
}


extension SideMenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.socialArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        var cell:SideMenuTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as? SideMenuTableViewCell
        
        if cell == nil {
            
            tableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCell")
            
            cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as? SideMenuTableViewCell
        }
        
        let data = self.socialArray[indexPath.row]
        if let name = data["name"] as? String {
            cell.titleLabel.text = name
        }
        
        if let isRadio = data["isRadio"] as? Bool {
            if isRadio {
                if let url = data["url"] as? String {
                    radioURL = url
//                    cell.titleLabel.text = "Now Playing"
                }
                
                if let imageURL = data["image"] as? String {
                    cell.socialImage.sd_setImage(with: URL(string: "\(imageURL)"), completed: nil)
                }

            }else {
                if let name = data["name"] as? String {
//                    if name == "Instagaram" {
//                        cell.titleLabel.text = "Instagram"
//                    }else {
//                        cell.titleLabel.text = name
//                    }
                }
                
                if let imageURL = data["image"] as? String {
                    cell.socialImage.sd_setImage(with: URL(string: "\(imageURL)"), completed: nil)
                }
            }
        }else {
            if let name = data["name"] as? String {
//                cell.titleLabel.text = name
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = self.socialArray[indexPath.row]

        if let isRadio = data["isRadio"] as? Bool {
            if isRadio {
                sideMenuController?.hideLeftView()
            }else {
                if let name = data["name"] as? String {
                
                    if let isTV = data["isTV"] as? Bool {
                        if isTV {
                            let viewController = VideoPlayerController(nibName: "VideoPlayerController", bundle: nil)
                            if let url = data["stream"] as? String {
                                viewController.urlString = url
                            }
                            
                            viewController.modalPresentationStyle = .overFullScreen
                            self.present(viewController, animated: false, completion: nil)
                            return
                        }
                    }
                    
                    if name == "Email" {
                        if let url = data["stream"] as? String {
                            email = url
                        }
                        self.emailUS()
                    }else if name == "WhatsApp" {
                        if let url = data["stream"] as? String {
                            self.openWhatsApp(number: url)
                        }
                    }else {
                        if let url = data["stream"] as? String {
                            if let url = URL(string: url) {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                }else {
                    if let url = data["stream"] as? String {
                        if let url = URL(string: url) {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            }
        }
    }
}
