//
//  PoiListBuilder.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import UIKit

class PoiListBuilder
{
    static func build() -> UIViewController {
        let viewController = PoiListView(nibName:String(describing: PoiListView.self), bundle: nil)
        let presenter = PoiListPresenter()
        let interactor = PoiListInteractor()
        let wireframe = PoiListWireframe()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        wireframe.viewController = viewController
        
        _ = viewController.view //force loading the view to load the outlets
        presenter.dataSource.tableView = viewController.tableView // link the dataSource object with the tableView

        return viewController
    }
}
