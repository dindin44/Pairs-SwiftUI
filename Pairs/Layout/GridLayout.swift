//
//  GridLayout.swift
//  Pairs
//
//  Created by Dinesh Vijaykumar on 14/05/2020.
//  Copyright © 2020 Dinesh Vijaykumar. All rights reserved.
//

import SwiftUI

struct GridLayout<Content: View>: View {
    let rows:Int
    let columns:Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}
