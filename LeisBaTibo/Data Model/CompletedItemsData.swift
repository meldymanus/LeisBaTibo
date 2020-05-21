//
//  CompletedItemsData.swift
//  Todoey
//
//  Created by Test for Word on 5/14/20.
//

import Foundation
import RealmSwift

class CompletedItemsData: Object {
    @objc dynamic var itemName: String = ""
    @objc dynamic var brand: String = ""
    @objc dynamic var store: String = ""
    @objc dynamic var buyingQuantity: Double = 0
    @objc dynamic var estimatedPrice: Double = 0
    @objc dynamic var unitMeasurement: String = ""
    @objc dynamic var quantityForEstimatedPrice: Double = 0
    @objc dynamic var isiJikaUnitBag: Double = 0
    @objc dynamic var note: String = ""

    
    @objc dynamic var subCategory: String = ""
    @objc dynamic var salePrice: Double = 0.0
    
}
