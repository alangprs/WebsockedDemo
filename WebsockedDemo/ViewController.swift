//
//  ViewController.swift
//  WebsockedDemo
//
//  Created by 翁燮羽 on 2022/5/3.
//

import UIKit
import Starscream

class ViewController: UIViewController {

    var starscreamWebSocket = StarscreamWebSocket()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        starscreamWebSocket.connect()
    }


}

