//
//  ViewControllerTests.swift
//  SockTests
//
//  Created by Josh Brown on 3/14/19.
//

import XCTest
import WebKit
@testable import Sock

class ViewControllerTests: XCTestCase {
    
    var vc: ViewController!
    
    override func setUp() {
        vc = ViewController()
        vc.workspace = MockWorkspace()
    }
    
    func test_decidePolicyFor_slack_dot_com_slash_messages() {
        let action = MockNavigationAction(request: URLRequest(url: URL(string: "https://roadfire.slack.com/messages/")!),
                                          navigationType: .linkActivated)
        
        let handlerExpectation = expectation(description: "Handler was called")
        let handler: (WKNavigationActionPolicy) -> Void = { actionPolicy in
            XCTAssertEqual(.allow, actionPolicy)
            handlerExpectation.fulfill()
        }
        
        vc.webView(WKWebView(), decidePolicyFor: action, decisionHandler: handler)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}

class MockNavigationAction: WKNavigationAction {
    let mockRequest: URLRequest
    let mockNavigationType: WKNavigationType
    
    init(request: URLRequest, navigationType: WKNavigationType) {
        mockRequest = request
        mockNavigationType = navigationType
    }
    
    override var request: URLRequest {
        return mockRequest
    }
    
    override var navigationType: WKNavigationType {
        return mockNavigationType
    }
}

class MockWorkspace: NSWorkspace {
    override func open(_ url: URL) -> Bool {
        return true
    }
}
