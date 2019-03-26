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
    var workspace = NSWorkspace.shared

    /// A flag that will be `true` when we have detected that the user is going through the Single Sign On process.
    var inSSOFlow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: URL(string: "https://slack.com/signin")!))
        webView.navigationDelegate = self
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        guard
            let url = navigationAction.request.url,
            navigationAction.navigationType == .linkActivated
        else {
            // Default
            decisionHandler(.allow)
            return
        }

        // If we are on the slack SSO page, go into SSO mode.
        if url.absoluteString.contains("slack.com/sso") == true {
            inSSOFlow = true
            decisionHandler(.allow)
        }

        // Open all links in Sock while we are doing SSO
        else if inSSOFlow {
            decisionHandler(.allow)
        }
        
        // Non-slack link
        else if !url.absoluteString.contains("slack.com") {
            decisionHandler(.cancel)
            workspace.open(url)
        }

        // File handler
        else if url.absoluteString.contains("files.slack.com") {
            decisionHandler(.allow)
            workspace.open(url)
        }

        // Slack internal
        else if url.absoluteString.contains("slack.com") {
            decisionHandler(.allow)
        }

        // Default
        else {
            decisionHandler(.cancel)
            workspace.open(url)
        }
    }

    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
        // This is the best signal I can find that SSO has completed. I wish I knew a better way.
        inSSOFlow = false
    }
}

