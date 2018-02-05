//
//  PoiListView.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import Foundation
import UIKit
import T21PullToRefreshController // pod 'T21PullToRefreshController'

// MARK: - Protocol to be defined at ViewController

protocol PoiListViewUpdatesHandler: class
{
    //That part should be implemented with RxSwift.
    //func updateSomeView()
    func animatePullToRefresh( _ show: Bool)
}

class PoiListView: UIViewController, PoiListViewUpdatesHandler
{
    //MARK: VIPER relationships
    
    var presenter: PoiListEventHandler!
    
    var viewModel: PoiListViewModel {
        return presenter.viewModel
    }
    
    //MARK: View Outlets
    
    @IBOutlet
    weak var tableView: UITableView?
    
    //MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()

        _ = self.tableView?.addPullToRefresh(refreshBlock: { () in
            self.presenter.viewDidPullToRefresh()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.handleViewWillAppearEvent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.handleViewWillDisappearEvent()
    }
    
    //MARK: View Interface
    
    func animatePullToRefresh( _ show: Bool) {
        if show {
            self.tableView?.startPullToRefreshAnimation()
        } else {
            self.tableView?.finishPullToRefreshAnimation()
        }
    }

    //MARK: View Private
    
    func configureBindings() {
        //Add the ViewModel bindings here ...
    }
    
}
