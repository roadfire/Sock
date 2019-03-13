//
//  ViewController.swift
//  Sock
//
//  Created by Matt Lorentz on 3/12/19.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: URL(string: "https://slack.com/signin")!))
        webView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url,
            navigationAction.navigationType == .linkActivated,
            let host = url.host,
            !host.contains("slack.com") else {
                decisionHandler(.allow)
                return
        }
        decisionHandler(.cancel)
        NSWorkspace.shared.open(url)
    }
}

