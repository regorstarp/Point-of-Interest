//
//  listBuilder.swift
//  TestPOI
//
//  Created by Design4 on 22/01/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import UIKit

class listBuilder
{
    static func build() -> UIViewController {
        let viewController = listView(nibName:String(describing: listView.self), bundle: nil)
        let presenter = listPresenter()
        let interactor = listInteractor()
        let wireframe = listWireframe()
        
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
