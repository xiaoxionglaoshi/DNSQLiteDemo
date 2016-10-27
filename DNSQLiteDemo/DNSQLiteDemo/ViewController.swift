//
//  ViewController.swift
//  DNSQLiteDemo
//
//  Created by mainone on 16/10/26.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    let userManager = DNUsersInfoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 增
    @IBAction func addBtnClick(_ sender: UIButton) {
        let dic = ["userid":"1001","username":"neng","userage":"age"]
        let model = DNUsersModel(fromDictionary: dic as NSDictionary)
        
        userManager.insertUser(userModel: model)
        
    }
    
    // 删
    @IBAction func deleteBtnClick(_ sender: UIButton) {
        userManager.deleteUser(userId: "1001")
    }
    
    // 改
    @IBAction func modifyBtnClick(_ sender: UIButton) {
        let dic = ["userid":"1001","username":"xiaozhu","userage":"10"]
        let model = DNUsersModel(fromDictionary: dic as NSDictionary)
        userManager.updateUser(userId: "1001", userModel: model)
        
        userManager.updateUser(userId: "1001", userName: "nengneng")
    }
    
    // 查
    @IBAction func queryBtnClick(_ sender: UIButton) {
       let userInfo = userManager.readUser(userId: "1001")
        print(userInfo)
        
        let arr = userManager.readAllUsers()
        guard ((arr?.count)! > 0) else {
            print("空的")
            return
        }
        print(arr)
        
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

