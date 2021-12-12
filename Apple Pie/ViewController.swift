//
//  ViewController.swift
//  Apple Pie
//
//  Created by Li Tzu Lin on 2021-12-12.
//

import UIKit



class ViewController: UIViewController {
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
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
     

    @IBOutlet var treeImageView: UIImageView!
 
    @IBOutlet var correctWordLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var letterLabels: [UIButton]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var currentGame: Game!
    
    struct Game {
        var word: String
        var incorrectMovesRemaining: Int
        var guessedLetters: [Character]
        
        mutating func playerGuessed(letter: Character) {
            guessedLetters.append(letter)
            if !word.contains(letter) {
                incorrectMovesRemaining -= 1
            }
        }
        
        var formattedWord: String {
            var guessedWord = ""
            for letter in word {
                if guessedLetters.contains(letter) {
                    guessedWord += "\(letter)"
                } else {
                    guessedWord += "_"
                }
                }
            return guessedWord
            }
        
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
        for button in letterLabels {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.titleLabel!.text!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
          } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
          } else {
              updateUI()
          }
        
    }
    
    }
    

    

