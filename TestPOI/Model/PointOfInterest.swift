//
//  File.swift
//  TestPOI
//
//  Created by Design4 on 22/01/2018.
//  Copyright © 2018 Design4. All rights reserved.
//

import Foundation

struct PointOfInterest: Decodable {
    
    var id: String = ""
    var title: String = ""
    var geocoordinates: String = ""
    var address: String = ""
    var transport: String = ""
    var email: String = ""
    var description: String = ""
    var phone: String = ""
    
//    init(id: String, title: String, geocoordinates: String) {
//        self.id = id
//        self.title = title
//        self.geocoordinates = geocoordinates
//    }
//
//    init(id: String, title: String, geocoordinates: String, address: String, transport: String, email: String, description: String, phone: String) {
//        self.id = id
//        self.title = title
//        self.geocoordinates = geocoordinates
//        self.address = address
//        self.transport = transport
//        self.email = email
//        self.description = description
//        self.phone = phone
//    }
    
}

struct Point: Decodable {
    let id: String
    let title: String
    let geocoordinates: String
}

struct PointDetail: Decodable {
    var id: String
    var title: String
    var geocoordinates: String
    var address: String
    var transport: String
    var email: String
    var description: String
    var phone: String
}

struct Root: Decodable {
    let list: [Point]
}
