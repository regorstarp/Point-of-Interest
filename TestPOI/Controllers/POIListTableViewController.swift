//
//  POIListTableViewController.swift
//  TestPOI
//
//  Created by Design4 on 22/01/2018.
//  Copyright © 2018 Design4. All rights reserved.
//

import UIKit
import MBProgressHUD

class POIListTableViewController: UITableViewController {
    
    var requester: Requester = Requester()
    var poiList = [Point]()
    var result: Bool = false
    var selectedPoint: PointOfInterest?
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPoi = [Point]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Points of Interest"
        MBProgressHUD.showAdded(to: ((UIApplication.shared.delegate?.window)!)!, animated: true)
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Points"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchPointsOfInterest()
    }

    //set the Poi list
    func fetchPointsOfInterest() {
        
        requester.fetchPointsOfInterestJSON { (result) in
            
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
            }
            
            switch result {
            case .success(let points):
                self.poiList = points
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let err):
                print("Failed to fetch points:", err)
                let alert = UIAlertController(title: "Couldn't load the points", message: "", preferredStyle: .alert)
                let acceptAction = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(acceptAction)
                self.present(alert, animated: true)
            }
        }
    }
    
    func fetchPointOfInterest(for pointId: String) {
        MBProgressHUD.showAdded(to: ((UIApplication.shared.delegate?.window)!)!, animated: true)
        
        requester.requestPointOfInterest(for: pointId, completion: { (result) in
            
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
            }
            
            switch result {
            case .success(let pointDetail):
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as? POIDetailViewController else { return }
                vc.selectedPOI = pointDetail
                
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let err):
                print("Failed to fetch point:", err)
                let alert = UIAlertController(title: "Couldn't load the selected point", message: "", preferredStyle: .alert)
                let acceptAction = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(acceptAction)
                self.present(alert, animated: true)
            }
        })
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

        let pointId: String
        
        if isFiltering() {
            pointId = "\(filteredPoi[indexPath.row].id)"
        } else {
            pointId = "\(indexPath.row + 1)"
        }
        
        fetchPointOfInterest(for: pointId)
    }
    
    // MARK: - SearchBar
    // TODO: move searchBar logic to separate class
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPoi = poiList.filter({( point : Point) -> Bool in
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

