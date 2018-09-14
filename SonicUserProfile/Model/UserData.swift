//
//  UserData.swift
//  SonicUserProfile
//
//  Created by user on 04/09/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import Foundation

struct Profile:Decodable{
    var section: String?
    var jobs:[UserData]?
}

struct UserData:Decodable {
    var role: String?
    var job: String?
    var dates: String?
}
