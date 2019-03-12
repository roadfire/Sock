//
//  ViewController.swift
//  Sock
//
//  Created by Matt Lorentz on 3/12/19.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: URL(string: "https://slack.com/signin")!))
    }
}

