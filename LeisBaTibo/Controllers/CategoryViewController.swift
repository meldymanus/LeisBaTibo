//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Test for Word on 5/10/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var storeList: Results<Data>?
    
    var store: [String] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadItems()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        storeList = realm.objects(Data.self)
        
        store = []
        
        var n = storeList?.count
        
        for _ in storeList! {
            n = n! - 1
            if !store.contains((storeList?[n!].store)!) {
                store.append((storeList?[n!].store)!)
            }
        }
        
        loadItems()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return store.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let storeSorted = store.sorted()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = storeSorted[indexPath.row]
        
        return cell
        
    }
    
    
    func loadItems() {
        
        //     storeList = realm.objects(Data.self)
        tableView.reloadData()
        
    }
    
    //MARK: - Move To View/ Add Items Screen
    
    @IBAction func addViewButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToItem", sender: self)
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToListByStore", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let storeSorted = store.sorted()
        
        if segue.identifier == "goToListByStore" {
            let destinationVC = segue.destination as! ListByStoreViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedStore = storeSorted[indexPath.row]
            }
        }
//        else {
//            let destinationVC = segue.destination as! ToDoListViewController
//
//        }
    }
}

