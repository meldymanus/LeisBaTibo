

import UIKit
import RealmSwift

class PopOverForm: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let realm = try! Realm()
    
    var items: Results<Data>?
    
    let numbers = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    let unitMeasurement = ["ct","lb","oz","dozen","piece","bunch","kg","gr"]
    
    var unitMeasurementSelected = "ct"
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var store: UITextField!
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var estimatedPrice: UITextField!
    @IBOutlet weak var quantityPriceTag: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var buyingQuantity: UITextField!
    
    
    @IBOutlet weak var buyingUnit: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        buyingUnit.text = "ct"
        
        

    }

    @IBAction func addItemButtonPressed(_ sender: UIButton) {
        
        let newItem = Data()
        
        newItem.store = store.text!
        newItem.itemName = itemName.text!
        newItem.brand = brand.text!
        newItem.estimatedPrice = Double(estimatedPrice.text!)!
        newItem.buyingQuantity = Double(buyingQuantity.text!)!
        newItem.note = note.text!
        newItem.quantityForEstimatedPrice = Double(quantityPriceTag.text!)!
        newItem.unitMeasurement = unitMeasurementSelected
        
        
        self.saveItems(itemArray: newItem)
        
        dismiss(animated: true) {
           
        }
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func saveItems(itemArray: Data) {
        do {
            try realm.write {
                realm.add(itemArray)
            }
        } catch {
            print("Error Saving Item \(error)")
        }
    }
    
    
    //MARK: - Picker View Delegate and Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitMeasurement.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        unitMeasurementSelected = unitMeasurement[row]
        
        buyingUnit.text = unitMeasurement[row]
        
        print(unitMeasurement[row])

    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Times New Roman", size: 15)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = unitMeasurement[row]
        pickerLabel?.textColor = UIColor.blue

        return pickerLabel!
    }
    
    //MARK: - Reload Presenting VC
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//
//        if let firstVC = presentingViewController as? ToDoListViewController {
//            DispatchQueue.main.async {
//                firstVC.tableView.reloadData()
//            }
//        }
//    }
    


}
