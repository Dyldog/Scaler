//
//  Guitar.swift
//  Gilly
//
//  Created by Dylan Elliott on 9/10/2023.
//

import Foundation

enum GuitarString: Int, CaseIterable {
    case e
    case a
    case d
    case g
    case b
    case highE
    
    var note: Note {
        switch self {
        case .e: return .e
        case .a: return .a
        case .d: return .d
        case .g: return .g
        case .b: return .b
        case .highE: return .e
        }
    }
}
