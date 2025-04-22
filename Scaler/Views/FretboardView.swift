//
//  FretboardView.swift
//  Gilly
//
//  Created by Dylan Elliott on 9/10/2023.
//

import SwiftUI

struct FretboardView: View {
    let positions: [FretPosition]
    
    var displayedSection: FretboardSection {
        positions.fretboardUsed //.expand(by: 1)
    }
    
    var body: some View {
        VStack {
            FretNumberLabels(displayedFrets: displayedSection)
                .padding(.horizontal, 10)
                .font(.body.bold())
            ZStack {
                FretsShape(displayedFrets: displayedSection)
                    .stroke(.red, style: .init(lineWidth: 5))
                    .padding(.horizontal, 10)
                StringsShape(displayedFrets: displayedSection)
                    .stroke(.blue, style: .init(lineWidth: 5))
                    .padding(.vertical, 10)
                
                ForEach(positions, id: \.self) { position in
                    FretPositionShape(position, for: displayedSection, radius: 10)
                        .fill(.green)
                        .padding(10)
                }
            }
        }
        .aspectRatio(2, contentMode: .fit)
    }
}

struct FretboardView_Previews: PreviewProvider {
    static var previews: some View {
        FretboardView(
            positions: Scale.major.inTheKeyOf(.g)
                .positions(in: .init(origin: 2, width: 5))
        )
    }
}

extension FretboardView {
    struct StringsShape: Shape {
        let numStrings: Int = GuitarString.allCases.count
        let displayedFrets: FretboardSection
        
        func path(in rect: CGRect) -> Path {
            let spacing = rect.height / CGFloat(numStrings - 1)
            
            var origin = rect.origin
            if displayedFrets.origin == 0 {
                origin = origin.translated(x: rect.width / CGFloat(displayedFrets.width))
            }
            
            return Path { path in
                (0 ..< numStrings).forEach { index in
                    path.move(
                        to: origin
                            .translated(y: spacing * CGFloat(index))
                    )
                    path.addLine(
                        to: rect.origin
                            .translated(x: rect.width)
                            .translated(y: spacing * CGFloat(index))
                    )
                }
            }
        }
    }
}

extension FretboardView {
    struct FretsShape: Shape {
        let displayedFrets: FretboardSection
        
        func path(in rect: CGRect) -> Path {
            let spacing = rect.width / CGFloat(displayedFrets.width)
            let startIndex = displayedFrets.origin == 0 ? 1 : 0
            return Path { path in
                (startIndex ... displayedFrets.width).forEach { index in
                    path.move(
                        to: rect.origin
                            .translated(x: spacing * CGFloat(index))
                    )
                    path.addLine(
                        to: .init(x: rect.minX, y: rect.maxY)
                            .translated(x: spacing * CGFloat(index))
                    )
                }
            }
        }
    }
}

extension FretboardView {
    struct FretPositionShape: Shape {
        let numStrings: Int = GuitarString.allCases.count
        let position: FretPosition
        let displayedFrets: FretboardSection
        let radius: CGFloat
        
        init(_ position: FretPosition, for displayedFrets: FretboardSection, radius: CGFloat) {
            self.position = position
            self.displayedFrets = displayedFrets
            self.radius = radius
        }

        func path(in rect: CGRect) -> Path {
            let xSpacing = rect.width / CGFloat(displayedFrets.width)
            let xIndex = position.fret - displayedFrets.origin
            let xPosition = rect.minX + xSpacing * CGFloat(xIndex) + xSpacing / 2.0
            
            let ySpacing = rect.height / CGFloat(GuitarString.allCases.count - 1)
            let yIndex = position.string.rawValue
            let yPosition = rect.minY + ySpacing * CGFloat(yIndex)
            
            return Path { path in
                path.addRelativeArc(
                    center: .init(x: xPosition, y: yPosition),
                    radius: radius,
                    startAngle: .degrees(0),
                    delta: .degrees(360)
                )
            }
        }
    }
}

extension FretboardView {
    struct FretNumberLabels: View {
        let displayedFrets: FretboardSection
        
        var visibleNumbers: [Int] { [1, 3, 5, 7, 9, 12, 15] }
        
        var body: some View {
            HStack(spacing: 5) {
                let start = displayedFrets.origin
                let stop = displayedFrets.maxFret
                ForEach(Array(start ... stop), id: \.self) { index in
                    Text(visibleNumbers.contains(index) ? "\(index)" : " ")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .background(Color.red)
                }
            }
        }
    }
}
