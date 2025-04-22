//
//  FretPosition.swift
//  Gilly
//
//  Created by Dylan Elliott on 9/10/2023.
//

import Foundation

struct FretPosition: Hashable, Equatable {
    let string: GuitarString
    let fret: Int
}

extension FretPosition {
    var note: Note {
        string.note.semitones(fret)
    }
}
