//
//  ContentView.swift
//  Pairs
//
//  Created by Dinesh Vijaykumar on 12/05/2020.
//  Copyright © 2020 Dinesh Vijaykumar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var deck = Deck()
    
    @State private var state = GameState.start
    @State private var firstIndex: Int?
    @State private var secondIndex: Int?
    @State private var timeRemaining = 100
    @State private var showGameWonAlert = false
    @State private var showGameOverAlert = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let rowCount = 4
    let columnCount = 6
    
    var totalScore: Int {
        let cards = self.deck.cardParts.filter{$0.state == .matched}
        return cards.count / 2
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(white: 0.3), .black]), startPoint: .top, endPoint: .bottom)
            
            VStack {
                Image(decorative: "pairs")
                
                GridLayout(rows: rowCount, columns: columnCount, content: card)
                
                Text("Time Remaining: \(timeRemaining)")
                    .font(.largeTitle)
            }
            .padding()
        }
        .onReceive(timer, perform: updateTimer)
        .alert(isPresented:$showGameOverAlert) {
            Alert(title: Text("Times Up!"), message: Text("Your final score is \(totalScore)"), primaryButton: .destructive(Text("New Game")) {
                self.timeRemaining = 100
                self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                self.deck.reset()
            }, secondaryButton: .cancel())
        }
        .alert(isPresented:$showGameWonAlert) {
            Alert(title: Text("Game Won!"), message: Text("Your final score is \(totalScore)"), primaryButton: .destructive(Text("New Game")) {
                self.timeRemaining = 100
                self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                self.deck.reset()
            }, secondaryButton: .cancel())
        }
    }
    
    func card(at row: Int, column:Int) -> some View {
        let index = (row * columnCount) + column
        let part = deck.cardParts[index]
        
        return CardView(cardPart: part)
            .accessibility(addTraits: .isButton)
            .accessibility(label: Text(part.text))
            .onTapGesture {
            self.flip(index)
        }
    }
    
    func flip(_ index: Int) {
        guard deck.cardParts[index].state == .unflipped else { return }
        guard secondIndex == nil else { return }
        
        switch state {
        case .start:
            withAnimation {
                self.firstIndex = index
                self.deck.set(index, to: .flipped)
                self.state = .firstFlipped
            }
        case .firstFlipped:
            withAnimation {
                self.secondIndex = index
                self.deck.set(index, to: .flipped)
                self.checkMatches()
            }
        }
    }
    
    func match() {
        guard let firstIndex = firstIndex, let secondIndex = secondIndex else {
            fatalError("There must be two flipped cards before matching")
        }
        
        withAnimation {
            deck.set(firstIndex, to: .matched)
            deck.set(secondIndex, to: .matched)
        }
        
        reset()
    }
    
    func noMatch() {
        guard let firstIndex = firstIndex, let secondIndex = secondIndex else {
            fatalError("There must be two flipped cards before no match")
        }
        
        withAnimation {
            deck.set(firstIndex, to: .unflipped)
            deck.set(secondIndex, to: .unflipped)
        }
        
        reset()
    }
    
    func reset() {
        firstIndex = nil
        secondIndex = nil
        state = .start
    }
    
    func checkMatches() {
        guard let firstIndex = firstIndex, let secondIndex = secondIndex else {
            fatalError("There must be two flipped cards before checking match")
        }
        
        if deck.cardParts[firstIndex].id == deck.cardParts[secondIndex].id {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.match()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.noMatch()
            }
        }
    }
    
    func updateTimer(_ currentTime: Date) {
        let unmatchedItems = self.deck.cardParts.filter{$0.state != .matched}
        guard unmatchedItems.count > 0  else {
            // Game has been won
            showGameWonAlert = true
            self.timer.upstream.connect().cancel()
            return
        }
        
        if self.timeRemaining > 0 {
            self.timeRemaining -= 1
        } else {
            showGameOverAlert = true
            self.timer.upstream.connect().cancel()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
