//
//  ViewController.swift
//  Apple Pie
//
//  Created by Daryl Zandvliet on 07/11/2018.
//  Copyright © 2018 Daryl Zandvliet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandenscent", "bug", "program"]
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        
        updateGameState()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newRound()
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
        enableLetterButtons(true)
        updateUI()
            
        } else {
            enableLetterButtons(false)
        }
    }
        
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons{
            button.isEnabled = enable
        }
        
    }

    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func showVictoryAlert() {
        let alert = UIAlertController(title: "Congrats! You won :)", message: "The new game will start in a moment", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
    func showFailAlert() {
        let alert = UIAlertController(title: "Better luck next time!", message: "The new game will start in a moment", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
            showFailAlert()
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            showVictoryAlert()
            }
        else {
            updateUI()
        }
        
}

}


