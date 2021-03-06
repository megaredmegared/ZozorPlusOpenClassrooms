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
    
    // MARK: - Action
    
    /// Number button tapped
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        if let number = Int(sender.currentTitle!) {
                addNewNumber(number)
        }
    }
    
    /// Decimal separator tapped
    @IBAction func decimalSeparator(_ sender: UIButton) {
        addDecimalSeparator(sender.currentTitle!)
    }
    
    /// + button tapped
    @IBAction func plus() {
        addOperator("+")
    }
    
     /// - button tapped
    @IBAction func minus() {
        addOperator("-")
    }
    
     /// x button tapped
    @IBAction func multiply() {
        addOperator("x")
    }
    
     /// ÷ button tapped
    @IBAction func divide() {
        addOperator("÷")
    }
    
     /// = button tapped
    @IBAction func equal() {
        calculateTotal()
    }
    
    /// Clear button tapped
    @IBAction func clear() {
        calculate.clear()
        textView.text = "0"
    }
    
    // MARK: - Methods
    
    /// Add operator or display error message if not possible
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
    
    /// Alert message formating
    private func alertMessage(_ message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    /// Add a new number
    private func addNewNumber(_ newNumber: Int) {
        calculate.addNewNumber(newNumber)
        updateDisplay()
    }
    
    /// Add a decimal separator or display error message if not possible
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
    
    /// Calculate the total of the operations or display error message if not possible
    private func calculateTotal() {
        do {
            let total = try calculate.total()
            textView.text = textView.text + "\n=\n\(total)"
        } catch CalculateError.expressionIncorrect {
            alertMessage("Entrez une expression correcte !")
        } catch CalculateError.expressionIncorrectStartNewOperation {
            alertMessage("Démarrez un nouveau calcul !")
        } catch CalculateError.cantDivideBy0 {
            textView.text = textView.text + "\n=\nError\nDivide by 0"
        } catch CalculateError.resultIsTooBig {
            textView.text = textView.text + "\n=\nError\nResult is too big to calculate"
        } catch {
            print("calculateTotal Unknow error")
        }
    }
    
    /// Update the display when something is tapped
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
