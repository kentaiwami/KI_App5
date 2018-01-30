//
//  SocialContainViewController.swift
//  FiNote
//
//  Created by 岩見建汰 on 2018/01/29.
//  Copyright © 2018年 Kenta. All rights reserved.
//

import UIKit
import StatusProvider
import Alamofire
import NVActivityIndicatorView
import SwiftyJSON

class SocialContainViewController: UIViewController, UISearchBarDelegate, StatusController {

    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = "オノマトペで検索"
        if #available(iOS 11.0, *) {
            searchBar.height(44)
        }
        
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.titleView = searchBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        RunSearch()
    }
    
    func RunSearch() {
        let urlString = API.base.rawValue+API.v1.rawValue+API.movie.rawValue+API.onomatopoeia.rawValue+API.contain.rawValue+"?onomatopoeia=\(searchBar.text!)"
        let encURL = (NSURL(string:urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)?.absoluteString)!
        let activityData = ActivityData(message: "Searching", type: .lineScaleParty)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        DispatchQueue(label: "update-movie-user-info").async {
            Alamofire.request(encURL, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
                
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                
                guard let res = response.result.value else{return}
                let obj = JSON(res)
                print("***** API results *****")
                print(obj)
                print("***** API results *****")
                
                if IsHTTPStatus(statusCode: response.response?.statusCode) {
                    self.DrawView()
                }else {
                    ShowStandardAlert(title: "Error", msg: obj.arrayValue[0].stringValue, vc: self)
                }
            }
        }
    }
    
    func DrawView() {
        //TODO: Viewの描画
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
