//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Jero on 2022/10/14.
//

import UIKit

enum CalculationOperator: String {
    case plus = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "÷"
}

struct Operation {
    var operationText: String = ""
    var num1: Double = 0.0
    var num2: Double = 0.0
        
    mutating func performOperation(_ stringArray: [String]) -> Double {
        // #1 우리는 먼저 두 가지의 요소만 받을 것이므로, array[0]과 array[1] 요소를 저장한다.
        let firstNumString: String = stringArray[0]
        let secondNumString: String = stringArray[1]

        // #2 Double타입으로 변환하여 struct에 보내줄 값을 상수에 저장한다.
        self.num1 = Double(firstNumString) ?? 0.0
        self.num2 = Double(secondNumString) ?? 0.0
        
        switch operationText {
        case CalculationOperator.plus.rawValue:
            return num1 + num2
        case CalculationOperator.minus.rawValue:
            return num1 - num2
        case CalculationOperator.multiply.rawValue:
            return num1 * num2
        case CalculationOperator.divide.rawValue:
            return num1 / num2
        default:
            print("? 없는 연산자입니다.")
            return 0.0
        }
    }
}


class ViewController: UIViewController {
    var operation = Operation()
    var displayNumberString = ""
    var numArray: [Double] = []
    var numStringArray: [String] = []
    var operatorKey: String = ""
    
    var pressOperationBtnbyUser: String = ""
    var result = 0.0
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func numberBtnTapped(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        displayNumberString += numberValue
        numberLabel.text = displayNumberString
    }
    
    @IBAction func pressAllClearButton(_ sender: Any) {
        displayNumberString = ""
        numberLabel.text = displayNumberString
        numStringArray.removeAll()
    }
    
    @IBAction func pressZeroButton(_ sender: Any) {
        displayNumberString += "0"
    }
    
    @IBAction func pressOperationButton(_ sender: UIButton) {
        numStringArray.append(displayNumberString)
    
        guard let operationText = sender.titleLabel?.text else { return }
        operation.operationText = operationText
        displayNumberString = ""
        numberLabel.text = ""
    }
    
    @IBAction func pressResultButton(_ sender: Any) {
        numStringArray.append(displayNumberString)
        
        // #1 만약 둘 중 한 숫자를 받지 못한다면 값은 0으로 넣는다.
        if numStringArray[0] == "" {
            numStringArray[0] = "0"
        } else if numStringArray[1] == "" {
           numStringArray[1] = "0"
        }
        
        result = operation.performOperation(numStringArray)
        
        // #2 #1의 경우 값을 0으로 넣었더니 결과값이 infinity가 나와서 0.0으로 바꾸어주는 역할을 한다.
        if result.isInfinite {
            result = 0.0
        }
        
        numberLabel.text = "\(result)"
        displayNumberString = ""
        numStringArray.removeAll()
        result = 0
    }
}
