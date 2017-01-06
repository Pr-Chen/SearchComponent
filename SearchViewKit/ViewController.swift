//
//  ViewController.swift
//  SearchViewKit
//
//  Created by Mr.Chen on 2017/1/2.
//  Copyright © 2017年 Mr.Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let searchKit = SearchViewKit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchKit.historyView)
        searchKit.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchKit.textField)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchKit.historyView.frame = CGRect(x: view.frame.maxX-240, y: 74, width: 200, height: 300)
    }
}

extension ViewController: SearchViewKitDelegate {
    
    func didBeginEditing(in searchViewKit: SearchViewKit) {
        searchKit.historyView.isHidden = false
    }
    
    func didEndEditing(in searchViewKit: SearchViewKit) {
        searchKit.historyView.isHidden = true
    }
    
    func didTapReturnKey(in searchViewKit: SearchViewKit) {
        
    }
    
    func didSelected(text: String?, in searchViewKit: SearchViewKit) {
        
    }
    
    func didClearSearchHistory(in searchViewKit: SearchViewKit) {
        
    }
}

