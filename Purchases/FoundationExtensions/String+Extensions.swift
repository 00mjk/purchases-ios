//
//  Copyright RevenueCat Inc. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  String+Extensions.swift
//
//  Created by Juanpe Catalán on 9/7/21.
//

import Foundation

extension String {

    func rot13() -> String {
        ROT13.string(self)
    }

    /// Returns `nil` if `self` is an empty string.
    var notEmpty: String? {
        return self.isEmpty
        ? nil
        : self
    }

    /// Returns `nil` if `self` is an empty string or it only contains whitespaces.
    var notEmptyOrWhitespaces: String? {
        return self.trimmingWhitespacesAndNewLines.isEmpty
        ? nil
        : self
    }

    var trimmingWhitespacesAndNewLines: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

internal extension Optional where Wrapped == String {
    /// Returns `nil` if `self` is an empty string.
    var notEmpty: String? {
        return self.flatMap { $0.notEmpty }
    }
}

private enum ROT13 {

    private static var key = [Character: Character]()

    private static let uppercase = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    private static let lowercase = Array("abcdefghijklmnopqrstuvwxyz")

    fileprivate static func string(_ string: String) -> String {
        if ROT13.key.isEmpty {
            for number in 0 ..< 26 {
                ROT13.key[ROT13.uppercase[number]] = ROT13.uppercase[(number + 13) % 26]
                ROT13.key[ROT13.lowercase[number]] = ROT13.lowercase[(number + 13) % 26]
            }
        }

        let transformed = string.map { ROT13.key[$0] ?? $0 }
        return String(transformed)
    }

}
