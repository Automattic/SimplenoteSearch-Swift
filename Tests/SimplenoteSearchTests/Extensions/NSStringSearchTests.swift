import XCTest
import SimplenoteSearch


// MARK: - String Simplenote Unit Tests
//
class StringSimplenoteTests: XCTestCase {
    
    let searchSettings = SearchQuerySettings(tagsKeyword: "tag:", localizedTagKeyword: NSLocalizedString("tag:", comment: "Search Operator for tags. Please preserve the semicolons when translating!"))

    /// Verifies that `replaceLastWord(:)` returns the new word, whenever the receiver was empty
    ///
    func testReplaceLastWordReturnsJustTheNewWordWheneverTheReceiverWasEmpty() {
        let expected = "something"
        XCTAssertEqual("".replaceLastWord(with: expected), expected)
    }

    /// Verifies that `replaceLastWord(:)` effectively swaps the last word in the receiver
    ///
    func testReplaceLastWordEffectivelySwapsTheLastWordInTheReceiver() {
        let text = "one two"
        let word = "something"
        let expected = "one something"
        XCTAssertEqual(text.replaceLastWord(with: word), expected)
    }

    /// Verifies that `replaceLastWord(:)` appends the new word whenever the receiver ends up in a space
    ///
    func testReplaceLastWordAppendsNewKeywordWheneverTheReceiverEndsInSpace() {
        let text = "one "
        let word = "something"
        let expected = "one something"
        XCTAssertEqual(text.replaceLastWord(with: word), expected)
    }

    /// Verifies that Suffix after Prefix returns nil, whenever such prefix isn't to be found
    ///
    func testSuffixAfterPrefixReturnsNilWheneverTheInputStringLacksSuchPrefix() {
        let sample = "This is a sample of some random string without the tag operator"
        XCTAssertNil(sample.suffix(afterPrefix: searchSettings.tagsKeyword))
    }

    /// Verifies that Suffix after Prefix returns an empty string, whenever there is no actual Payload
    ///
    func testSuffixAfterPrefixReturnsNilWheneverTheTagSearchOperatorHasAnEmptyKeyword() {
        let sample = searchSettings.tagsKeyword
        XCTAssertEqual(sample.suffix(afterPrefix: searchSettings.tagsKeyword), "")
    }

    /// Verifies that Suffix after Prefix returns the payload right after the first occurrence of such suffix
    ///
    func testSuffixAfterPrefixReturnsTheRightHandSideStringAfterTheTagSearchOperator() {
        let expected = "somenameforatag"
        let sample = searchSettings.tagsKeyword + expected

        XCTAssertEqual(sample.suffix(afterPrefix: searchSettings.tagsKeyword), expected)
    }
}
