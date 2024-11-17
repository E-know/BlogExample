//
//  ViewController.swift
//  WebView
//
//  Created by Inho Choi on 12/11/23.
//

import UIKit
import WebKit


class ViewController: UIViewController {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.naver.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

extension ViewController: WKUIDelegate {
    
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
           if navigationAction.navigationType == WKNavigationType.linkActivated {
               print("link", navigationAction.request.url)
               
               decisionHandler(WKNavigationActionPolicy.cancel)
               return
           }
           print("no link")
           decisionHandler(WKNavigationActionPolicy.allow)
    }
}
