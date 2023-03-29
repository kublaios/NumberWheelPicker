//
//  DecimalNumberWheelPickerTests.swift
//
//
//  Created by Kubilay Erdogan on 2023-03-29.
//

import XCTest
import NumberWheelPicker
import snapshotino

final class DecimalNumberWheelPickerTests: XCTestCase {
    func testEmpty() throws {
        try assert(viewModel: .init())
    }

    func testZero() throws {
        try assert(viewModel: .init(wholeParthLength: 0, fractionalPartLength: 0))
    }

    func testMin() throws {
        try assert(viewModel: .init(preselectedValue: 9.1, wholeParthLength: 1, fractionalPartLength: 1))
    }

    func testLessThanZero() throws {
        try assert(viewModel: .init(preselectedValue: -1.23, wholeParthLength: 2, fractionalPartLength: 2))
    }

    func testMax() throws {
        try assert(
            viewModel: .init(preselectedValue: 9999.9999, wholeParthLength: 10, fractionalPartLength: 10),
            screenSize: .iPhone11Landscape
        )
    }

    func testGreaterThanMax() throws {
        try assert(
            viewModel: .init(preselectedValue: 1110.123, wholeParthLength: 11, fractionalPartLength: 11),
            screenSize: .iPhone11Landscape
        )
    }

    func testPreselectedValue() throws {
        try assert(viewModel: .init(preselectedValue: 555.777, wholeParthLength: 3, fractionalPartLength: 3))
    }

    func testInvalidPreselectedValue() throws {
        try assert(viewModel: .init(preselectedValue: 123.456, wholeParthLength: 2, fractionalPartLength: 2))
    }

    func testLengthShorterThanPreselectedValue() throws {
        try assert(viewModel: .init(preselectedValue: 12345.6789, wholeParthLength: 4, fractionalPartLength: 3))
    }

    func testLengthLongerThanPreselectedValue() throws {
        try assert(viewModel: .init(preselectedValue: 12.34, wholeParthLength: 3, fractionalPartLength: 3))
    }

    private func assert(
        viewModel: DecimalNumberWheelPicker.ViewModel,
        screenSize: SnapshottableScreenSize = .iPhone11,
        file: StaticString = #file,
        function: String = #function,
        line: UInt = #line
    ) throws {
        let sut = DecimalNumberWheelPicker(viewModel: viewModel)
        try assertSnapshot(
            of: sut.asSnapshottableView,
            on: screenSize,
            file: file,
            function: function,
            line: line
        )
    }
}

extension SnapshottableScreenSize {
    static let iPhone11Landscape = CGSize(width: 896, height: 414)
}
