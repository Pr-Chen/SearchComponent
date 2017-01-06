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
    func didTapReturnKey(in searchViewKit: SearchViewKit)
    func didSelected(text: String?, in searchViewKit: SearchViewKit)
    func didClearSearchHistory(in searchViewKit: SearchViewKit)
}

class SearchViewKit: NSObject {
    
    public let textField: UITextField = UITextField()
    public var delegate: SearchViewKitDelegate?
    public var recordCount = 10
    
    @IBOutlet var historyView: UIView! {
        didSet {
            historyView.layer.masksToBounds = false
            historyView.layer.shadowColor = UIColor(white: 0, alpha: 0.5).cgColor
            historyView.layer.shadowRadius = 3
            historyView.layer.shadowOpacity = 0.5
            historyView.layer.shadowOffset = .zero
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 3
        }
    }
    
    var historyAry = [String]()
    
    
    override init() {
        super.init()
        setupTextField()
        
        historyView = Bundle.main.loadNibNamed("HistoryView", owner: self, options: nil)?.first as! UIView!
        readSearchHistory()
        
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
        textField.enablesReturnKeyAutomatically = true
        
        let leftIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        leftIcon.contentMode = .center
        leftIcon.image = UIImage(named: "search")
        
        textField.leftView = leftIcon
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
    }
    
}

//MARK:- textField代理
extension SearchViewKit: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didBeginEditing(in: self)
        print("开始编辑了")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing(in: self)
        
        //存储记录
        save(text: textField.text)
        tableView.reloadData()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            delegate?.didEndEditing(in: self)
            save(text: textField.text)
            tableView.reloadData()
            textField.resignFirstResponder()
            delegate?.didTapReturnKey(in: self)
            return false
        }
        return true
    }
}

//MARK:- tableView数据源
extension SearchViewKit: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyAry.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellID")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "CellID")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 12)
            cell?.textLabel?.textColor = UIColor(white: 0.2, alpha: 1)
        }
        cell?.textLabel?.text = historyAry[indexPath.row]
        
        return cell!
    }
}

//MARK:- tableView代理
extension SearchViewKit: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelected(text: textField.text, in: self)
    }
}

//MARK:- 事件响应
extension SearchViewKit {
    @IBAction func clickClearButton(_ sender: UIButton) {
        clearSearchHistory()
        tableView.reloadData()
        delegate?.didClearSearchHistory(in: self)
    }
}

//MARK:- 私有方法
extension SearchViewKit {
    func clearSearchHistory() {
        historyAry.removeAll()
        try? FileManager.default.removeItem(at: documentUrl(for: "SearchHistory.plist"))
    }
    
    func save(text: String?) {
        guard let word = text else {
            return
        }
        
        if word.isEmpty {
            return
        }
        
        if let index = historyAry.index(of: word) {
            historyAry.remove(at: index)
        }
        
        historyAry.insert(word, at: 0)
        if historyAry.count > recordCount {
            historyAry.removeLast()
        }
        saveSearchHistory()
    }
    
    func saveSearchHistory() {
        let ary = historyAry as NSArray
        ary.write(to: documentUrl(for: "SearchHistory.plist"), atomically: true)
    }
    
    func readSearchHistory() {
        let tempAry = NSArray.init(contentsOf: documentUrl(for: "SearchHistory.plist"))
        guard let ary = tempAry  else {
            historyAry = []
            return
        }
        historyAry = ary as! Array
    }
    
    func documentUrl(`for` fileName: String) -> URL {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = path + "/" + fileName
        return URL(fileURLWithPath: filePath)
    }
}
