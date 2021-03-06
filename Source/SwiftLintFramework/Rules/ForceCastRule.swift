//
//  ForceCastRule.swift
//  SwiftLint
//
//  Created by JP Simard on 2015-05-16.
//  Copyright (c) 2015 Realm. All rights reserved.
//

import SourceKittenFramework

public struct ForceCastRule: Rule {
    public init() {}

    public static let description = RuleDescription(
        identifier: "force_cast",
        name: "Force Cast",
        description: "This rule checks whether you don't do force casts.",
        nonTriggeringExamples: [
            "NSNumber() as? Int\n"
        ],
        triggeringExamples: [ "NSNumber() as! Int\n" ]
    )

    public func validateFile(file: File) -> [StyleViolation] {
        return file.matchPattern("as!", withSyntaxKinds: [.Keyword]).map { range in
            return StyleViolation(ruleDescription: self.dynamicType.description,
                severity: .Error, location: Location(file: file, offset: range.location),
                reason: "Force casts should be avoided")
        }
    }
}
