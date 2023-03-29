//
//  WholeNumberWheelPickerTests.swift
//  NumberWheelPickerTests
//
//  Created by Kubilay Erdogan on 2023-03-08.
//

import XCTest
import NumberWheelPicker
import snapshotino

final class WholeNumberWheelPickerTests: XCTestCase {
    let min = WholeNumberWheelPicker.ViewModel.Constants.minLength
    let max = WholeNumberWheelPicker.ViewModel.Constants.maxLength
    
    func testEmpty() throws {
        try assert(viewModel: .init())
    }

    func testMin() throws {
        try assert(viewModel: .init(length: min))
    }

    func testLessThanMin() throws {
        try assert(viewModel: .init(length: min-1))
    }

    func testMax() throws {
        try assert(viewModel: .init(length: max))
    }

    func testGreaterThanMax() throws {
        try assert(viewModel: .init(length: max+1))
    }

    func testPreselectedValue() throws {
        try assert(viewModel: .init(length: 3, preselectedValue: 123))
    }

    func testInvalidPreselectedValue() throws {
        try assert(viewModel: .init(length: 2, preselectedValue: -1))
    }

    func testLengthShorterThanPreselectedValue() throws {
        try assert(viewModel: .init(length: 2, preselectedValue: 123))
    }

    func testLengthLongerThanPreselectedValue() throws {
        try assert(viewModel: .init(length: 4, preselectedValue: 123))
    }

    private func assert(
        viewModel: WholeNumberWheelPicker.ViewModel,
        file: StaticString = #file,
        function: String = #function,
        line: UInt = #line
    ) throws {
        let sut = WholeNumberWheelPicker(viewModel: viewModel)
        try assertSnapshot(
            of: sut.asSnapshottableView,
            file: file,
            function: function,
            line: line
        )
    }
}
