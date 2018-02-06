//
//  PoiDetailViewModel.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import Foundation
import RxSwift

struct PoiDetailViewModel
{
    let id = Variable<String>("")
    let title = Variable<String>("")
    let geocoordinates = Variable<String>("")
    let address = Variable<String>("")
    let transport = Variable<String>("")
    let email = Variable<String>("")
    let description = Variable<String>("")
    let phone = Variable<String>("")
}
