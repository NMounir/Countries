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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return sortedCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)

        // Configure the cell...
        let city = sortedCities[indexPath.row]
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
