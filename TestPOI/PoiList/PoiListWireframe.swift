//
//  PoiListWireframe.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//
import UIKit


// MARK: - Protocol to be defined at Wireframe
protocol PoiListNavigationHandler: class {
    // Include methods to present or dismiss
    func pushPoiDetailView( _ poiID: String)
}

class PoiListWireframe {
    weak var viewController: PoiListView?
    
    public func pushItemDetailView( _ poiID: String) {
        let vc = PoiDetailBuilder.build(poiID)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

