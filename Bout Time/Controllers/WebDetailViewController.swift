//
//  WebDetailViewController.swift
//  Bout Time
//
//  Created by Stephen McMillan on 01/01/2019.
//  Copyright © 2019 Stephen McMillan. All rights reserved.
//

import UIKit
import WebKit

class WebDetailViewController: UIViewController, WKUIDelegate {

    var urlString: String = ""
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        
        print(urlString)
        
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        print(webView.isLoading)
    }
    
    @IBAction func barTapped(_ sender: UIButton) {
        print("hello?")
        dismiss(animated: true, completion: nil)
    }
}
