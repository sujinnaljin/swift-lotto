//
//  InputView.swift
//  Lotto
//
//  Created by 강수진 on 2022/05/07.
//

import Foundation

struct InputView {
    
    private enum QuestionText: UserInformable {
        case purchaseMoney
        case manualBuyCount
        case manualNumbers
        case winningNumbers
        case bonusNumber
        
        var guideDescription: String {
            switch self {
            case .purchaseMoney:
                return "구입금액을 입력해 주세요."
            case .manualBuyCount:
                return "수동으로 구매할 로또 수를 입력해 주세요."
            case .manualNumbers:
                return "수동으로 구매할 번호를 입력해 주세요."
            case .winningNumbers:
                return "지난 주 당첨 번호를 입력해 주세요."
            case .bonusNumber:
                return "보너스 번호를 입력해주세요"
            }
        }
    }
    
    private let userGuider = UserGuider()
    private let stringConverter = StringConverter()
    private let userInputConverter = UserInputConverter()
    private let purchaseMoneyValidator = PurchaseMoneyValidator()
    private let lottoNumbersValidator = LottoNumbersValidator()
    
    func recievePurchaseMoney() throws -> Int {
        userGuider.printGuide(for: QuestionText.purchaseMoney)
        let purchaseMoney = try recieveInt()
        try purchaseMoneyValidator.validate(of: purchaseMoney)
        return purchaseMoney
    }
    
    func recieveManualBuyCount(inBudget purchaseMoney: Int) throws -> Int {
        userGuider.printGuide(for: QuestionText.manualBuyCount)
        
        let manualBuyCount = try recieveInt()
        //todo 0 이랑 purchaseMoney/1000 사이여야함
        return manualBuyCount
    }
    
    func recieveManualLottos(for manualBuyCount: Int) throws -> [Lotto] {
        userGuider.printGuide(for: QuestionText.manualNumbers)
        
        //todo manualButyCount 는 1 이상
        let lottos: [Lotto] = try (1...manualBuyCount).map { _ -> Lotto in
            let lotto: Lotto = try recieveLotto()
            return lotto
        }
        return lottos
    }
    
    func recieveWinningLotto() throws -> Lotto {
        userGuider.printGuide(for: QuestionText.winningNumbers)
        
        let lotto: Lotto = try recieveLotto()
        return lotto
    }
    
    private func recieveLotto() throws -> Lotto {
        let userInput: String? = readLine()
        let unwrappedUserInput: String = try stringConverter.unwrapOptional(from: userInput)
        let lottoNumbers: [Int] = try userInputConverter.convertToLottoNumbers(from: unwrappedUserInput)
        let lotto = try Lotto(numbers: lottoNumbers)
        return lotto
    }
    
    func recieveBonusNumber(in winningLotto: Lotto) throws -> Int {
        userGuider.printGuide(for: QuestionText.bonusNumber)
        let bonusNumber = try recieveInt()
        try lottoNumbersValidator.validateBonusNumber(bonusNumber, in: winningLotto)
        return bonusNumber
    }
    
    private func recieveInt() throws ->  Int {
        let userInput: String? = readLine()
        let unwrappedUserInput: String = try stringConverter.unwrapOptional(from: userInput)
        let userInputInt = try userInputConverter.convertToInt(from: unwrappedUserInput)
        return userInputInt
    }
}
