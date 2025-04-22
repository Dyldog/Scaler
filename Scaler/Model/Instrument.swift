//
//  Instrument.swift
//  Scaler
//
//  Created by Dylan Elliott on 22/4/2025.
//

import Foundation

enum Instrument: Hashable, CaseIterable {
    case piano
    case guitar
    
    var title: String {
        switch self {
        case .piano: "Piano"
        case .guitar: "Guitar"
        }
    }
}
