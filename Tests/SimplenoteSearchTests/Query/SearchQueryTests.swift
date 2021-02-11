import XCTest
import SimplenoteSearch

// MARK: - SearchQuery Unit Tests
//
class SearchQueryTests: XCTestCase {

    let searchSettings = SearchQuerySettings(tagsKeyword: "tag:", localizedTagKeyword: NSLocalizedString("tag:", comment: "Search Operator for tags. Please preserve the semicolons when translating!"))
    
    /// Verifies that query without a search text is empty
    ///
    func testQueryIsEmptyWhenTextIsEmpty() {
        let query = SearchQuery(searchText: "", settings: searchSettings)
        XCTAssertTrue(query.isEmpty)
    }

    /// Verifies that query with only spaces and newlines is empty
    ///
    func testQueryIsEmptyWhenTextContainsOnlySpaces() {
        let query = SearchQuery(searchText: " \n   \n\n  ", settings: searchSettings)
        XCTAssertTrue(query.isEmpty)
    }

    /// Verifies that multiple spaces between keywords are ignored
    ///
    func testQueryIgnoresSpaceBetweenKeywords() {
        let query = SearchQuery(searchText: "    a      b    ", settings: searchSettings)
        let expected: [SearchQueryItem] = [
            .keyword("a"),
            .keyword("b"),
        ]
        XCTAssertEqual(query.items, expected)
    }

    /// Verifies that keywords are being split by whitespace
    ///
    func testQuerySplitsKeywordsByWhitespace() {
        let query = SearchQuery(searchText: "a content! pre-lunch, mmmm", settings: searchSettings)
        let expected: [SearchQueryItem] = [
            .keyword("a"),
            .keyword("content!"),
            .keyword("pre-lunch,"),
            .keyword("mmmm"),
        ]
        XCTAssertEqual(query.items, expected)
    }

    /// Verifies that duplicate entries are kept
    ///
    func testQueryKeepsDuplicateKeywords() {
        let query = SearchQuery(searchText: "a a", settings: searchSettings)
        let expected: [SearchQueryItem] = [
            .keyword("a"),
            .keyword("a")
        ]
        XCTAssertEqual(query.items, expected)
    }

    /// Verifies access to all keywords and non-empty tags
    ///
    func testQueryReturnsAllKeywordsAndTags() {
        let query = SearchQuery(searchText: "a b tag:e tag: tag:f", settings: searchSettings)
        let expectedKeywords: [String] = [
            "a",
            "b"
        ]
        let expectedTags: [String] = [
            "e",
            "f"
        ]
        XCTAssertEqual(query.keywords, expectedKeywords)
        XCTAssertEqual(query.tags, expectedTags)
    }

    /// Verifies tags are extracted from a search text
    ///
    func testQueryExtractsTags() {
        let query = SearchQuery(searchText: "tag:a tag:b, keyword tag:pre-lunch", settings: searchSettings)
        let expected: [SearchQueryItem] = [
            .tag("a"),
            .tag("b,"),
            .keyword("keyword"),
            .tag("pre-lunch"),
        ]
        XCTAssertEqual(query.items, expected)
    }

    /// Verifies empty tags are kept
    ///
    func testQueryKeepsEmptyTags() {
        let query = SearchQuery(searchText: "a b tag:a tag: tag:b", settings: searchSettings)
        let expected: [SearchQueryItem] = [
            .keyword("a"),
            .keyword("b"),
            .tag("a"),
            .tag(""),
            .tag("b"),
        ]
        XCTAssertEqual(query.items, expected)
    }
}
