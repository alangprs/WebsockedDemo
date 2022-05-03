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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetUp()
        starscreamWebSocket.connect()
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
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(DisplayTableViewCell.self)", for: indexPath) as? DisplayTableViewCell else {
            print("table get dequeueReusableCell error ")
            return UITableViewCell()
        }
        
        cell.myConvertCell(time: "測", price: "試", quantity: "看看")
        
        return cell
    }
    
    
}

