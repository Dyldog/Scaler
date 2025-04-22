//
//  Interval.swift
//  Scaler
//
//  Created by Dylan Elliott on 27/3/2025.
//

import Foundation

enum Interval {
    case tone
    case semitone
    case semitones(Int)
    
    static var T: Interval { .tone }
    static var ST: Interval { .semitone }
    static func ST(_ semitones: Int) -> Interval { .semitones(semitones) }
    
    var semitones: Int {
        switch self {
        case .semitone: 1
        case .tone: 2
        case let .semitones(semitones): semitones
        }
    }
}

extension Array where Element == Interval {
    var asOffsets: [Int] {
        reduce([0]) { partialResult, interval in
            partialResult + [partialResult.last! + interval.semitones]
        }
    }
}

extension Array where Element == RootOffset {
    var asIntervals: [Interval] {
        zip(dropLast(), dropFirst()).map { a, b in
            .semitones(b - a)
        }
    }
}
