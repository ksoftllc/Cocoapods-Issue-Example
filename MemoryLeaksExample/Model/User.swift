//
//  User.swift
//  MemoryLeaksExample
//
//  Created by Chuck Krutsinger on 2/14/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import UIKit

typealias Name = String

struct User {
    let username: Username
    //for demo purposes always use same info regardless of username
    let first: Name = "Chuck"
    let last: Name = "Krutsinger"
    let profilePicture = UIImage(named: "profilePicture")
}
