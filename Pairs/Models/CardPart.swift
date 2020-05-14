//
//  CardPart.swift
//  Pairs
//
//  Created by Dinesh Vijaykumar on 14/05/2020.
//  Copyright © 2020 Dinesh Vijaykumar. All rights reserved.
//

import Foundation

struct CardPart {
    let id:UUID
    let text: String
    var state = CardState.unflipped
}
