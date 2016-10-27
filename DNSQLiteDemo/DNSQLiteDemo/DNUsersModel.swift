//
//  DNUsersModel.swift
//  DNSQLiteDemo
//
//  Created by mainone on 16/10/26.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

struct DNUsersModel {
    var userid: String!
    var username: String!
    var userage: String!
    var usersex: String!
    var useremail: String!
    
    init() {
        
    }
    
    init(fromDictionary dictionary: NSDictionary) {
        userid = dictionary["userid"] as? String
        username = dictionary["username"] as? String ?? "无"
        userage = dictionary["userage"] as? String ?? "0"
        usersex = dictionary["usersex"] as? String ?? "保密"
        useremail = dictionary["useremail"] as? String ?? "无"
    }
    
    
}
