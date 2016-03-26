//
//  LKLanguageType.swift
//  LanguageKit
//
//  Created by Marcus Rossel on 20.03.16.
//  Copyright © 2016 Marcus Rossel. All rights reserved.
//

import Foundation

/// A protocol for types, which are able to represent languages.
public protocol LKLanguageType: Hashable {
    var description: String { get }
}

public extension LKLanguageType {
    /// Custom implemention of this property should be avoided, as it might
    /// cause disproportionate hash collisions.
    public var hashValue: Int {
        return description.hashValue
    }
}

/// `LKLanguageTypes`s with the same `description` should have the same purpose,
/// and are therefore considered equal.
@warn_unused_result
public func ==<T: LKLanguageType>(lhs: T, rhs: T) -> Bool {
    return lhs.description == rhs.description
}
