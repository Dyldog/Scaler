//
//  Array+FretPosition.swift
//  Gilly
//
//  Created by Dylan Elliott on 9/10/2023.
//

import Foundation

extension Array where Element == FretPosition {
    var fretboardUsed: FretboardSection {
        guard
            let minimum = self.min(by: { $0.fret < $1.fret })?.fret,
            let maximum = self.max(by: { $0.fret < $1.fret })?.fret
        else { return .zero }
        
        return .init(origin: minimum, width: (maximum - minimum) + 1)
    }
}
