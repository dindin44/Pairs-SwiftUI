//
//  Card.swift
//  Pairs
//
//  Created by Dinesh Vijaykumar on 14/05/2020.
//  Copyright © 2020 Dinesh Vijaykumar. All rights reserved.
//

import Foundation

struct Card: Codable {
    let id = UUID()
    let a: String
    let b: String
}
