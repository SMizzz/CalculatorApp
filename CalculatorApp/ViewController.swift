//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Jero on 2022/10/14.
//

import UIKit

struct Operation {
    var num1: Double = 0.0
    var num2: Double = 0.0
    var operationString: String = ""
    
    var plus: Double {
        get {
            return num1 + num2
        }
    }
}


class ViewController: UIViewController {
    var operation: Operation = Operation()
    
    var displayNumberString = ""
    var numArray: [Double] = []
    var numStringArray: [String] = []
    var operatorKey: String = ""
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
        if displayNumberString.isEmpty {
            displayNumberString = ""
        } else {
            displayNumberString += "0"
            numberLabel.text = displayNumberString
        }
    }
    
    @IBAction func pressOperationButton(_ sender: UIButton) {
        numStringArray.append(displayNumberString)
        guard let operationText = sender.titleLabel?.text else { return }
        
        switch operationText {
        case "+":
            displayNumberString = ""
            numberLabel.text = ""
            operatorKey = operationText
        case "-":
            displayNumberString = ""
            numberLabel.text = ""
            operatorKey = operationText
        case "÷":
            displayNumberString = ""
            numberLabel.text = ""
            operatorKey = operationText
        case "x":
            displayNumberString = ""
            numberLabel.text = ""
            operatorKey = operationText
        default:
            print("test")
        }
    }
    
    @IBAction func pressResultButton(_ sender: Any) {
        numStringArray.append(displayNumberString)
        
        let firstNumString: String = numStringArray[0]
        let secondNumString: String = numStringArray[1]
        
        let firstNum: Double = Double(firstNumString) ?? 0.0
        let secondNum: Double = Double(secondNumString) ?? 0.0
        
        switch operatorKey {
        case "+":
            result = firstNum + secondNum
        case "-":
            result = firstNum - secondNum
        case "÷":
            result = firstNum / secondNum
        case "x":
            result = firstNum * secondNum
        default:
            print("잘못된 연산자입니다.")
        }
        
        if result == 0 {
            numberLabel.text = "0"
        }
        
        numberLabel.text = "\(result)"
        
        displayNumberString = ""
        numStringArray.removeAll()
        result = 0
    }
}

