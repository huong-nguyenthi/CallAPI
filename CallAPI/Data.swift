//
//  Data.swift
//  CallAPI
//
//  Created by Nguyen Thi Huong on 8/31/20.
//  Copyright © 2020 Nguyen Thi Huong. All rights reserved.
//

import Foundation

struct DataPeople: Codable{
    let data: [DataAttribute]
}

struct DataAttribute: Codable{
    let userName: String
    let image: String
    let location: String
    let age: Int
    let gender: String
}
