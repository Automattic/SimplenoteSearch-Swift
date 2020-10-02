import Foundation


// MARK: - Internal API(s)
//
extension String {

    /// Returns the receiver's First Line
    ///
    var firstLine: String {
        guard let newlineIndex = firstIndex(of: Character("\n")) else {
            return self
        }

        return String(prefix(upTo: newlineIndex))
    }
}
