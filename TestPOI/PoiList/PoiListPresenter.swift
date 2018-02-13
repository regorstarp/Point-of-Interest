//
//  PoiListPresenter.swift
//  TestPOI
//
//  Created by Design4 on 05/02/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//

import Foundation
import T21TableViewDataSource //pod 'T21TableViewDataSource'

// MARK: - Protocols to be defined at Presenter
protocol PoiListEventHandler: class
{
    var viewModel: PoiListViewModel { get }
    func handleViewWillAppearEvent()
    func handleViewWillDisappearEvent()
    func viewDidPullToRefresh()
    func viewDidRequestFilter(_ text: String)
}

protocol PoiListResponseHandler: class
{

    // func somethingRequestWillStart()
    // func somethingRequestDidStart()
    // func somethingRequestWillProgress()
    // func somethingRequestDidProgress()
    // func somethingRequestWillFinish()
    // func somethingRequestDidFinish()
    
    func itemsRequestDidStart()
    func itemsRequestDidFinish( _ result: [PointOfInterest])
    func itemsFilteringDidFinish(_ result: [PointOfInterest])
}

class PoiListPresenter: PoiListEventHandler, PoiListResponseHandler
{
    
    //MARK: VIPER relationships
    weak var viewController: PoiListViewUpdatesHandler?
    var interactor: PoiListRequestHandler!
    var wireframe: PoiListNavigationHandler!
    private(set) var viewModel = PoiListViewModel()

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
            let viewModel = item.value as! PoiListCellViewModel
            cell.textLabel?.text = viewModel.title
            return cell
        }
        
        dataSource.didSelectRowFunction = { [weak self] (tableView,indexPath,item) in
            guard let strongSelf = self, let viewModel = item.value as? PoiListCellViewModel else {
                return
            }
            strongSelf.wireframe.pushPoiDetailView(viewModel.id)
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
    
    func itemsRequestDidFinish( _ result: [PointOfInterest]) {
        //todo: modify the example
        
        //map entities to view models
        viewModel.items = result.map(PoiToItemListCellViewModelMapping)
        
        //add the view models creating DataSourceItems
        let rows = viewModel.items.map { (viewModel) -> DataSourceItem in
            return DataSourceItem(viewModel, viewModel.title)
        }
        self.dataSource.addItems(rows)
        self.viewController?.animatePullToRefresh(false)
    }
    
    
    func viewDidRequestFilter(_ text: String) {
        if text == "" {
            updateDataSource(viewModel.items)
        } else {
            self.interactor.filterItems(text)
        }
        
    }
    
    func updateDataSource(_ list: [PoiListCellViewModel]) {
        self.dataSource.removeAll()
        let rows = list.map { (result) -> DataSourceItem in
            return DataSourceItem(result, result.title)
        }
        self.dataSource.addItems(rows)
    }
    
    func itemsFilteringDidFinish(_ result: [PointOfInterest]) {
        updateDataSource(result.map(PoiToItemListCellViewModelMapping))
    }
    
    //MARK: Private
    
    private func mapEntitiesToViewModels( _ items: Array<String>) -> Array<PoiListCellViewModel> {
        return items.map({ (entity) -> PoiListCellViewModel in
            var vm = PoiListCellViewModel()
            vm.title = "View Model: \(entity)"
            return vm
        })
    }

}
