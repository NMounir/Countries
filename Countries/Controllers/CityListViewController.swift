//
//  CityListViewController.swift
//  Countries
//
//  Created by Nora Mounir on 6/23/18.
//  Copyright © 2018 nmounir. All rights reserved.
//

import UIKit

class CityListViewController: UITableViewController {
    
    var sortedCities = [City]()
    var filteredCities = [City]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        JsonParser(fileName: "cities")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - JSON Handling
    fileprivate func JsonParser(fileName:String){
        
        //get the json file url with the provided file name and extension
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else{
            return
        }
        
        do{
            //load the json file
            let data = try Data(contentsOf: url)
            //decoding the json file into an array of cities
            let citiesList = try JSONDecoder().decode([City].self, from: data)
            sortedCities = citiesList.sorted{($0.name, $0.country) < ($1.name, $1.country)}
            
            //initially setting up the filtered cities list equals to sorted cities list
            filteredCities = sortedCities
            
            //reload table after sorting the cities in alphabetical order
            tableView.reloadData()
            
        } catch let parsingError {
            print ("Error Parsing: ", parsingError)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)

        // Configure the cell...
        let city = filteredCities[indexPath.row]
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = city.country
        return cell
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Filtering Handling
extension CityListViewController {
    // MARK: - Search UI Setup
    func setupSearchController(){
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
     // MARK: - Search Helper
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    // MARK: - Search Results
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterCitiesForSearchText(_ searchText: String, scope: String = "All") {
        filteredCities = sortedCities.filter({( city : City) -> Bool in
            return city.name.lowercased().hasPrefix(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

extension CityListViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        guard let typedText = searchController.searchBar.text  else {
            return
        }
        //filter cities based on typed text
        filterCitiesForSearchText(typedText)
    }
}
