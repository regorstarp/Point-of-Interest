//
//  listPresenter.swift
//  TestPOI
//
//  Created by Design4 on 22/01/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import Foundation
import T21TableViewDataSource //pod 'T21TableViewDataSource'

// MARK: - Protocols to be defined at Presenter
protocol listEventHandler: class
{
    var viewModel: listViewModel { get }
    func handleViewWillAppearEvent()
    func handleViewWillDisappearEvent()
    func viewDidPullToRefresh()
}

protocol listResponseHandler: class
{
    // func somethingRequestWillStart()
    // func somethingRequestDidStart()
    // func somethingRequestWillProgress()
    // func somethingRequestDidProgress()
    // func somethingRequestWillFinish()
    // func somethingRequestDidFinish()
    
    func itemsRequestDidStart()
    func itemsRequestDidFinish( _ result: Array<String>)
}

class listPresenter: listEventHandler, listResponseHandler
{
    
    //MARK: VIPER relationships
    weak var viewController: listViewUpdatesHandler?
    var interactor: listRequestHandler!
    var wireframe: listNavigationHandler!
    private(set) var viewModel = listViewModel()

    //MARK: Private Vars
    var dataSource = TableViewDataSource<DataSourceItem>()
    private var wasShown = false

    //MARK: Initializers
    
    init() {
        
        dataSource.onTableViewDidSetFunction = { (tableView) in
            tableView?.rowHeight = UITableViewAutomaticDimension
            tableView?.estimatedRowHeight = 44
            
            //tableView?.register(UINib.init(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCellIdentifier")
        }
        
        dataSource.heightForRowFunction = { (tableView, indexPath, item) in
            return UITableViewAutomaticDimension
        }
        
        dataSource.cellForRowFunction = {(tableView,indexPath,item) in
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            let viewModel = item.value as! listCellViewModel
            cell.textLabel?.text = viewModel.title
            return cell
        }
        
        dataSource.didSelectRowFunction = { [weak self] (tableView,indexPath,item) in
            let viewModel = item.value as! listCellViewModel
            //self?.wireframe?.pushItemDetailView()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    //MARK: View Handler
    
    func handleViewWillAppearEvent() {
        //todo: modify the example
        if !wasShown {
            wasShown = true
            self.interactor.requestItems()
        }
    }
    
    func handleViewWillDisappearEvent() {
        //todo:
    }
    
    func viewDidPullToRefresh() {
        self.interactor.requestItems()
    }
    
    //MARK: Interactor Handler
    
    func itemsRequestDidStart() {
        //todo: show loading feedback
        self.viewController?.animatePullToRefresh(true)
    }
    
    func itemsRequestDidFinish( _ result: Array<String>) {
        //todo: modify the example
        
        //map entities to view models
        viewModel.items = mapEntitiesToViewModels(result)
        
        //add the view models creating DataSourceItems
        let rows = viewModel.items.map { (viewModel) -> DataSourceItem in
            return DataSourceItem(viewModel, viewModel.title)
        }
        self.dataSource.addItems(rows)
        self.viewController?.animatePullToRefresh(false)
    }
    
    //MARK: Private
    
    private func mapEntitiesToViewModels( _ items: Array<String>) -> Array<listCellViewModel> {
        return items.map({ (entity) -> listCellViewModel in
            var vm = listCellViewModel()
            vm.title = "View Model: \(entity)"
            return vm
        })
    }

}
