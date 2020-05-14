//
//  Bundle+JSONFile.swift
//  Pairs
//
//  Created by Dinesh Vijaykumar on 14/05/2020.
//  Copyright © 2020 Dinesh Vijaykumar. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T:Decodable>(_ filename: String) -> T {
        guard let url = self.url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(filename) from bundle")
        }
        
        guard let loaded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to decode \(filename) from bundle")
        }
        
        return loaded
    }
}
