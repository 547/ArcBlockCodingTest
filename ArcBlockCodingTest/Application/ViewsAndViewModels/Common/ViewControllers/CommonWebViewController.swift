//
//  CommonWebViewController.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/21.
//

import UIKit
import WebKit
import SWLog
import SWCommonExtensions
class CommonWebViewController: UIViewController {
    var refreshButtonItem = UIBarButtonItem()
    var webView = WKWebView()
    var progressView = UIProgressView()

    let viewModel = CommonWebViewModel()

    deinit {
        removeWebObservers()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addWebObservers()
        reload()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if viewModel.navigationTitle == nil {
            if keyPath == "title"{
                title = webView.title
            }
        }
        if keyPath == "estimatedProgress" {
            updateProgressView(webView.estimatedProgress)
        }
    }
    
    @objc
    func tapRefreshButtonItem(_ sender: UIBarButtonItem) {
        reload()
    }
}
private extension CommonWebViewController {
    func addWebObservers() -> () {
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    func removeWebObservers() -> () {
        webView.removeObserver(self, forKeyPath: "title")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}
private extension CommonWebViewController {
    func setupViews() -> () {
        setupNavigation()
        setupWebView()
        setupProgressView()
    }
    func setupNavigation() -> () {
        title = viewModel.navigationTitle ?? ""
        let rightItem = UIBarButtonItem(image: .init(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(tapRefreshButtonItem(_:)))
        refreshButtonItem = rightItem
        navigationItem.rightBarButtonItem = rightItem
    }
    func setupWebView() -> () {
        let userContent = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContent
        let webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        let left = NSLayoutConstraint.init(item: webView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
        let right = NSLayoutConstraint.init(item: webView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0)
        let bottom = NSLayoutConstraint.init(item: webView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint.init(item: webView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        view.addConstraints([left, right, bottom, top])
        self.webView = webView
    }
    func setupProgressView() -> () {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1))
        progressView.progress = 0
        progressView.tintColor = UIColor.blue
        progressView.isUserInteractionEnabled = false
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        let left = NSLayoutConstraint.init(item: progressView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
        let right = NSLayoutConstraint.init(item: progressView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint.init(item: progressView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: statusBarHeight + navigationBarHeight)
        let height = NSLayoutConstraint.init(item: progressView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 1)
        progressView.addConstraint(height)
        view.addConstraints([left, right, top])
        self.progressView = progressView
    }
}
private extension CommonWebViewController {
    func updateProgressView(_ progress:Double) -> () {
        let value = Float(progress)
        progressView.alpha = 1.0
        progressView.setProgress(value, animated: true)
        if value >= 1.0 {
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
                self.progressView.alpha = 0
            }) { (_) in
                self.progressView.progress = 0
            }
        }
    }
    func updateRefreshButtonItemAfter(loadedSuccess:Bool) -> () {
        refreshButtonItem.isEnabled = !loadedSuccess
        refreshButtonItem.tintColor = loadedSuccess ? UIColor.lightGray : UIColor.white
    }
}
extension CommonWebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil || !(navigationAction.targetFrame?.isMainFrame ?? true) {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
extension CommonWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        updateRefreshButtonItemAfter(loadedSuccess: true)
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //禁止捏合缩放、双击放大
        let javascript = "var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);"

        webView.evaluateJavaScript(javascript, completionHandler: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SWLog.log(#function)
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        disposeLoadFailed()
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        decisionHandler(.allow)
    }
}
private extension CommonWebViewController {
    func disposeLoadFailed() -> () {
        updateRefreshButtonItemAfter(loadedSuccess: false)
    }
}
private extension CommonWebViewController {
    func reload() {
        guard let url = URL.init(string: viewModel.url ?? "") else {
            disposeLoadFailed()
            return
        }
        SWLog.log("will load url: \(url.absoluteString) ")
        let request = URLRequest.init(url: url)
        webView.load(request)
    }
}
