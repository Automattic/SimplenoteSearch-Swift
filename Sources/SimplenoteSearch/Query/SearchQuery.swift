import Foundation

// MARK: SearchQuery: wraps a search text
//
@objc
public final class SearchQuery: NSObject {

    /// Original search text
    ///
    @objc
    public let searchText: String

    /// A boolean value indicating if the query is empty
    ///
    @objc
    public var isEmpty: Bool {
        return items.isEmpty
    }

    /// Ordered list of query items found in a search text
    ///
    private(set) public var items: [SearchQueryItem] = []

    /// Tags found in a search text
    ///
    @objc
    public var tags: [String] {
        return items.compactMap {
            guard case let .tag(value) = $0, !value.isEmpty else {
                return nil
            }

            return value
        }
    }

    /// Keywords found in a search text
    ///
    @objc
    public var keywords: [String] {
        return items.compactMap {
            guard case let .keyword(value) = $0 else {
                return nil
            }

            return value
        }
    }

    /// Init with a search text
    ///
    @objc
    public init(searchText: String) {
        self.searchText = searchText
        super.init()
        parse()
    }

    private func parse() {
        let keywords = searchText.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespaces)

        for keyword in keywords where keyword.isEmpty == false {
            guard let tag = checkForTagOrLocalizedTag(with: keyword) else {
                items.append(.keyword(keyword))
                continue
            }
            
            items.append(.tag(tag))
        }
    }
    
    private func checkForTagOrLocalizedTag(with keyword: String) -> String? {
        if let tag = keyword.lowercased().suffix(afterPrefix: String.searchOperatorForTags.tagsKeyword.lowercased()) {
            return tag
        }
        if let tag = keyword.lowercased().suffix(afterPrefix: String.searchOperatorForTags.localizedTagKeyword.lowercased()) {
            return tag
        }
        
        return nil
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? SearchQuery else {
            return false
        }

        return items == object.items
    }
}

public struct SearchQuerySettings {
    public let tagsKeyword: String
    public let localizedTagKeyword: String
    
    public init(tagsKeyword: String, localizedTagKeyword: String) {
        self.tagsKeyword = tagsKeyword
        self.localizedTagKeyword = localizedTagKeyword
    }
}

public extension SearchQuerySettings {
    static var shared: SearchQuerySettings {
        SearchQuerySettings(tagsKeyword: "tag:",
                            localizedTagKeyword: NSLocalizedString("tag:", comment: "Search Operator for tags. Please preserve the semicolons when translating!"))
    }
}
