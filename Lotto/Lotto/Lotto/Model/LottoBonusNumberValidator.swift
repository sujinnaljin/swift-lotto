//
//  LottoBonusNumberValidator.swift
//  Lotto
//
//  Created by Kang, Su Jin (강수진) on 2022/05/17.
//

import Foundation

struct LottoBonusNumberValidator {
    
    static func validate(_ bonusNumber: LottoNumber, in winningLotto: Lotto) throws {
        let winningNumbersWithBonus = winningLotto.numbers + [bonusNumber]
        try LottoValidator.validateAllUniqueNumbers(of: winningNumbersWithBonus)
    }
}
