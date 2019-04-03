//
//  ViewController.swift
//  CalculatorApp
//
//  Created by mac on 4/2/19.
//  Copyright © 2019 sunasterisk. All rights reserved.
//

import UIKit

enum Operator {
    case Mutiply
    case Divide
    case Plus
    case Subtract
}

class ViewController: UIViewController {

    @IBOutlet var btnNumberActions: [UIButton]!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var btnAC: UIButton!
    @IBOutlet var btnOperatorsAction: [UIButton]!
    
    var tempValue : Double?
    var currentOperator:Operator?
    var check = true //If user press button Equal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnAC_Clicked(_ sender: Any) {
        lblResult.text = "0"
        check = true
        tempValue = 0.0
        currentOperator = nil
        ReturnToOriginalState()
    }
    
    @IBAction func btnNumberActions_Clicked(_ sender: UIButton) {
        if (sender.tag == 0 && lblResult.text?.first == "0")
        {
            return
        }
        
        guard (lblResult.text?.count)! < 11 else { return }
        
        if (lblResult.text == "0")
        {
            lblResult.text = lblResult.text?.replacingOccurrences(of: "0", with: String(sender.tag))
        }
        else if (check)
        {
            lblResult.text?.append(String(sender.tag))
        }
        else
        {
            lblResult.text = ""
            lblResult.text?.append(String(sender.tag))
            check = true
        }
    }
    
    
    @IBAction func btnOperators_Clicked(_ sender: UIButton) {
        tempValue = Double(lblResult.text!)
        check = false
        
        ReturnToOriginalState()
        
        switch sender {
        case btnOperatorsAction[0]:
            currentOperator = Operator.Plus
            btnOperatorsAction[0].backgroundColor = .black
        case btnOperatorsAction[1]:
            currentOperator = Operator.Subtract
            btnOperatorsAction[1].backgroundColor = .black
        case btnOperatorsAction[2]:
            currentOperator = Operator.Mutiply
            btnOperatorsAction[2].backgroundColor = .black
        case btnOperatorsAction[3]:
            currentOperator = Operator.Divide
            btnOperatorsAction[3].backgroundColor = .black
        default:
            print("Error")
        }
    }
    
    @IBAction func btnEqual_Clicked(_ sender: Any) {
        check = false
        
        guard currentOperator != nil else { return }
        let currentResult = Double(lblResult.text!)!
        let finalResult:Double?
        
        switch currentOperator! {
            case .Plus:
                finalResult = tempValue! + currentResult
            case .Subtract:
                finalResult = tempValue! - currentResult
            case .Mutiply:
                finalResult = tempValue! * currentResult
            case .Divide:
                guard lblResult.text != "0" else {
                    lblResult.text = "Error"
                    return
                }
            
                finalResult = (tempValue! / currentResult)
        }
        
        lblResult.text = forTrailingZero(temp: finalResult!)
        
        tempValue = 0.0
        currentOperator = nil
        ReturnToOriginalState()
    }
    
    @IBAction func btnDot_Clicked(_ sender: Any) {
        if !(lblResult.text?.contains("."))!
        {
            if (!check)
            {
                lblResult.text = "0"
            }
            lblResult.text?.append(".")
            check = true
        }
    }
    
    @IBAction func btnPosNeg_Clicked(_ sender: Any) {
        var number:Double = Double(lblResult.text!)!
        
        if (number > 0.0 || number < 0.0)
        {
            number = -number;
        }
        
        lblResult.text = forTrailingZero(temp: number)
    }
    
    @IBAction func btnPercentage_Clicked(_ sender: Any) {
        var number:Double = Double(lblResult.text!)!
        
        if (number != 0.0)
        {
            number = number / 100
            lblResult.text = forTrailingZero(temp: number)
        }
    }
}

extension ViewController {
    //TODO: Round Double value
    func forTrailingZero(temp: Double) -> String {
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
    
    //TODO: Return Original State
    func ReturnToOriginalState()
    {
        btnOperatorsAction[0].backgroundColor = UIColor(red: 247/255, green: 146/255, blue: 49/255, alpha: 1.0)
        btnOperatorsAction[1].backgroundColor = UIColor(red: 247/255, green: 146/255, blue: 49/255, alpha: 1.0)
        btnOperatorsAction[2].backgroundColor = UIColor(red: 247/255, green: 146/255, blue: 49/255, alpha: 1.0)
        btnOperatorsAction[3].backgroundColor = UIColor(red: 247/255, green: 146/255, blue: 49/255, alpha: 1.0)
    }
}
