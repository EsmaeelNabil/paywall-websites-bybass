//
//  WebView.swift
//  rmwall
//
//  Created by Esmaeel Nabil Mohamed Moustafa on 17.01.23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        var request = URLRequest(url: url)
        request.httpShouldHandleCookies = false
        request.allowsCellularAccess = true
        
        webView.load(request)
    }
}
