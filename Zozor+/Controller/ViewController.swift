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
    
    // MARK: - Outlets
    
    @IBOutlet weak var textView: UITextView!
    // TODO: No need for this outlet ?
    @IBOutlet var numberButtons: [UIButton]!
    
    // MARK: - Action
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        if let number = Int(sender.currentTitle!) {
                addNewNumber(number)
        }
    }
    
    @IBAction func decimalSeparator(_ sender: UIButton) {
        addDecimalSeparator(sender.currentTitle!)
    }
    
    @IBAction func plus() {
        addOperator("+")
    }
    
    @IBAction func minus() {
        addOperator("-")
    }
    
    @IBAction func multiply() {
        addOperator("x")
    }
    
    @IBAction func divide() {
        addOperator("÷")
    }
    
    @IBAction func equal() {
        calculateTotal()
    }
    
    
    // MARK: - Methods
    private func addOperator(_ newOperator: String) {
        do {
            try calculate.addNewOperator(newOperator)
            updateDisplay()
        } catch CalculateError.cantAddOperator {
            alertMessage("Expression incorrecte !")
        } catch {
            print("addOperator Unknow error")
        }
    }
    
    private func alertMessage(_ message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    private func addNewNumber(_ newNumber: Int) {
        calculate.addNewNumber(newNumber)
        updateDisplay()
    }
    
    private func addDecimalSeparator(_ separator: String) {
        do {
            try calculate.addDecimalSeparator(separator)
            
        } catch CalculateError.cantAddDecimalSeparator {
            alertMessage("Il y a déjà une virgule")
        } catch {
            print("addDecimalSeparator Unknow error")
        }
        updateDisplay()
    }
    
    private func calculateTotal() {
        do {
            let total = try calculate.total()
            textView.text = textView.text + "=\(total)"
        } catch CalculateError.expressionIncorrect {
            if calculate.stringNumbers.count == 1 {
                alertMessage("Démarrez un nouveau calcul !")
            } else {
                alertMessage("Entrez une expression correcte !")
            }
        } catch CalculateError.cantDivideBy0 {
            textView.text = textView.text + "= Error Divide by 0"
        } catch {
            print("calculateTotal Unknow error")
        }
    }
    
    private func updateDisplay() {
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
}
