//
//  Scale.swift
//  Scaler
//
//  Created by Dylan Elliott on 27/3/2025.
//

import Foundation
import DylKit

typealias RootOffset = Int

struct Scale: CaseIterable, Hashable {

    let name: String
    let rootOffsets: [RootOffset]
    
    static var major: Scale = .init(name: "Major", intervals: [.T, .T, .ST, .T, .T, .T, .ST])
    static var naturalMinor: Scale = .init(name: "Natural Minor", rotating: .major, by: 5)
    static var majorPentatonic: Scale = .init(name: "Major Pentatonic", degrees: [.I, .II, .III, .V, .VI, .I], from: .major)
    static var minorPentatonic: Scale = .init(name: "Minor Pentatonic", degrees: [.I, .flattened(.III), .IV, .V, .flattened(.VII), .I], from: .major)
    static var majorBlues: Scale = .init(name: "Major Blues", degrees: [.I, .II, .flattened(.III), .III, .V, .VI, .I], from: .major)
    static var minorBlues: Scale = .init(name: "Minor Blues", degrees: [.I, .flattened(.III), .IV, .flattened(.V), .V, .flattened(.VII), .I], from: .major)
    
    static var allCases: [Scale] {
        [major, naturalMinor, majorPentatonic, minorPentatonic, majorBlues, minorBlues]
    }
    
    init(name: String, rootOffsets: [RootOffset]) {
        self.name = name
        self.rootOffsets = rootOffsets
    }
    
    init(name: String, intervals: [Interval]) {
        self.init(name: name, rootOffsets: intervals.asOffsets)
    }
    
    init(name: String, rotating scale: Scale, by: Int) {
        self.init(name: name, rootOffsets: scale.intervals.rotated(by).asOffsets)
    }
    
    init(name: String, degrees: [ScaleDegree], from scale: Scale) {
        self.init(name: name, rootOffsets: degrees.from(scale: scale))
    }
    
    var intervals: [Interval] { rootOffsets.asIntervals }
    
    func inTheKeyOf(_ key: Note) -> [Note] {
        rootOffsets.reduce([]) { partialResult, offset in
            return partialResult + [key.semitones(offset)]
        }
    }
}
