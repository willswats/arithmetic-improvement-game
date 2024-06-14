//
//  ViewController.swift
//  ArithmeticImprovementGame
//
//  Created by Watson, William on 18/03/2022.
//

// TO DO
// - Add feedback text on correct and incorrect.
// - Ensure division does not equal a decimal.

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    @IBOutlet weak var lblFirstOperand: UILabel!
    @IBOutlet weak var lblOperation: UILabel!
    @IBOutlet weak var lblSecondOperand: UILabel!
    @IBOutlet weak var lblQuestionCounter: UILabel!
    @IBOutlet weak var lblTimeRemaining: UILabel!
    
    @IBOutlet weak var btnAnswerOne: UIButton!
    @IBOutlet weak var btnAnswerTwo: UIButton!
    @IBOutlet weak var btnAnswerThree: UIButton!
    
    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnViewScore: UIButton!
    
    var difficulty:String = ""

    var firstOperand:Int = 0
    var secondOperand:Int = 0
    var operation:String = ""
    var answer:Int = 0
    
    var totalCorrect:Int = 0
    var maxQuestions:Int = 10
    var questionCounter:Int = 1
    
    var possibleAnswerOne:Int = 0
    var possibleAnswerTwo:Int = 0
    var possibleAnswerThree:Int = 0
    
    var userAnswer:Int = 0

    var timer = Timer()
    var timerLengthInSeconds: Int = 0

    var player: AVAudioPlayer?

    func generateCalculation() {
            let operations: [String] = ["+", "-", "/", "*"]
            
            firstOperand = Int.random(in: 1..<13)
            secondOperand = Int.random(in: 1..<13)
            operation = operations.randomElement()!

            switch operation {
                case "+":
                    answer = firstOperand + secondOperand
                case "-":
                    if (firstOperand < secondOperand) {
                        let temp = secondOperand
                        secondOperand = firstOperand
                        firstOperand = temp
                    }
                    answer = firstOperand - secondOperand
                case "/":
                    if (firstOperand < secondOperand) {
                        let temp = secondOperand
                        secondOperand = firstOperand
                        firstOperand = temp
                    }
                    answer = firstOperand / secondOperand
                case "*":
                    answer = firstOperand * secondOperand
                default:
                    return
                }
    }
    
    func generatePossibleAnswers() {
        let randomNumOne = Int.random(in: 1..<51)
        let randomNumTwo = Int.random(in: 1..<51)
        
        let num = Int.random(in: 1..<4)
        
        switch num {
        case 1:
            possibleAnswerOne = randomNumOne
            possibleAnswerTwo = randomNumTwo
            possibleAnswerThree = answer
        case 2:
            possibleAnswerOne = randomNumOne
            possibleAnswerTwo = answer
            possibleAnswerThree = randomNumTwo
        case 3:
            possibleAnswerOne = answer
            possibleAnswerTwo = randomNumOne
            possibleAnswerThree = randomNumTwo
        default:
            return
        }
    }
    
    func setGameUI() {
        if (difficulty == "easy") {
            lblTimeRemaining.text = ""
            lblQuestionCounter.text = String(questionCounter)
            lblFirstOperand.text = String(firstOperand)
            lblSecondOperand.text = String(secondOperand)
            lblOperation.text = String(operation)
            btnAnswerOne.setTitle(String(possibleAnswerOne), for: .normal)
            btnAnswerTwo.setTitle(String(possibleAnswerTwo), for: .normal)
            btnAnswerThree.setTitle(String(possibleAnswerThree), for: .normal)
        } else {
            lblTimeRemaining.text = String(timerLengthInSeconds)
            lblQuestionCounter.text = String(questionCounter)
            lblFirstOperand.text = String(firstOperand)
            lblSecondOperand.text = String(secondOperand)
            lblOperation.text = String(operation)
            btnAnswerOne.setTitle(String(possibleAnswerOne), for: .normal)
            btnAnswerTwo.setTitle(String(possibleAnswerTwo), for: .normal)
            btnAnswerThree.setTitle(String(possibleAnswerThree), for: .normal)        }
    }
    
    func hideGameUI() {
        btnExit.setTitle("", for: .normal)
        btnSubmit.setTitle("", for: .normal)
        btnAnswerOne.setTitle("", for: .normal)
        btnAnswerTwo.setTitle("", for: .normal)
        btnAnswerThree.setTitle("", for: .normal)
        lblTimeRemaining.text = ""
        lblQuestionCounter.text = ""
        lblFirstOperand.text = ""
        lblSecondOperand.text = ""
        lblOperation.text = ""
    }
    
    func setTimer(seconds:Int) {
        var timeRemaining:Int = seconds
        // If timer already exists, then end it.
        timer.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            self.lblTimeRemaining.text = String(timeRemaining)
            timeRemaining-=1

                if (timeRemaining == 0) {
                    timer.invalidate()
                    self.questionCounter+=1
                    self.gameLoop()
                }
        }
    }
    
    func playSound(soundName: String, extensionType: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: extensionType) else {
                return }
            let url = URL(fileURLWithPath: path)

            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
                
            } catch let error {
                print(error.localizedDescription)
            }

       }
    
    func gameLoop() {
    switch difficulty {
    case "easy":
        if (questionCounter <= maxQuestions) {
            generateCalculation()
            generatePossibleAnswers()
            setGameUI()
        }
        else {
            hideGameUI()
            btnViewScore.isHidden = false
        }
        
    case "normal":
        timerLengthInSeconds = 20
        
        if (questionCounter <= maxQuestions) {
            setTimer(seconds: timerLengthInSeconds)
            generateCalculation()
            generatePossibleAnswers()
            setGameUI()
        }
        else {
            timer.invalidate()
            hideGameUI()
            btnViewScore.isHidden = false
        }
        
    case "hard":
        timerLengthInSeconds = 10
        
        if (questionCounter <= maxQuestions) {
            setTimer(seconds: timerLengthInSeconds)
            generateCalculation()
            generatePossibleAnswers()
            setGameUI()
        }
        else {
            timer.invalidate()
            hideGameUI()
            btnViewScore.isHidden = false
        }
        default:
            return
    }
}
        
    @IBAction func btnAnswerOneEvent(_ sender: Any) {
        userAnswer = possibleAnswerOne
    }
    
    @IBAction func btnAnswerTwoEvent(_ sender: Any) {
        userAnswer = possibleAnswerTwo
    }
    
    @IBAction func btnAnswerThreeEvent(_ sender: Any) {
        userAnswer = possibleAnswerThree
    }
    
    @IBAction func btnSubmitEvent(_ sender: Any) {
        if (userAnswer != 0) {
                    
        questionCounter+=1

        if (userAnswer == answer) {
            totalCorrect+=1;
            playSound(soundName: "HorseWhinny", extensionType: "mp3")
        } else {
            playSound(soundName: "HorseSnort", extensionType: "mp3")
        }
        gameLoop()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        gameLoop()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueScore" {
            if let destination = segue.destination as? ScoreViewController {
                destination.correct = totalCorrect
            }
        }
    }
}



