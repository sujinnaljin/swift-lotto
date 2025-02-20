//
//  LottoNumbersValidator.swift
//  Lotto
//
//  Created by 강수진 on 2022/05/06.
//

import Foundation

struct LottoNumbersValidator {
    
    enum LottoNumbersValidatorError: LocalizedError {
        case invalidNumberCount
        case containOutOfRange
        case hasDuplicate
        
        var errorDescription: String? {
            switch self {
            case .invalidNumberCount:
                return "로또 번호 개수가 6개가 아닙니다"
            case .containOutOfRange:
                return "1과 45 사이에 포함되지 않는 번호가 있습니다"
            case .hasDuplicate:
                return "중복되는 번호가 있습니다"
            }
        }
    }
    
    func validate(of numbers: [Int]) throws {
        try validateNumberCount(of: numbers)
        try numbers.forEach(validateNumberInRange)
        try validateAllUniqueNumbers(of: numbers)
    }
    
    private func validateNumberCount(of numbers: [Int]) throws {
        guard numbers.count == Lotto.Constants.numbersCount else {
            throw LottoNumbersValidatorError.invalidNumberCount
        }
    }
    
    func validateNumberInRange(of number: Int) throws {
        let isNumberInRange = Lotto.Constants.numberRange ~= number
        guard isNumberInRange else {
            throw LottoNumbersValidatorError.containOutOfRange
        }
    }
    
    func validateAllUniqueNumbers(of numbers: [Int]) throws {
        let isAllNumbersUnique = Set(numbers).count == numbers.count
        guard isAllNumbersUnique else {
            throw LottoNumbersValidatorError.hasDuplicate
        }
    }
}
