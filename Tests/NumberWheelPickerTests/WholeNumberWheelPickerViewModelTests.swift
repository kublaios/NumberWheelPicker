//
//  WholeNumberWheelPickerViewModelTests.swift
//  NumberWheelPickerTests
//
//  Created by Kubilay Erdogan on 2023-03-29.
//

import XCTest
import NumberWheelPicker

final class WholeNumberWheelPickerViewModelTests: XCTestCase {
    typealias Constants = WholeNumberWheelPicker.ViewModel.Constants

    func testInitWithLengthAndPreselectedValue() {
        let viewModel = WholeNumberWheelPicker.ViewModel(length: 3, preselectedValue: 123)
        
        XCTAssertEqual(viewModel.length, 3)
        XCTAssertEqual(viewModel.preselectedValue, 123)
        XCTAssertEqual(viewModel.selectedValue, 123)
    }
    
    func testInitWithLengthAndNoPreselectedValue() {
        let viewModel = WholeNumberWheelPicker.ViewModel(length: 2)
        
        XCTAssertEqual(viewModel.length, 2)
        XCTAssertEqual(viewModel.preselectedValue, 0)
        XCTAssertEqual(viewModel.selectedValue, Constants.defaultPreselectedValue)
    }
    
    func testInitWithPreselectedValue() {
        let viewModel = WholeNumberWheelPicker.ViewModel(preselectedValue: 456)
        
        XCTAssertEqual(viewModel.length, Constants.defaultLength)
        XCTAssertEqual(viewModel.preselectedValue, 4)
        XCTAssertEqual(viewModel.selectedValue, 4)
    }
    
    func testLengthOutOfRange() {
        let viewModelMin = WholeNumberWheelPicker.ViewModel(length: 0)
        XCTAssertEqual(viewModelMin.length, Constants.minLength)
        
        let viewModelMax = WholeNumberWheelPicker.ViewModel(length: 11)
        XCTAssertEqual(viewModelMax.length, Constants.maxLength)
    }

    func testLengthLongerThanPreselectedValue() {
        let viewModel = WholeNumberWheelPicker.ViewModel(length: 5, preselectedValue: 123)
        XCTAssertEqual(viewModel.length, 5)
        XCTAssertEqual(viewModel.preselectedValue, 123)
        XCTAssertEqual(viewModel.selectedValue, 123)
    }

    func testLengthShorterThanPreselectedValue() {
        let viewModel = WholeNumberWheelPicker.ViewModel(length: 2, preselectedValue: 12345)
        XCTAssertEqual(viewModel.length, 2)
        XCTAssertEqual(viewModel.preselectedValue, 12)
        XCTAssertEqual(viewModel.selectedValue, 12)
    }

    func testInvalidPreselectedValue() {
        let viewModel = WholeNumberWheelPicker.ViewModel(length: 3, preselectedValue: -123)
        XCTAssertEqual(viewModel.length, 3)
        XCTAssertEqual(viewModel.preselectedValue, 0)
        XCTAssertEqual(viewModel.selectedValue, 0)
    }

    func testNilPreselectedValue() {
        let viewModel = WholeNumberWheelPicker.ViewModel(length: 3)
        XCTAssertEqual(viewModel.length, 3)
        XCTAssertEqual(viewModel.preselectedValue, 0)
        XCTAssertEqual(viewModel.selectedValue, 0)
    }
}
