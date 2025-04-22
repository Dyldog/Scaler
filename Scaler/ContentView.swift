//
//  ContentView.swift
//  Scaler
//
//  Created by Dylan Elliott on 27/3/2025.
//

import SwiftUI
import DylKit

struct ContentView: View {
    @State var scale: Scale = .major
    @State var key: Note = .c
    @State var instrument: Instrument = .piano
    @State var player: NotePlayer = .init()
    
    var body: some View {
        VStack {
            scaleView
            instrumentView
        }
        .padding()
    }
    
    @ViewBuilder
    private var instrumentView: some View {
        Picker("Instrument", selection: $instrument) {
            ForEach(Instrument.allCases) { instrument in
                Text(instrument.title).tag(instrument)
            }
        }
        .labelsHidden()
        .pickerStyle(.segmented)
        
        switch instrument {
        case .piano:
            pianoView
        case .guitar:
            guitarView
        }
    }
    
    @ViewBuilder
    private var guitarView: some View {
        ScaleView(notes: scale.inTheKeyOf(key), origin: 0, width: 4)
    }
    
    private var pianoView: some View {
        KeyboardView(startNote: key, highlightedNotes: scale.inTheKeyOf(key))
    }
    
    @ViewBuilder
    private var scaleView: some View {
        HStack {
            Spacer()
            
            Picker("Scale", selection: $scale) {
                ForEach(Scale.allCases) { scale in
                    Text(scale.name).tag(scale)
                }
            }
            .labelsHidden()
            .fixedSize()
            
            Picker("Key", selection: $key) {
                ForEach(Note.allNotes) { note in
                    Text(note.name).tag(note)
                }
            }
            .labelsHidden()
            .fixedSize()
            
            Spacer()
        }
        
        HStack {
            Button(systemName: "play.fill") {
                player.play(notes: scale.inTheKeyOf(key))
            }
            
            ForEach(scale.inTheKeyOf(key)) { note in
                Text(note.name)
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    ContentView()
}
