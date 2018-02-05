//
//  PoiDetailWireframe.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import UIKit

// MARK: - Protocol to be defined at Wireframe
protocol PoiDetailNavigationHandler: class
{
    // Include methods to present or dismiss
    func popItemDetailView()
}

// MARK: - Wireframe Class must implement NavigationHandler Protocol to handle Presenter Navigation calls
class PoiDetailWireframe: PoiDetailNavigationHandler
{
    weak var viewController: PoiDetailViewController?
    
    public func popItemDetailView() {
        _ = viewController?.navigationController?.popViewController(animated: true)
    }
}
