
import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var itemName: String = ""
    @objc dynamic var brand: String = ""
    @objc dynamic var store: String = ""
    @objc dynamic var buyingQuantity: Double = 0
    @objc dynamic var estimatedPrice: Float = 0.0
    @objc dynamic var unitMeasurement: String = ""
    @objc dynamic var quantityForEstimatedPrice: Double = 0
    @objc dynamic var isiJikaUnitBag: Double = 0
    @objc dynamic var note: String = ""
 
    
    @objc dynamic var subCategory: String = ""
    @objc dynamic var salePrice: Float = 0.0
    //@objc dynamic var picture: CIImageOption? = nil
    
    
}
