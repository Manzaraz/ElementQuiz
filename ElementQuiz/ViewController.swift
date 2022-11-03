//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Christian Manzaraz on 01/11/2022.
//

import UIKit

enum Mode {
    case flashCard, quiz
}
enum State {
    case question, answer
}


class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet var modeSelector: UISegmentedControl!
    @IBOutlet var textField: UITextField!
    
    
    let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
    var currentElementIndex = 0
    
    var mode: Mode = .flashCard {
        didSet {
            updateUI()
        }
    }
    
    var state: State = .question
    
    // Quiz-specific state
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateUI()
    }
    
    func updateFlashCardUI() {
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        imageView.image = image
        
        if state == .answer {
            answerLabel.text = elementName
        } else {
            answerLabel.text = "?"
        }
        
    }

    func updateQuiz() {
        switch state {
        case .question:
            answerLabel.text = ""
        case .answer:
            if answerIsCorrect {
                answerLabel.text = "Correct!"
                print("correct")
            } else {
                answerLabel.text = "❌"
                print("❌")
            }
        }
    }
    
    func updateUI() {
        switch mode {
        case .flashCard:
            updateFlashCardUI()
        case .quiz:
            updateQuiz()
        }
    }
    
    @IBAction func showAnswer(_ sender: Any) {
//        answerLabel.text = elementList[currentElementIndex]
        state = .answer
        updateUI()
        
    }
    
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1
        if currentElementIndex >= elementList.count {
            currentElementIndex = 0
        }
        state = .question
        
        updateUI()
    }
    
    // Runs after the user hits the Return key on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFieldContents = textField.text! // Get the text form the textField
        
        // Determine whether the user answered correctly and update appropiate quiz
        // state
        if textFieldContents.lowercased() == elementList[currentElementIndex].lowercased() {
            answerIsCorrect = true
            correctAnswerCount += 1
        } else {
            answerIsCorrect = false
        }
        
        // The app should now display the answer to the user
        state = .answer
        
        updateUI()
        
        return true
    }
    @IBAction func switchModes(_ sender: Any) {
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
        } else {
            mode = .quiz
        }
    }
    
    
}

