//
//  File.swift
//  TestPOI
//
//  Created by Design4 on 22/01/2018.
//  Copyright © 2018 Design4. All rights reserved.
//

import Foundation

struct PointOfInterest: Decodable, Equatable {
    let id: String
    let title: String
    let geocoordinates: String
}

struct PointDetail: Codable, Equatable {
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
    let list: [PointOfInterest]
}
