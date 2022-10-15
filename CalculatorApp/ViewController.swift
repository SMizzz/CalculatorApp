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
    var index: [Int] = []
    var resultString = ""
    var num1: Double = 0.0
    var num2: Double = 0.0
    var result = 0.0
    var operate: [String] = ["x", "/", "+", "-"]
    
    mutating func performOperation(_ stringArray: [String]) -> Double {
        var arr = stringArray
        for oper in operate {
          for i in 0...arr.count - 1 {
            if oper == arr[i] {
              switch oper {
              case CalculationOperator.multiply.rawValue:
                  result = Double(arr[i - 1])! * Double(arr[i + 1])!
              case CalculationOperator.divide.rawValue:
                  result = Double(arr[i - 1])! / Double(arr[i + 1])!
              case CalculationOperator.plus.rawValue:
                  result = Double(arr[i - 1])! + Double(arr[i + 1])!
              case CalculationOperator.minus.rawValue:
                  result = Double(arr[i - 1])! - Double(arr[i + 1])!
                default:
                  break
              }
              resultString = String(result)
              arr[i] = resultString
              index.append(i)
            }
          }

          index.sort(by: > )
          for i in index {
            arr.remove(at: i + 1)
            arr.remove(at: i - 1)
          }
          index.removeAll()
        }
        return Double(arr[0]) ?? 0.0
    }
}

class ViewController: UIViewController {
    var operation = Operation()
    var displayNumberString = ""
    var numArray: [Double] = []
    var numStringArray: [String] = []
    var operatorKey: String = ""
    var operatorArray: [String] = []
    
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
        numStringArray.append(operationText)
        displayNumberString = ""
        numberLabel.text = ""
    }
    
    @IBAction func pressResultButton(_ sender: Any) {
        numStringArray.append(displayNumberString)
        result = operation.performOperation(numStringArray)
        
        if result.isInfinite {
            result = 0.0
        }
        
        numberLabel.text = "\(result)"
        displayNumberString = ""
        numStringArray.removeAll()
        result = 0
    }
}
