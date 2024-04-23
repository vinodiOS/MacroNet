import SwiftDiagnostics
import Foundation


public struct MacroNetPluginError: CustomStringConvertible, Error {
    public var message: String
    
    init(message: String) {
        self.message = message
    }
    
    public var description: String {
        message
    }
}
