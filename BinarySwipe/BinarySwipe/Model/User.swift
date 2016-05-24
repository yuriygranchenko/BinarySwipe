//
//  User.swift
//  BinarySwipe
//
//  Created by Macostik on 5/24/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import Foundation

struct User {
    var id: String? = ""
    var firstName: String? = ""
    var lastName: String? = ""
    var email: String? = ""
    var location: Location?
    var balance: Float? = 0.0
    var recomendedBroker: String? = ""
    
    static let currentUser: User = User()
}

struct Location {
    var city: String
    var country: String
    
    init(location: String? = "") {
        let location = location?.componentsSeparatedByString(",")
        self.city = location?.first ?? ""
        self.country = location?.last ?? ""
    }
}
