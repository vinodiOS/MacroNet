//
//  File.swift
//  
//
//  Created by Vinod Jagtap on 25/04/24.
//

import Foundation

extension String {
    var withoutQuotes: String {
        filter { $0 != "\"" }
    }
}
