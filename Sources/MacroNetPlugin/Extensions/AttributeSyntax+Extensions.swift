//
//  File.swift
//  
//
//  Created by Vinod Jagtap on 25/04/24.
//

import Foundation
import SwiftSyntax

extension AttributeSyntax {
    var firstArgument: String? {
        if case let .argumentList(list) = arguments {
            return list.first?.expression.description.withoutQuotes
        }
        return nil
    }
}
