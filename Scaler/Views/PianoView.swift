//
//  PianoView.swift
//  Scaler
//
//  Created by Dylan Elliott on 22/4/2025.
//

import SwiftUI

struct KeyView: View {
    enum KeyColor {
        case white
        case black
        
        var color: Color {
            switch self {
            case .white: .white
            case .black: .black
            }
        }
        
        var width: CGFloat {
            switch self {
            case .white: 1
            case .black: 0.6
            }
        }
        
        var cornerRadius: CGFloat {
            switch self {
            case .white: 0
            case .black: 10
            }
        }
    }
    
    let keyColor: KeyColor
    let highlighted: Bool
    let onTap: () -> Void
    
    var key: some View {
        func rect() -> UnevenRoundedRectangle {
            UnevenRoundedRectangle(cornerRadii: .init(
                bottomLeading: keyColor.cornerRadius,
                bottomTrailing: keyColor.cornerRadius
            ))
        }
        
        return ZStack {
            rect()
                .fill(highlighted ? .blue : keyColor.color)
            rect()
                .stroke(.black, lineWidth: 2)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(.clear)
                key
                    .frame(width: geometry.size.width * keyColor.width)
                    .onTapGesture {
                        onTap()
                    }
            }
        }
    }
}

struct KeyboardView: View {
    let startNote: Note
    let numNotes: Int
    let notes: [Note]
    let highlightedNotes: [Note]
    @State var player: NotePlayer = .init()
    
    init(startNote: Note, numNotes: Int = 12, highlightedNotes: [Note]) {
        self.startNote = startNote
        self.numNotes = numNotes
        self.highlightedNotes = highlightedNotes
        self.notes = (0 ..< numNotes).map { index in
            startNote.semitones(index)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                whiteKeys()
                blackKeys()
                    .frame(height: geometry.size.height * 0.65)
            }
            .clipped()
        }
    }
    
    private func whiteKeys() -> some View {
        HStack(spacing: 0) {
            ForEach(notes) { note in
                if !note.isSharpOrFlat {
                    KeyView(keyColor: .white, highlighted: highlightedNotes.contains(note)) {
                        noteTapped(note)
                    }
                }
            }
        }
    }
    
    private func blackKeys() -> some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                // To offset the black keys so they're in between the white keys
//                Rectangle()
//                    .fill(.clear)
//                    .frame(width: keyWidth(for: geometry.size.width) / 2)
                
                ForEach(notes) { note in
                    if note.isSharpOrFlat {
                        KeyView(keyColor: .black, highlighted: highlightedNotes.contains(note)) {
                            noteTapped(note)
                        }
                    } else if !note.semitone.isSharpOrFlat {
                        // To space out the black keys
                        // Black keys are paired with the white key before it, so we only need a spacer when there are two white keys in a row
                        ZStack {
                            Rectangle()
                                .fill(.clear)
                            //                        Rectangle()
                            //                            .stroke(.black)
                        }
                    }
                }
            }
            .offset(x: keyWidth(for: geometry.size.width) / 2)
        }
    }
    
    private func noteTapped(_ note: Note) {
        player.play(notes: [note])
    }
    
    private func keyWidth(for width: CGFloat) -> CGFloat {
        width / CGFloat(numNotes - startNote.numSharpsOrFlats(within: numNotes))
    }
}

#Preview {
    KeyboardView(startNote: .c, highlightedNotes: [.c, .d, .eFlat])
}
