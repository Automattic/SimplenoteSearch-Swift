import Foundation
import SimplenoteSearch


// MARK: - MockupNote: Convenience class to help us test NSPredicate(s)
//
@objcMembers
class MockupNote: NSObject, SearchableNote {

    /// Entity's Contents
    ///
    dynamic var content: String?

    /// Deletion Status
    ///
    dynamic var deleted = false

    /// Entity's System Tags
    ///
    dynamic var systemTags: String?

    /// Entity's Tags
    ///
    dynamic var tags: String?
}
