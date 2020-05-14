//
//  Deck.swift
//  Pairs
//
//  Created by Dinesh Vijaykumar on 14/05/2020.
//  Copyright © 2020 Dinesh Vijaykumar. All rights reserved.
//

import Foundation

class Deck: ObservableObject {
    let allCards: [Card] = Bundle.main.decode("capitals.json")
    var cardParts = [CardPart]()
    
    init() {
        let selectedCards = allCards.shuffled().prefix(12)
        for card in selectedCards {
            cardParts.append(CardPart(id: card.id, text: card.a))
            cardParts.append(CardPart(id: card.id, text: card.b))
        }
        
        cardParts.shuffle()
    }
    
    func set(_ index: Int, to state: CardState) {
        cardParts[index].state = state
        objectWillChange.send()
    }
}
