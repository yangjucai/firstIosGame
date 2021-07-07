//
//  ViewController.swift
//  aGame
//
//  Created by yangjucai on 2021/7/6.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    var flipCount: Int = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!

    @IBOutlet var cardButtons: [UIButton]!
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards )
    
    var numberOfPairsOfCards: Int{
        get{
            return (cardButtons.count + 1) / 2
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        //flipCard(withEmoji: "👻", on: sender)
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
   
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.2256685425, green: 0.2992465844, blue: 1, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻","🎃","🦋","🐶","🐄","🐈","🧚🏼‍♂️"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String{
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
    
    
    


}

