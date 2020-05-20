
import UIKit
import RealmSwift
import SwipeCellKit

class ListByStoreViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var storeItems: Results<Data>?
    
    var selectedStore: String?
    //    {
    //            didSet {
    //                loadItems()
    //            }
    //        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ToDoListViewController.back(sender:)))
        newBackButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = newBackButton
        
        self.navigationItem.title = selectedStore!
        
        loadItems()
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    //MARK: - TableView Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return storeItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.tableView.rowHeight = 60.0
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListByStoreCell", for: indexPath) as! SwipeTableViewCell
        
        //         if storeItems?[indexPath.row].store == selectedStore {
        
        cell.detailTextLabel?.numberOfLines = 0

        
        cell.textLabel?.text = "\(storeItems?[indexPath.row].itemName  ?? "No Categories added yet") - $\(String(storeItems![indexPath.row].estimatedPrice) ?? "N/A")/\(String(storeItems![indexPath.row].quantityForEstimatedPrice) ?? "N/A")\(String(storeItems![indexPath.row].unitMeasurement) ?? "N/A")"
        
        cell.detailTextLabel?.text = "\(storeItems?[indexPath.row].brand ?? "N/A"), at \(storeItems?[indexPath.row].store ?? "N/A")"
        
        let label1 = UILabel.init(frame: CGRect(x:0,y:0,width:75,height:20))
                label1.textColor = UIColor.blue
        label1.textAlignment = .right
        label1.adjustsFontSizeToFitWidth = true
        label1.font = .boldSystemFont(ofSize: 18)
                
                var cost: Double = 0.0
                cost = storeItems![indexPath.row].buyingQuantity / storeItems![indexPath.row].quantityForEstimatedPrice * storeItems![indexPath.row].estimatedPrice

        //        var unitString: Double = 0.0
        //        unitString = items![indexPath.row].unitMeasurement
                
        //        var costString: String = String(format:"%f", cost!)
                label1.text = "$\(String(cost) ?? "N/A")"  // (\(String(storeItems![indexPath.row].buyingQuantity) ?? "N/A") \(storeItems![indexPath.row].unitMeasurement ?? "N/A"))"
                
//                cell.accessoryView = label1
        
        let label2 = UILabel.init(frame: CGRect(x:0,y:0,width:75,height:60))
                label2.textColor = UIColor.blue
        label2.textAlignment = .right
        label2.adjustsFontSizeToFitWidth = true
        label2.font = .boldSystemFont(ofSize: 12)
                
//                var cost2: Double = 0.0
//                cost2 = storeItems![indexPath.row].buyingQuantity / storeItems![indexPath.row].quantityForEstimatedPrice * storeItems![indexPath.row].estimatedPrice

        //        var unitString: Double = 0.0
        //        unitString = items![indexPath.row].unitMeasurement
        //        var costString: String = String(format:"%f", cost!)
                label2.text = "(\(String(storeItems![indexPath.row].buyingQuantity) ?? "N/A") \(storeItems![indexPath.row].unitMeasurement ?? "N/A"))"
                
//                cell.view = label2
        
       
        

        let container = UIView(frame: CGRect(x:0,y:0,width:75,height:40))
        container.addSubview(label1)
        container.addSubview(label2)
        cell.accessoryView = container
            
        
        
        //Ternary operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        //       cell.accessoryType = item.done == true ? .checkmark : .none
        
        // code above (cell.accessoryType = item.done == true ? .checkmark : .none) to replace 5 lines code below
        //        if item.done == true {
        //            cell.accessoryType = .checkmark
        //        } else {
        //            cell.accessoryType = .none
        //        }
        
        cell.delegate = self
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods: Delete Item
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = storeItems?[indexPath.row] {
            
            var textFieldStore = UITextField()
            var textFieldItemName = UITextField()
            var textFieldBrand = UITextField()
            var textFieldestimatedPrice = UITextField()
            var textFieldSalePrice = UITextField()
            var textFieldSaleNote = UITextField()
            
            let alert = UIAlertController(title: "Edit Your Item", message: "", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let action = UIAlertAction(title: "Save Change", style: .default) { (action) in
                
                //What will happen once the user clicks the Add item button on our UIAlert
                
                if let textFieldStoreSafe = textFieldStore.text {
                    if textFieldStoreSafe != "" {
                        if let textFieldItemNameSafe = textFieldItemName.text {
                            if textFieldItemNameSafe != "" {
                                if let textFieldBrandSafe = textFieldBrand.text {
                                    if textFieldBrandSafe != "" {
                                        if let textFieldestimatedPriceSafe = textFieldestimatedPrice.text {
                                            if textFieldestimatedPriceSafe != "" {
                                                if let textFieldSalePriceSafe = textFieldSalePrice.text {
                                                    if textFieldSalePriceSafe != "" {
                                                        if let textFieldSaleNoteSafe = textFieldSaleNote.text {
                                                            if textFieldSaleNoteSafe != "" {
                                                                
                                                                
                                                                if let item = self.storeItems?[indexPath.row] {
                                                                    do {
                                                                        try self.realm.write {
                                                                            item.store = textFieldStore.text!
                                                                            item.itemName = textFieldItemName.text!
                                                                            item.brand = textFieldBrand.text!
                                                                            item.estimatedPrice = Double(textFieldestimatedPrice.text!)!
                                                                            item.salePrice = Double(textFieldSalePrice.text!)!
                                                                            item.note = textFieldSaleNote.text!
                                                                        }
                                                                    } catch {
                                                                        print("Error Saving Edited Items: \(error)")
                                                                    }
                                                                }
                                                                self.tableView.reloadData()
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    print("error")
                }
                
            }
            
            
            alert.addTextField { (alertTextField) in
                alertTextField.insertText(item.store)
                textFieldStore = alertTextField
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.insertText(item.itemName)
                textFieldItemName = alertTextField
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.insertText(item.brand)
                textFieldBrand = alertTextField
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.insertText(String(item.estimatedPrice))
                textFieldestimatedPrice = alertTextField
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.insertText(String(item.salePrice))
                textFieldSalePrice = alertTextField
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.insertText(item.note)
                textFieldSaleNote = alertTextField
            }
            
            alert.addAction(action)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func loadItems() {
        
        storeItems = realm.objects(Data.self)
        storeItems = storeItems?.filter("store CONTAINS %@", selectedStore!).sorted(byKeyPath: "itemName", ascending: true)
        tableView.reloadData()
    }
    
    @IBAction func completeShoppingButtonPressed(_ sender: UIButton) {

        
    }
    
}

//MARK: - Swipe Cell Delegate Method

extension ListByStoreViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            if let item = self.storeItems?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(item)
                    }
                    
                } catch {
                    print("Error deleting item: \(error)")
                }
            }
            
            tableView.reloadData()
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    
    
}
