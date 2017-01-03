//
//  SearchViewKit.swift
//  SearchViewKit
//
//  Created by Mr.Chen on 2017/1/2.
//  Copyright © 2017年 Mr.Chen. All rights reserved.
//

import UIKit

protocol SearchViewKitDelegate {
    func didBeginEditing(in searchViewKit: SearchViewKit)
    func didEndEditing(in searchViewKit: SearchViewKit)
}

class SearchViewKit: NSObject {
    
    public let textField: UITextField = UITextField()
    public var delegate: SearchViewKitDelegate?
    
    @IBOutlet var historyView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    
    
    override init() {
        super.init()
        setupTextField()
        setupHistoryView()
    }
    
    /// 初始化搜索框
    private func setupTextField() {
        textField.frame = CGRect(x: 0, y: 0, width: 250, height: 30)
        textField.delegate = self
        textField.returnKeyType = .search
        textField.backgroundColor = UIColor(white: 0, alpha: 0.05)
        textField.placeholder = "输入商品名称或款号"
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = UIColor(white: 0.2, alpha: 1)
        textField.layer.cornerRadius = 15
        
        let leftIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        leftIcon.contentMode = .center
        
        leftIcon.image = UIImage(named: "search")
        
        textField.leftView = leftIcon
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
    }
    
    /// 初始化历史记录视图
    private func setupHistoryView() {
        historyView = Bundle.main.loadNibNamed("HistoryView", owner: self, options: nil)?.first as! UIView!
        
        //加阴影
        historyView.layer.masksToBounds = false
        historyView.layer.shadowColor = UIColor(white: 0, alpha: 0.5).cgColor
        historyView.layer.shadowRadius = 3
        historyView.layer.shadowOpacity = 0.5
        historyView.layer.shadowOffset = .zero
        
        setupContainerView()
    }
    
    private func setupContainerView() {
        //设置圆角
        containerView.layer.cornerRadius = 3
    }
    
    /// 初始化标题标签
    private func setupTitleLabel() {
        
        titleLabel.text = "最近搜索"
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor(white: 0.6, alpha: 1)
    }
    
    /// 初始化清空按钮
    private func setupClearButton() {
        clearButton.setImage(UIImage(named:"trash"), for: .normal)
    }
    
    /// 初始化表格
    private func setupTableView() {
        
        
    }
    
    
    
}

extension SearchViewKit: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didBeginEditing(in: self)
        print("开始编辑了")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing(in: self)
    }
}
