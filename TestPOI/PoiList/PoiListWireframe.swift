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

protocol PoiListNavigationHandler: class
{
    // Include methods to present or dismiss
    func pushPoiDetailView( _ poiID: String)
}

// MARK: - Wireframe Class must implement NavigationHandler Protocol to handle Presenter Navigation requests
class PoiListWireframe: PoiListNavigationHandler
{
    weak var viewController: PoiListView?
    
    func pushPoiDetailView(_ poiID: String) {
        let vc = PoiDetailBuilder.build(poiID)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
