//
//  PoiListViewModel.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import Foundation

struct PoiListViewModel
{
    var items: [PoiListCellViewModel] = []
}

struct PoiListCellViewModel
{
    var id = ""
    var title = ""
    var geocoordinates = ""
}

