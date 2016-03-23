//
//  LKTranslationType.swift
//  LanguageKit
//
//  Created by Marcus Rossel on 20.03.16.
//  Copyright © 2016 Marcus Rossel. All rights reserved.
//

// MARK: - LKTranslationType

public protocol LKTranslationType: Hashable {
    var languages: (original: LKAnyLanguage, translations: LKAnyLanguage) { get }
    var original: String { get }
    var translations: Set<String> { get }
    var context: String? { get }
}

public extension LKTranslationType {
    var context: String?  {
        return nil
    }
}

// MARK: - Protocol Conformances

public extension LKTranslationType {
    /// Custom implemention of this property should be avoided, as it might
    /// cause disproportionate hash collisions
    var hashValue: Int {
        return "\(languages)\(original)\(translations.sort())".hashValue
    }
}

// MARK: - Operator

@warn_unused_result
public func ==<T: LKTranslationType>(lhs: T, rhs: T) -> Bool {
    return lhs.languages == rhs.languages &&
          (lhs.original, lhs.translations) == (rhs.original, rhs.translations)
}



// MARK: - LKAnyTranslation

/// Type-erasing wrapper for `LKTranslationType`
public struct LKAnyTranslation: LKTranslationType {
    public var languages: (original: LKAnyLanguage, translations: LKAnyLanguage)
    public var original: String
    public var translations: Set<String>
    public var context: String?

    /// A custom implementation of `hashValue` is used to reduce potential
    /// hash collisions with other types (as this type is only a wrapper)
    public var hashValue: Int {
        return "LKAnyTranslation - \(languages.original)\(languages.translations)\(original)\(translations.sort()))".hashValue
    }

    public init<T: LKTranslationType>(_ translation: T) {
        languages = translation.languages
        original = translation.original
        translations = translation.translations
        context = translation.context
    }
}



// MARK: - LKTranslationType

/// Simple structure conforming to the base requirements of `LKVocableStyleType`
///
/// All properties are implemented as constants, as this type is meant to
/// be used like a pure value
public struct LKTranslation: LKTranslationType {
    public let languages: (original: LKAnyLanguage, translations: LKAnyLanguage)
    public let original: String
    public let translations: Set<String>
    public let context: String?
}
