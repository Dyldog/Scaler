//
//  Note.swift
//  Scaler
//
//  Created by Dylan Elliott on 27/3/2025.
//

import Foundation

indirect enum Note: Hashable {
    case aFlat
    case a
    case bFlat
    case b
    case c
    case cSharp
    case d
    case eFlat
    case e
    case f
    case fSharp
    case g
    case nth(Note, Int)
    
    var innerNote: Note {
        switch self {
        case let .nth(note, _): note
        default: self
        }
    }
    
    static var allNotes: [Note] { [.aFlat, .a, .bFlat, .b, .c, .cSharp, .d, .eFlat, .e, .f, .fSharp, .g] }
    
    init(rawValue: Int) {
        let noteIndex = rawValue % Self.allNotes.count
        let note = Self.allNotes[noteIndex]
        let octave = (rawValue - noteIndex) / Self.allNotes.count
        
        if octave == 0 {
            self = note
        } else {
            self = .nth(note, octave)
        }
    }
    
    var rawValue: Int {
        switch self {
        case .aFlat: 0
        case .a: 1
        case .bFlat: 2
        case .b: 3
        case .c: 4
        case .cSharp: 5
        case .d: 6
        case .eFlat: 7
        case .e: 8
        case .f: 9
        case .fSharp: 10
        case .g: 11
        case let .nth(note, octave): note.rawValue + octave * Self.allNotes.count
        }
    }
    
    var name: String {
        switch self {
        case .aFlat: "Ab"
        case .a: "A"
        case .bFlat: "Bb"
        case .b: "B"
        case .c: "C"
        case .cSharp: "C#"
        case .d: "D"
        case .eFlat: "Eb"
        case .e: "E"
        case .f: "F"
        case .fSharp: "F#"
        case .g: "G"
        case let .nth(note, _): note.name
        }
    }
    
    var semitone: Note {
        semitones(1)
    }
    
    var tone: Note {
        semitone.semitone
    }
    
    func interval(_ interval: Interval) -> Note {
        semitones(interval.semitones)
    }
    
    func semitones(_ count: Int) -> Note {
        .init(rawValue: (rawValue + count))
    }
}

extension Note {
    var isSharpOrFlat: Bool {
        switch self {
        case .a, .b, .c, .d, .e, .f, .g: false
        case let .nth(note, _): note.isSharpOrFlat
        default: true
        }
    }
    
    func numSharpsOrFlats(within semitones: Int) -> Int {
        (0 ..< semitones).reduce(0) { count, index in
            count + (self.semitones(index).isSharpOrFlat ? 1 : 0)
        }
    }
}

extension Note {
    func distance(from root: Note) -> Int {
        guard root != self else { return 0 }
        
        if root.rawValue < self.rawValue {
            return self.rawValue - root.rawValue
        } else {
            return self.nextOctave.distance(from: root)
        }
    }
    
    var nextOctave: Note {
        switch self {
        case let .nth(note, octave): return .nth(note, octave + 1)
        default: return .nth(self, 1)
        }
    }
    
}

extension Note: Comparable {
    static func < (lhs: Note, rhs: Note) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

extension Array where Element == Note {
    var octaves: [[Note]] {
        var lastNote: Note!
        var octaves: [[Note]] = [[]]
        for note in self {
            if lastNote == nil { lastNote = note }
            
            if note < lastNote {
                octaves.append([])
            }
            
            octaves[octaves.count - 1].append(note)
            
            lastNote = note
        }
        
        return octaves
    }
}
