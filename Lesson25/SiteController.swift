//
//  SiteController.swift
//  Lesson25
//
//  Created by Владислав Пуцыкович on 26.01.22.
//

import UIKit
import WebKit

fileprivate struct Constants {
    static let pdfFormatString = "pdf"
    static let charForSubstring: Character = "."
}

class SiteController: UIViewController, WKNavigationDelegate {

    var urlString = String()
    let webView = WKWebView()
    
    override func loadView() {
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if urlString.hasSuffix(Constants.pdfFormatString) {
            let index = urlString.firstIndex(of: Constants.charForSubstring) ?? urlString.endIndex
            guard let url = Bundle.main.url(
                forResource: String(urlString[..<index]),
                withExtension: Constants.pdfFormatString
            ) else { return }
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        } else {
            guard let url = URL(string: urlString) else { return }
            let request = URLRequest(url: url)
            webView.load(request)
            webView.allowsBackForwardNavigationGestures = true
        }
        
    }
}

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
