//
//  CGPoint+Offset.swift
//  Gilly
//
//  Created by Dylan Elliott on 9/10/2023.
//

import Foundation

extension CGPoint {
    func translated(x xOffset: CGFloat = 0, y yOffset: CGFloat = 0) -> CGPoint {
        return .init(x: x + xOffset, y: y + yOffset)
    }
}
