//
//  mapper.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright © 2018 Design4. All rights reserved.
//

import Foundation
import T21Mapping

func PoiToItemListCellViewModelMapping(pointOfInterest: PointOfInterest) -> PoiListCellViewModel {
    var viewModel = PoiListCellViewModel()
    viewModel.id = pointOfInterest.id
    viewModel.title = pointOfInterest.title
    viewModel.geocoordinates = pointOfInterest.geocoordinates
    return viewModel
}
