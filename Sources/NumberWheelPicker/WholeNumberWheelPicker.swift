//
//  WholeNumberWheelPicker.swift
//  NumberWheelPicker
//
//  Created by Kubilay Erdogan on 2023-03-08.
//

import SwiftUI

public struct WholeNumberWheelPicker: View {
    private let viewModel: ViewModel
    @State private var hasAppeared = false

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<viewModel.length, id: \.self) { digitIndex in
                Picker("", selection: Binding(
                    // Returns the digit at the current position (LTR) of the preselectedValue if it is not nil, otherwise 0.
                    //
                    // In order to calculate the digit at the current position, we're dividing preselectedValue by 10
                    // raised to the power of (length - (digitIndex + 1)) and then take the remainder of that division when divided by 10.
                    // This gives us the digit at the current position.
                    //
                    // Credits: ChatGPT (kind of, I still had to fix various stuff but hey)
                    get: { () -> Int in
                        var valueToSelect = viewModel.selectedValue
                        if !hasAppeared {
                            valueToSelect = viewModel.preselectedValue
                        }

                        return (valueToSelect / (viewModel.length - (digitIndex + 1)).asPowerOfTen.asInteger) % 10
                    },
                    // updates the selectedValue based on the new selected value at the current digit position
                    set: { newValue in
                        // _ _ _ Y Z
                        let oldValueAfterDigitPosition = viewModel.selectedValue % (viewModel.length - (digitIndex + 1)).asPowerOfTen.asInteger
                        // _ _ X Y Z
                        let oldValueAtDigitPosition = viewModel.selectedValue % (viewModel.length - digitIndex).asPowerOfTen.asInteger
                        // _ _ X 0 0
                        let oldValueStartingFromDigitPosition = oldValueAtDigitPosition - oldValueAfterDigitPosition
                        // _ _ A 0 0
                        let newValueAtDigitPosition = newValue * (viewModel.length - (digitIndex + 1)).asPowerOfTen.asInteger
                        // [_ _ X 0 0] - [_ _ A 0 0]
                        let diff = oldValueStartingFromDigitPosition - newValueAtDigitPosition
                        viewModel.selectedValue = viewModel.selectedValue - diff
                    }
                )) {
                    ForEach(0...9, id: \.self) { number in
                        Text("\(number)")
                            .tag(number)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .onAppear {
                    guard !hasAppeared else { return }
                    hasAppeared = true
                }
            }
        }
    }
}

extension WholeNumberWheelPicker {
    public final class ViewModel: ObservableObject {
        public let length: Int
        public let preselectedValue: Int
        @Published public internal(set) var selectedValue: Int

        /// Initializes a new ViewModel with the specified length and optional preselected value.
        ///
        /// - Parameters:
        ///     - length: The desired length (number of digits) for the wheel picker.
        ///               If the provided value is outside the allowed range (1...10),
        ///               it is clamped to the closest limit.
        ///     - preselectedValue: An optional initial value to display on the wheel picker.
        ///                         If not provided, the initial value is set to 0.
        ///                         Prefixed by length if it is longer than length.
        public init(length: Int = Constants.defaultLength, preselectedValue: Int? = nil) {
            if length < Constants.minLength {
                self.length = Constants.minLength
            } else if length > Constants.maxLength {
                self.length = Constants.maxLength
            } else {
                self.length = length
            }

            if let preselectedValue, preselectedValue >= 0 {
                let strValue = String(preselectedValue)
                let strValueInRange = strValue.prefix(self.length)

                if let intValue = Int(String(strValueInRange)) {
                    self.preselectedValue = intValue
                } else {
                    self.preselectedValue = Constants.defaultPreselectedValue
                }
            } else {
                self.preselectedValue = Constants.defaultPreselectedValue
            }

            selectedValue = self.preselectedValue
        }
    }
}

extension WholeNumberWheelPicker.ViewModel {
    public enum Constants {
        public static let minLength = 1
        public static let maxLength = 10
        public static let defaultLength = 1
        public static let defaultPreselectedValue = 0
    }
}
