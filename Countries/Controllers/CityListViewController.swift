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
    
    // MARK: - View Cycle
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
        
        if isFiltering(){
            return filteredCities.count
        }
        return sortedCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)

        // Configure the cell...
        var city : City?
        
        if isFiltering() {
            city = filteredCities[indexPath.row]
        }else{
            city = sortedCities[indexPath.row]
        }
        
        if let currentCity = city {
            cell.textLabel?.text = currentCity.name
            cell.detailTextLabel?.text = currentCity.country
        }
        
        return cell
    }
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                var city : City?
                //get current selected city whether in the show all cities mode or filtered mode
                if isFiltering() {
                    city = filteredCities[indexPath.row]
                }else{
                    city = sortedCities[indexPath.row]
                }
                //pass the selected city details to the details view
                if let currentCity = city, let detailsViewController = segue.destination as? CityDetailsViewController{
                    detailsViewController.city = currentCity
                }
            }
        }
    }
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
    
    func filterCitiesForSearchText(_ searchText: String, _ cityList: [City]) -> [City] {
        let cities = cityList.filter{
            $0.name.lowercased().hasPrefix(searchText.lowercased())
        }
        return cities
    }
}

extension CityListViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        guard let typedText = searchController.searchBar.text  else {
            return
        }
        //filter cities based on typed text
        filteredCities = filterCitiesForSearchText(typedText, sortedCities)
        tableView.reloadData()
    }
}
