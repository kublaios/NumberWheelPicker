//
//  DecimalNumberWheelPickerViewModelTests.swift
//
//
//  Created by Kubilay Erdogan on 2023-03-29.
//

import XCTest
import NumberWheelPicker

final class DecimalNumberWheelPickerViewModelTests: XCTestCase {
    func testInit() {
        let viewModel = DecimalNumberWheelPicker.ViewModel(preselectedValue: 12.345)

        XCTAssertEqual(viewModel.wholePartValue, 12)
        XCTAssertEqual(viewModel.fractionalPartValue, 345)
        XCTAssertEqual(viewModel.selectedValue, 12.345)
        XCTAssertEqual(viewModel.length.wholePart, 2)
        XCTAssertEqual(viewModel.length.fractionalPart, 3)
        XCTAssertEqual(viewModel.delimiter, ",")
    }

    func testInitWithCustomWholePartLength() {
        let viewModel = DecimalNumberWheelPicker.ViewModel(preselectedValue: 7.89, wholeParthLength: 4)

        XCTAssertEqual(viewModel.wholePartValue, 7)
        XCTAssertEqual(viewModel.fractionalPartValue, 890)
        XCTAssertEqual(viewModel.selectedValue, 7.89)
        XCTAssertEqual(viewModel.length.wholePart, 4)
        XCTAssertEqual(viewModel.length.fractionalPart, 3)
        XCTAssertEqual(viewModel.delimiter, ",")
    }

    func testInitWithCustomFractionalPartLength() {
        let viewModel = DecimalNumberWheelPicker.ViewModel(preselectedValue: 12.345, fractionalPartLength: 2)

        XCTAssertEqual(viewModel.wholePartValue, 12)
        XCTAssertEqual(viewModel.fractionalPartValue, 35)
        XCTAssertEqual(viewModel.selectedValue, 12.345)
        XCTAssertEqual(viewModel.length.wholePart, 2)
        XCTAssertEqual(viewModel.length.fractionalPart, 2)
        XCTAssertEqual(viewModel.delimiter, ",")
    }

    func testInitWithCustomDelimiter() {
        let viewModel = DecimalNumberWheelPicker.ViewModel(preselectedValue: 12.345, delimiter: ".")

        XCTAssertEqual(viewModel.wholePartValue, 12)
        XCTAssertEqual(viewModel.fractionalPartValue, 345)
        XCTAssertEqual(viewModel.selectedValue, 12.345)
        XCTAssertEqual(viewModel.length.wholePart, 2)
        XCTAssertEqual(viewModel.length.fractionalPart, 3)
        XCTAssertEqual(viewModel.delimiter, ".")
    }
}
