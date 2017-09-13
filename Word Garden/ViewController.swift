//
//  ViewController.swift
//  Word Garden
//
//  Created by Jimmy McDermott on 9/13/17.
//  Copyright © 2017 162 LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var guessedLetterField: UITextField!
    @IBOutlet private weak var userGuessLabel: UILabel!
    @IBOutlet private weak var guessCountLabel: UILabel!
    @IBOutlet private weak var playAgainButton: UIButton!
    @IBOutlet private weak var guessLetterButton: UIButton!
    @IBOutlet private weak var flowerImageView: UIImageView!
    
    private var lettersGuessed = ""
    private var wordToGuess = "CODE"
    private let maxNumberOfWrongGuesses = 8
    private var wrongGuessesRemaining = 8
    private var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    
    private func updateUIAfterGuess() {
        guessLetterButton.isEnabled = false
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    private func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord += " _"
            }
        }
        
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    private func guessALetter() {
        guessCount = guessCount + 1
        formatUserGuessLabel()
        
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        
        let revealedWord = userGuessLabel.text!
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "So sorry, you're all out of guesses. Try again?"
        } else if !revealedWord.contains("_") {
            // You've won a game!
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You've got it! It took you \(guessCount) guesses to guess the word!"
        } else {
            //update our guess count
            let guess = (guessCount == 1 ? "guess" : "guesses")
            guessCountLabel.text = "You've Made \(guessCount) \(guess)"
        }
    }
    
    @IBAction private func guessLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction private func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction private func guessLetterTapped(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction private func playAgainButtonTapped(_ sender: UIButton){
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = #imageLiteral(resourceName: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've Made 0 Guesses."
        guessCount = 0
    }
}
