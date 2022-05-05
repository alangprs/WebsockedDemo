//
//  ViewController.swift
//  WebsockedDemo
//
//  Created by 翁燮羽 on 2022/5/3.
//

import UIKit
import Starscream

class ViewController: UIViewController {

    @IBOutlet weak var displayTableView: UITableView!
    
    var starscreamWebSocket = StarscreamWebSocket()
    var datas = [DataClass]() {
        didSet {
            displayTableView.reloadData()
            removeCount()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetUp()
        starscreamWebSocket.connect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        starscreamWebSocket.didData = { [weak self] (data) in
            self?.datas.insert(contentsOf: data, at: 0)
            
        }
    }
    
    ///remove超過的資料
    func removeCount() {
        if datas.isEmpty == false,
           datas.count > 40 {
            for relist in 40 ... datas.count - 1  {
                datas.remove(at: relist)
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableViewSetUp() {
        displayTableView.delegate = self
        displayTableView.dataSource = self
        
        let xib = UINib(nibName: "\(DisplayTableViewCell.self)", bundle: nil)
        displayTableView.register(xib, forCellReuseIdentifier: "\(DisplayTableViewCell.self)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(DisplayTableViewCell.self)", for: indexPath) as? DisplayTableViewCell else {
            print("table get dequeueReusableCell error ")
            return UITableViewCell()
        }
        
        let cellItem = datas[indexPath.item]
        
        cell.myConvertCell(time: cellItem.dataE, price: cellItem.p, quantity: cellItem.q)
        
        return cell
    }
    
    
}

