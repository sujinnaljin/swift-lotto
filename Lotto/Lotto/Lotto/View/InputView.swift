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
        case winningNumbers
        case bonusNumber
        
        var guideDescription: String {
            switch self {
            case .purchaseMoney:
                return "구입금액을 입력해 주세요."
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
    private let lottoBonusNumberValidator = LottoBonusNumberValidator()
    
    func receivePurchaseMoney() throws -> Int {
        userGuider.printGuide(for: QuestionText.purchaseMoney)
        let purchaseMoney = try receiveInt()
        try purchaseMoneyValidator.validate(of: purchaseMoney)
        return purchaseMoney
    }
    
    func receiveWinningLotto() throws -> Lotto {
        userGuider.printGuide(for: QuestionText.winningNumbers)
        
        let userInput: String? = readLine()
        let unwrappedUserInput: String = try stringConverter.unwrapOptional(from: userInput)
        let winningNumbers = try userInputConverter.convertToWinningNumbers(from: unwrappedUserInput)
        let winningLotto = try Lotto(numbers: winningNumbers)
        return winningLotto
    }
    
    func receiveBonusNumber(in winningLotto: Lotto) throws -> Int {
        userGuider.printGuide(for: QuestionText.bonusNumber)
        let bonusNumber = try receiveInt()
        try lottoBonusNumberValidator.validate(bonusNumber, in: winningLotto)
        return bonusNumber
    }
    
    private func receiveInt() throws ->  Int {
        let userInput: String? = readLine()
        let unwrappedUserInput: String = try stringConverter.unwrapOptional(from: userInput)
        let userInputInt = try userInputConverter.convertToInt(from: unwrappedUserInput)
        return userInputInt
    }
}
