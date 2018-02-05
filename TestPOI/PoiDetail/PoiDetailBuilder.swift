//
//  PoiDetailBuilder.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import UIKit

class PoiDetailBuilder
{
    static func build(_ poiId: String) -> UIViewController {
        let viewController = PoiDetailViewController(nibName:String(describing: PoiDetailViewController.self), bundle: nil)
        let presenter = PoiDetailPresenter()
        let interactor = PoiDetailInteractor(poiId)
        let wireframe = PoiDetailWireframe()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        wireframe.viewController = viewController
        
        _ = viewController.view //force loading the view to load the outlets
        return viewController
    }
}
