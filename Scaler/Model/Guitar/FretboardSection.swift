//
//  FretboardSection.swift
//  Gilly
//
//  Created by Dylan Elliott on 9/10/2023.
//

import Foundation

struct FretboardSection {
    let origin: Int
    let width: Int
    
    var maxFret: Int { origin + width - 1 }
    
    func contains(fret: Int) -> Bool {
        return fret >= origin && fret <= maxFret
    }
}

extension FretboardSection {
    static var zero: FretboardSection { .init(origin: 0, width: 0) }
    
    func expand(by amount: Int) -> FretboardSection {
        .init(origin: max(0, origin - amount), width: width + 2 * amount)
    }
    
    func position(for note: Note, from string: GuitarString) -> FretPosition? {
        let remainingStrings = GuitarString.allCases.dropFirst(string.rawValue)
        for string in remainingStrings {
            let noteFret = note.innerNote.distance(from: string.note)
            if self.contains(fret: noteFret) {
                return .init(string: string, fret: noteFret)
            }
        }
        
        return nil
    }
}

extension Array where Element == Note {
    func positions(in section: FretboardSection) -> [FretPosition] {
        return self.reduce(into: [], { result, note in
            let latestString = result.last??.string ?? .e
            result.append(section.position(for: note, from: latestString))
        }).compactMap { $0 }
    }
}
