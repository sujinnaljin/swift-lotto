//
//  StringSplitterTests.swift
//  LottoTest
//
//  Created by 강수진 on 2022/05/04.
//

import XCTest

class StringSplitterTests: XCTestCase {

    var sut: StringSplitter!
    
    override func setUpWithError() throws {
        sut = StringSplitter()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_splitComponents() throws {
        //given
        let input: String = "1,2,3"
        let separator: Character = ","
        
        // when
        let result: [String] = sut.split(input, by: separator)
        
        // then
        let expectation: [String] = ["1", "2", "3"]
        XCTAssertEqual(result, expectation)
    }
}
