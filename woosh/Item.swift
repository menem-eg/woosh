//
//  Item.swift
//  woosh
//
//  Created by Abdelmonem Shaker on 14/02/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
