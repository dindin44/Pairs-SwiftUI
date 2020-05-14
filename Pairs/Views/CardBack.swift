//
//  CardBack.swift
//  Pairs
//
//  Created by Dinesh Vijaykumar on 14/05/2020.
//  Copyright © 2020 Dinesh Vijaykumar. All rights reserved.
//

import SwiftUI

struct CardBack: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.blue)
            .frame(width: 140, height: 100)
            .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.white, lineWidth: 2))
    }
}

struct CardBack_Previews: PreviewProvider {
    static var previews: some View {
        CardBack()
    }
}
