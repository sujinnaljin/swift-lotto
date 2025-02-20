//
//  LottoBonusNumberValidatorTests.swift
//  LottoTest
//
//  Created by Kang, Su Jin (강수진) on 2022/05/17.
//

import XCTest

class LottoBonusNumberValidatorTests: XCTestCase {

    var sut: LottoBonusNumberValidator!
    
    override func setUpWithError() throws {
        sut = LottoBonusNumberValidator()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - validate
    
    func test_validate() throws {
        //given
        let bonusNumber = 45
        let winningNumbers = [1,2,3,4,5,6]
        let winningLotto = try Lotto(numbers: winningNumbers)
        
        // when
        // then
        XCTAssertNoThrow(try sut.validate(bonusNumber, in: winningLotto))
    }
    
    func test_validate_whenBonusNumbersIsDuplicated_throwHasDuplicate() throws {
        //given
        let bonusNumber = 1
        let winningNumbers = [1,2,3,4,5,6]
        let winningLotto = try Lotto(numbers: winningNumbers)
        
        // then
        let expectation = LottoNumbersValidator.LottoNumbersValidatorError.hasDuplicate
        XCTAssertThrowsError(try sut.validate(bonusNumber, in: winningLotto)) { error in
            XCTAssertEqual(error as? LottoNumbersValidator.LottoNumbersValidatorError, expectation)
        }
    }
    
    func test_validate_whenBonusNumbersIsOverRanged_throwContainOutOfRange() throws {
        //given
        let bonusNumber = 46
        let winningNumbers = [1,2,3,4,5,6]
        let winningLotto = try Lotto(numbers: winningNumbers)
        
        // then
        let expectation = LottoNumbersValidator.LottoNumbersValidatorError.containOutOfRange
        XCTAssertThrowsError(try sut.validate(bonusNumber, in: winningLotto)) { error in
            XCTAssertEqual(error as? LottoNumbersValidator.LottoNumbersValidatorError, expectation)
        }
    }
}
