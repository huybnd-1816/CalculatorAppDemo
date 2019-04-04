//
//  ViewController.swift
//  CalculatorApp
//
//  Created by mac on 4/2/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit

enum Operator {
    case mutiply
    case divide
    case plus
    case subtract
}

class ViewController: UIViewController {

    @IBOutlet var btnNumberActions: [UIButton]!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var btnAC: UIButton!
    @IBOutlet var btnOperatorsAction: [UIButton]!
    
    var tempValue: Double?
    var currentOperator: Operator?
    var check = true //If user press button Equal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func handleACtapped(_ sender: Any) {
        lblResult.text = "0"
        check = true
        tempValue = 0.0
        currentOperator = nil
        resetState()
    }
    
    @IBAction func handleNumbersTapped(_ sender: UIButton) {
        if (sender.tag == 0 && lblResult.text?.first == "0"){
            return
        }
        
        guard (lblResult.text?.count)! < 11 else { return }
        
        if (lblResult.text == "0"){
            lblResult.text = lblResult.text?.replacingOccurrences(of: "0", with: String(sender.tag))
        }
        else if check{
            lblResult.text?.append(String(sender.tag))
        }
        else{
            lblResult.text = ""
            lblResult.text?.append(String(sender.tag))
            check = true
        }
    }
    
    
    @IBAction func handleOperatorTapped(_ sender: UIButton) {
        tempValue = Double(lblResult.text!)
        check = false
        
        resetState()
        
        switch sender {
        case btnOperatorsAction[0]:
            currentOperator = Operator.plus
        case btnOperatorsAction[1]:
            currentOperator = Operator.subtract
        case btnOperatorsAction[2]:
            currentOperator = Operator.mutiply
        case btnOperatorsAction[3]:
            currentOperator = Operator.divide
        default:
            print("Error")
        }
        sender.backgroundColor = .black
    }
    
    @IBAction func handleEqualTapped(_ sender: Any) {
        check = false
        guard let tempValue = tempValue else { return }
        guard currentOperator != nil else { return }
        let currentResult = Double(lblResult.text!)!
        let finalResult:Double?
        
        switch currentOperator! {
            case .plus:
                finalResult = tempValue + currentResult
            case .subtract:
                finalResult = tempValue - currentResult
            case .mutiply:
                finalResult = tempValue * currentResult
            case .divide:
                guard lblResult.text != "0" else {
                    lblResult.text = "Error"
                    return
                }
            
                finalResult = (tempValue / currentResult)
        }
        
        lblResult.text = removeTrailingZero(temp: finalResult!)
        
        resetState()
    }
    
    @IBAction func handleDotTapped(_ sender: Any) {
        if !(lblResult.text?.contains("."))!{
            if (!check){
                lblResult.text = "0"
            }
            lblResult.text?.append(".")
            check = true
        }
    }
    
    @IBAction func handlePosNegTapped(_ sender: Any) {
        var number:Double = Double(lblResult.text!)!
        
        if (number > 0.0 || number < 0.0){
            number = -number;
        }
        
        lblResult.text = removeTrailingZero(temp: number)
    }
    
    @IBAction func handlePercentageTapped(_ sender: Any) {
        var number:Double = Double(lblResult.text!)!
        
        if (number != 0.0){
            number = number / 100
            lblResult.text = removeTrailingZero(temp: number)
        }
    }
}

extension ViewController {
    //TODO: Round Double value
    func removeTrailingZero(temp: Double) -> String {
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
    
    //TODO: Return Original State
    func resetState()
    {
        btnOperatorsAction[0].backgroundColor = UIColor(red: 247/255, green: 146/255, blue: 49/255, alpha: 1.0)
        btnOperatorsAction[1].backgroundColor = UIColor(red: 247/255, green: 146/255, blue: 49/255, alpha: 1.0)
        btnOperatorsAction[2].backgroundColor = UIColor(red: 247/255, green: 146/255, blue: 49/255, alpha: 1.0)
        btnOperatorsAction[3].backgroundColor = UIColor(red: 247/255, green: 146/255, blue: 49/255, alpha: 1.0)
    }
}
