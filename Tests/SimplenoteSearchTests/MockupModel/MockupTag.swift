import Foundation
import SimplenoteSearch


// MARK: - MockupTag: Convenience class to help us test NSPredicate(s)
//
@objcMembers
class MockupTag: NSObject, SearchableTag {

    /// Entity's System Tags
    ///
    dynamic var name: String?
}
