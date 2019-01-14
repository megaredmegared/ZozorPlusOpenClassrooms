//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var calculate = Calculate()

//    var index = 0 // not used ?????

    var isExpressionCorrect: Bool {
        if let stringNumber = calculate.stringNumbers.last {
            if stringNumber.isEmpty {
                if calculate.stringNumbers.count == 1 {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                } else {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
                return false
            }
        }
        return true
    }

    var canAddOperator: Bool {
        if let stringNumber = calculate.stringNumbers.last {
            if stringNumber.isEmpty {
                let alertVC = UIAlertController(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
                return false
            }
        }
        return true
    }


    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            print("\(i): '\(numberButton)'")
            if sender == numberButton {
                addNewNumber(i)
            }
        }
    }

    @IBAction func plus() {
        if canAddOperator {
        	calculate.operators.append("+")
        	calculate.stringNumbers.append("")
            updateDisplay()
        }
    }

    @IBAction func minus() {
        if canAddOperator {
            calculate.operators.append("-")
            calculate.stringNumbers.append("")
            updateDisplay()
        }
    }
    
    @IBAction func multiply() {
        if canAddOperator {
            calculate.operators.append("x")
            calculate.stringNumbers.append("")
            updateDisplay()
        }
    }
    
    @IBAction func divide() {
        if canAddOperator {
            calculate.operators.append("÷")
            calculate.stringNumbers.append("")
            updateDisplay()
        }
    }
    
    @IBAction func equal() {
        calculateTotal()
    }


    // MARK: - Methods

    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = calculate.stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            calculate.stringNumbers[calculate.stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }

    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
        let total = calculate.total()
        textView.text = textView.text + "=\(total)"

        clear()
    }

    func updateDisplay() {
        var text = ""
        for (i, stringNumber) in calculate.stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += calculate.operators[i]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }

    func clear() {
        calculate.stringNumbers = [String()]
        calculate.operators = ["+"]
//        index = 0
    }
}
