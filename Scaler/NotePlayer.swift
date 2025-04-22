//
//  NotePlayer.swift
//  Scaler
//
//  Created by Dylan Elliott on 27/3/2025.
//

import Foundation
import AudioToolbox

class NotePlayer {
    func play(notes: [Note]) {
        play(midiIDs: notes.octaves.midiIDs)
    }
    
    func play(note: Note, after afterNote: Note) {
        
    }
    
    private func play(midiIDs: [UInt8]) {
        var sequence : MusicSequence? = nil
        var musicSequence = NewMusicSequence(&sequence)

        var track : MusicTrack? = nil
        var musicTrack = MusicSequenceNewTrack(sequence!, &track)

        // Adding notes

        var time = MusicTimeStamp(1.0)
        for index: UInt8 in midiIDs { // C4 to C5
            var note = MIDINoteMessage(channel: 0,
                                       note: index,
                                       velocity: 64,
                                       releaseVelocity: 0,
                                       duration: 1.0 )
            musicTrack = MusicTrackNewMIDINoteEvent(track!, time, &note)
            time += 1
        }

        // Creating a player

        var musicPlayer : MusicPlayer? = nil
        var player = NewMusicPlayer(&musicPlayer)

        player = MusicPlayerSetSequence(musicPlayer!, sequence)
        player = MusicPlayerStart(musicPlayer!)
    }
}

extension Note {
    var midiID: UInt8 {
        UInt8(rawValue + 56)
    }
}

extension Array where Element == Note {
    var midiIDs: [UInt8] {
        map { $0.midiID }
    }
}

extension Array where Element == Array<Note> {
    var midiIDs: [UInt8] {
        enumerated().flatMap { octave, notes in
            notes.map { UInt8(octave * 12) + $0.midiID}
        }
    }
}
