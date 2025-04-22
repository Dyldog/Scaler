//
//  ContentView.swift
//  Gilly
//
//  Created by Dylan Elliott on 9/10/2023.
//

import SwiftUI

struct ScaleView: View {
    @State var origin: Int
    @State var width: Int
    let notes: [Note]
    
    init(notes: [Note], origin: Int, width: Int) {
        self.notes = notes
        self.origin = origin
        self.width = width
    }
    
    var body: some View {
        VStack {
            FretboardView(
                positions: notes.positions(in: .init(origin: origin, width: width))
            )
            
            HStack {
                Spacer()
                positionToolbar
                Spacer()
                sizeToolbar
                Spacer()
            }
        }
    }
    
    private var sizeToolbar: some View {
        HStack {
            Button {
                width = max(0, width - 1)
            } label: {
                Image(systemName: "arrowtriangle.right.and.line.vertical.and.arrowtriangle.left.fill")
            }
            
            Button {
                width = width + 1
            } label: {
                Image(systemName: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right.fill")
            }
            
        }
    }
    
    private var positionToolbar: some View {
        HStack {
            Button {
                origin = max(0, origin - 1)
            } label: {
                Image(systemName: "arrow.left")
            }
            
            Button {
                origin = origin + 1
            } label: {
                Image(systemName: "arrow.right")
            }
            
        }
    }
}
