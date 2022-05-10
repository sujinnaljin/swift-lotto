//
//  Lotto - main.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import Foundation

do {
    //todo 로또 얼마 예산으로 살거고,, 몇개를 수동으로 뽑을거고.. 자동으로 어케 할거고 이런거 좀 모아놓는데 있으면 좋을듯
    let inputView = InputView()
    let purchaseMoney: Int = try inputView.recievePurchaseMoney()
    let manualBuyCount: Int = try inputView.recieveManualBuyCount(inBudget: purchaseMoney)
    let manualLottos: [Lotto] = try inputView.recieveManualLottos(for: manualBuyCount)
    
    let purchasableCount = purchaseMoney / Lotto.Constants.price
    let automaticBuyCount: Int = purchasableCount - manualBuyCount
    let resultView = ResultView()
    resultView.printPurchaseCount(manual: manualBuyCount, automatic: automaticBuyCount)
    let automaticLottos: [Lotto] = try buyAutomaticLottos(for: automaticBuyCount)
    
    let allLottos: [Lotto] = manualLottos + automaticLottos
    resultView.printLottos(for: allLottos)
    
    let winningLotto: Lotto = try inputView.recieveWinningLotto()
    let bonusNumber: Int = try inputView.recieveBonusNumber(in: winningLotto)
    
    let lottoResult: LottoResult = try lottoResult(lottos: allLottos,
                                                   winningLotto: winningLotto,
                                                   bonusNumber: bonusNumber)
    resultView.printWinningStatistics(with: lottoResult)
} catch {
    let errorView = ErrorView()
    errorView.printError(for: error)
}

private func buyAutomaticLottos(for purchaseCount: Int) throws -> [Lotto] {
    let lottoGenerator = LottoGenerator()
    let lottos: [Lotto] = try (1...purchaseCount)
        .map { _ in
            try lottoGenerator.generate()
        }
    return lottos
}

private func lottoResult(lottos: [Lotto],
                         winningLotto: Lotto,
                         bonusNumber: Int) throws -> LottoResult {
    
    let lottoRankChecker = try LottoRankChecker(winningLotto: winningLotto,
                                                bonusNumber: bonusNumber)
    let lottoResult = LottoResult(lottos: lottos,
                                  lottoRankChecker: lottoRankChecker)
    return lottoResult
}
