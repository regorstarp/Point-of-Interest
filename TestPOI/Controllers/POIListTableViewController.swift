//
//  POIListTableViewController.swift
//  TestPOI
//
//  Created by Design4 on 22/01/2018.
//  Copyright © 2018 Design4. All rights reserved.
//

import UIKit

class POIListTableViewController: UITableViewController {
    
    var requester: Requester = Requester()
    var poiList = [PointOfInterest]()
    var result: Bool = false
    var selectedPoint: PointOfInterest?
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPoi = [PointOfInterest]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Points of Interest"

        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Points"
        navigationItem.searchController = searchController

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        navigationController?.navigationBar.prefersLargeTitles = true
        initializeThePoiList()
    }

    //set the Poi list
    func initializeThePoiList() {
        requester.requestPointsOfInterest { (result: Bool, list: [PointOfInterest]) in
            if result {
                self.poiList = list
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: UITableView DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let title: String
        
        if isFiltering() {
            title = filteredPoi[indexPath.row].title
        } else {
           title = poiList[indexPath.row].title
        }
        cell.textLabel?.text = title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredPoi.count
        }
        
        return poiList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? POIDetailViewController {
            let pointId: String
            
            if isFiltering() {
                pointId = "\(filteredPoi[indexPath.row].id)"
            } else {
                pointId = "\(indexPath.row + 1)"
            }
            requester.requestPointOfInterest(id: pointId) { (result: Bool, point: PointOfInterest) in
                if result {
                    vc.selectedPOI = point
                } else {
                    print("error requesting point with id: \(pointId)")
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
    // MARK: - SearchBar
    // TODO: move searchBar logic to separate class
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPoi = poiList.filter({( point : PointOfInterest) -> Bool in
            return point.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

}

extension POIListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
