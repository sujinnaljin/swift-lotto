//
//  Lotto - main.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import Foundation

do {
    let inputView = InputView()
    let purchaseMoney: Int = try inputView.recievePurchaseMoney()
    let validPurchaseMoney = try validPurchaseMoney(from: purchaseMoney)

    let resultView = ResultView()
    let purchaseCount = validPurchaseMoney / Lotto.Constants.price
    resultView.drawPurchaseCount(with: purchaseCount)

    let lottos: [Lotto] = buyLottos(for: purchaseCount)
    resultView.drawLottos(for: lottos)
    
    let winningNumbers: [Int] = try inputView.recieveWinningNumbers()
    let lottoResult: LottoResult = try lottoResult(lottos: lottos, winningNumbers: winningNumbers)
    resultView.drawWinningStatistics(with: lottoResult)
} catch {
    print(error)
}

private func validPurchaseMoney(from purchaseMoney: Int) throws -> Int {
    let purchaseMoneyValidator = PurchaseMoneyValidator()
    try purchaseMoneyValidator.validate(of: purchaseMoney)
    return purchaseMoney
}

private func buyLottos(for purchaseCount: Int) -> [Lotto] {
    let lottoNumbersGenerator = LottoNumbersGenerator()
    let lottos: [Lotto] = (1...purchaseCount).map { _ in
        let lottoNumbers = lottoNumbersGenerator.generate()
        return Lotto(numbers: lottoNumbers)
    }
    return lottos
}

private func lottoResult(lottos: [Lotto],
                         winningNumbers: [Int]) throws -> LottoResult {
    
    let lottoRankChecker = try LottoRankChecker(winningNumbers: winningNumbers)
    let lottoResult = LottoResult(lottos: lottos,
                                  lottoRankChecker: lottoRankChecker)
    return lottoResult
}
