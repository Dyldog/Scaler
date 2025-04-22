//
//  ScaleDegree.swift
//  Scaler
//
//  Created by Dylan Elliott on 27/3/2025.
//

import Foundation

indirect enum ScaleDegree {
    case I
    case II
    case III
    case IV
    case V
    case VI
    case VII
    case flattened(ScaleDegree)
    case augmented(ScaleDegree)
    
    var index: Int {
        switch self {
        case .I: 0
        case .II: 1
        case .III: 2
        case .IV: 3
        case .V: 4
        case .VI: 5
        case .VII: 6
        case let .flattened(degree), let .augmented(degree): degree.index
        }
    }
    
    var modifier: Int {
        switch self {
        case .flattened: return -1
        case .augmented: return 1
        default: return 0
        }
    }
    
    func from(scale: Scale) -> Int {
        (scale.rootOffsets[index] + modifier) % Note.allNotes.count
    }
}

extension Array where Element == ScaleDegree {
    func from(scale: Scale) -> [RootOffset] {
        map {
            $0.from(scale: scale)
        }
    }
}
