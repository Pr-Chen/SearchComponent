//
//  SearchViewKit.swift
//  SearchViewKit
//
//  Created by Mr.Chen on 2017/1/2.
//  Copyright © 2017年 Mr.Chen. All rights reserved.
//

import UIKit

class SearchViewKit: NSObject {
    
    public let textField: UITextField = UITextField()
    public let historyView: UIView = UIView()
    
    private let containerView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let clearButton: UIButton = UIButton()
    
    override init() {
        super.init()
        setupTextField()
        
    }
    
    private func setupTextField() {
        textField.frame = CGRect(x: 0, y: 0, width: 250, height: 30)
        textField.delegate = self
        textField.returnKeyType = .search
        textField.backgroundColor = UIColor(white: 0, alpha: 0.05)
        textField.placeholder = "输入商品名称或款号"
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = UIColor(white: 0.2, alpha: 1)
        textField.layer.cornerRadius = 3
        
        let leftIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        leftIcon.contentMode = .center
        leftIcon.image = UIImage(named: "search")
        
        textField.leftView = leftIcon
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
    }
    
    private func setupHistoryView() {
        historyView.backgroundColor = .white
        historyView.addSubview(containerView)
        
        //加阴影
        historyView.layer.masksToBounds = false
        historyView.layer.shadowColor = UIColor(white: 0, alpha: 0.5).cgColor
        historyView.layer.shadowRadius = 3
        historyView.layer.shadowOpacity = 0.5
        historyView.layer.shadowOffset = .zero
        
        //设置圆角
        containerView.layer.cornerRadius = 3
        
    }
    
    private func creatTitlLabel() {
        
    }
    
    private func creatClearButton() {
        
    }
    
    private func creatTableView() {
        
    }
    
}

extension SearchViewKit: UITextFieldDelegate {
    
}
