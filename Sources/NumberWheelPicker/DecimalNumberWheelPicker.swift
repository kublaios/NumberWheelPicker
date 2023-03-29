//
//  DecimalNumberWheelPicker.swift
//  NumberWheelPicker
//
//  Created by Kubilay Erdogan on 2023-03-29.
//

import SwiftUI

/// A custom SwiftUI view that presents a whole part and a fractional part picker for selecting decimal numbers.
/// Uses `WholeNumberWheelPicker` under the hood.
public struct DecimalNumberWheelPicker: View {
    public typealias Length = (wholePart: Int, fractionalPart: Int)

    @StateObject public var viewModel: ViewModel
    @StateObject public var wholePartViewModel: WholeNumberWheelPicker.ViewModel
    @StateObject public var fractionalPartViewModel: WholeNumberWheelPicker.ViewModel

    public init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
        _wholePartViewModel = .init(
            wrappedValue: .init(
                length: viewModel.length.wholePart,
                preselectedValue: viewModel.wholePartValue
            )
        )
        _fractionalPartViewModel = .init(
            wrappedValue: .init(
                length: viewModel.length.fractionalPart,
                preselectedValue: viewModel.fractionalPartValue
            )
        )
    }

    public var body: some View {
        VStack {
            HStack {
                WholeNumberWheelPicker(viewModel: wholePartViewModel)
                Text(viewModel.delimiter)
                WholeNumberWheelPicker(viewModel: fractionalPartViewModel)
            }
            .onChange(of: wholePartViewModel.selectedValue) { _ in
                updateSelectedValue()
            }
            .onChange(of: fractionalPartViewModel.selectedValue) { _ in
                updateSelectedValue()
            }
        }
    }

    private func updateSelectedValue() {
        let fraction = Float(fractionalPartViewModel.selectedValue) / viewModel.length.fractionalPart.asPowerOfTen
        viewModel.selectedValue = Float(wholePartViewModel.selectedValue) + fraction
    }
}

/// A view model for `DecimalNumberWheelPicker` view.
///
/// Handles whole and fractional parts of a floating number with separate wheel pickers.
extension DecimalNumberWheelPicker {
    public final class ViewModel: ObservableObject {
        /// The current whole part value selected in the wheel picker.
        @Published public private(set) var wholePartValue: Int

        /// The current fractional part value selected in the wheel picker.
        @Published public private(set) var fractionalPartValue: Int

        /// The complete floating-point number, combining whole and fractional parts.
        public internal(set) var selectedValue: Float

        /// The length of the whole and fractional parts for the wheel pickers.
        public let length: Length

        /// The delimiter string used to separate whole and fractional parts.
        public let delimiter: String

        /// Initializes a new `DecimalNumberWheelPicker.ViewModel`.
        ///
        /// - Parameters:
        ///   - preselectedValue: A `Float` representing the initial value to be shown on the wheel pickers.
        ///   - wholeParthLength: An optional `Int` representing the length of the whole part picker.
        ///     If not provided, the length will be calculated based on `preselectedValue`.
        ///   - fractionalPartLength: An `Int` representing the length of the fractional part picker,
        ///     with a default value of 3.
        ///   - fixedLength: An optional `Length`, if provided, the whole part picker will be fixed to this length.
        ///   - delimiter: A `String` representing the delimiter between whole and fractional parts,
        ///     with a default value of ",".
        public init(
            preselectedValue: Float = Constants.defaultPreselectedValue,
            wholeParthLength: Int? = nil,
            fractionalPartLength: Int = Constants.defaultFractionalPartLength,
            fixedLength: Length? = nil,
            delimiter: String = Constants.defaultDelimiter
        ) {
            let wholePartLength = wholeParthLength ?? Int(preselectedValue).length
            length = (wholePartLength, fractionalPartLength)
            wholePartValue = Int(modf(preselectedValue).0)
            fractionalPartValue = round(modf(preselectedValue).1 * fractionalPartLength.asPowerOfTen).asInteger
            selectedValue = preselectedValue
            self.delimiter = delimiter
        }
    }
}

extension DecimalNumberWheelPicker.ViewModel {
    public enum Constants {
        public static let defaultPreselectedValue: Float = 0
        public static let defaultFractionalPartLength = 3
        public static let defaultDelimiter = ","
    }
}
