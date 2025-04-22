//
//  ScalerTests.swift
//  ScalerTests
//
//  Created by Dylan Elliott on 27/3/2025.
//

import XCTest
@testable import Scaler

final class ScalerTests: XCTestCase {

    func testScales() throws {
        XCTAssertEqual(Scale.major.inTheKeyOf(.c), [.c, .d, .e, .f, .g, .a, .b, .c])
        XCTAssertEqual(Scale.naturalMinor.inTheKeyOf(.c), [.c, .d, .eFlat, .f, .g, .aFlat, .bFlat, .c])
        XCTAssertEqual(Scale.majorPentatonic.inTheKeyOf(.c), [.c, .d, .e, .g, .a])
        XCTAssertEqual(Scale.minorPentatonic.inTheKeyOf(.c), [.c, .eFlat, .f, .g, .bFlat])
    }

}
