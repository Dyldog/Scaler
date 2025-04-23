//
//  Instrument.swift
//  Scaler
//
//  Created by Dylan Elliott on 22/4/2025.
//

import Foundation
import DylKit

enum Instrument: Hashable, CaseIterable, Pickable {
    case piano
    case guitar
    
    var title: String {
        switch self {
        case .piano: "Piano"
        case .guitar: "Guitar"
        }
    }
}
