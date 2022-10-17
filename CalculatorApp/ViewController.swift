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
    var index: [Int] = [] // 연산자 기준으로 왼쪽과 오른쪽을 계산할 예정이므로 필요한 인덱스 위치를 저장하는 변수 배열
    var result: Double = 0.0 // Double타입의 결과를 저장할 변수
    var resultString = "" // Double타입 -> String타입으로 변환할 변수
    var operate: [String] = ["x", "÷", "+", "-"] // stringArray 배열에 있는 연산자와 비교해 계산하기 위한 연산자배열
    
    mutating func performOperation(_ stringArray: [String]) -> Double {
        // 계산하고 불필요한 요소들을 삭제하기 위해 상수인 stringArray를 변수에 저장
        var arr = stringArray
        
        while(arr.count > 1) {
            
            var oper = CalculationOperator.multiply
            
            if arr.contains("x") {
                oper = CalculationOperator.multiply
            } else if arr.contains("÷") {
                oper = CalculationOperator.divide
            } else if arr.contains("+") {
                oper = CalculationOperator.plus
            } else if arr.contains("-") {
                oper = CalculationOperator.minus
            }
            
            for i in 0...arr.count - 1 {
                if oper.rawValue == arr[i] { // 연산자 비교해서 계산
                    switch oper {
                    case CalculationOperator.multiply:
                        result = (Double(arr[i - 1]) ?? 0.0) * (Double(arr[i + 1]) ?? 0.0)
                    case CalculationOperator.divide:
                        result = (Double(arr[i - 1]) ?? 0.0) / (Double(arr[i + 1]) ?? 0.0)
                    case CalculationOperator.plus:
                        result = (Double(arr[i - 1]) ?? 0.0) + (Double(arr[i + 1]) ?? 0.0)
                    case CalculationOperator.minus:
                        result = (Double(arr[i - 1]) ?? 0.0) - (Double(arr[i + 1]) ?? 0.0)
                    }
                    
                    arr[i] = String(result)
                    arr.remove(at: i + 1)
                    arr.remove(at: i - 1)
                    
                    break
                }
            }
        }
        
        return Double(arr[0]) ?? 0.0
    }
}

class ViewController: UIViewController {
    var operation = Operation()
    var pressValueByUser: String = "" // numStringArray 배열에 넣을 데이터를 저장하는 변수
    var insertLabelString: String = "" // numLabel에 보여질 변수
    var numStringArray: [String] = []
    var result = 0.0
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func numberBtnTapped(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        pressValueByUser += numberValue
        insertLabelString += numberValue
        numberLabel.textColor = .black
        numberLabel.text = insertLabelString
    }
    
    @IBAction func pressAllClearButton(_ sender: Any) {
        pressValueByUser = ""
        insertLabelString = ""
        numberLabel.text = insertLabelString
        resultLabel.text = ""
        numStringArray.removeAll()
    }
    
    @IBAction func pressDotButton(_ sender: Any) {
        
    }
    
    @IBAction func pressZeroButton(_ sender: Any) {
        
    }
    
    @IBAction func pressOperationButton(_ sender: UIButton) {
        numStringArray.append(pressValueByUser)
        guard let operationText = sender.titleLabel?.text else { return }
        pressValueByUser += operationText
        insertLabelString += operationText
        numStringArray.append(operationText)
        
        pressValueByUser = ""
        numberLabel.text = insertLabelString
    }
    
    @IBAction func pressResultButton(_ sender: Any) {
        numStringArray.append(pressValueByUser)
        
        // 만약 사용자가 공백을 넣었을 경우
        for i in 0...numStringArray.count - 1 {
            if numStringArray[i] == "" {
                numStringArray[i] = "0"
            }
        }
        
        result = operation.performOperation(numStringArray)
        if result.isInfinite {
            result = 0.0
        }
        
        if String(result).hasSuffix(".0") {
            resultLabel.text = "\(Int(result))"
        } else {
            resultLabel.text = "\(result)"
        }
        
        numberLabel.textColor = .lightGray
        pressValueByUser = ""
        insertLabelString = ""
        numStringArray.removeAll()
        result = 0
    }
}
