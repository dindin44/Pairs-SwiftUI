//
//  CardFront.swift
//  Pairs
//
//  Created by Dinesh Vijaykumar on 14/05/2020.
//  Copyright © 2020 Dinesh Vijaykumar. All rights reserved.
//

import SwiftUI

struct CardFront: View {
    var cardPart: CardPart

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(cardPart.state == .matched ? Color.green : Color.white)
            .frame(width: 140, height: 100)
            .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.white, lineWidth: 2))
            
            Text(cardPart.text)
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

struct CardFront_Previews: PreviewProvider {
    static var previews: some View {
        CardFront(cardPart: CardPart(id: UUID(), text: "test"))
    }
}
