import SwiftSyntax

extension ProtocolDeclSyntax {
    var typeName: String {
        name.text
    }
    
    var accessSpecifier: String {
        modifiers.first.map { "\($0.trimmedDescription)" } ?? ""
    }
    
    var functions: [FunctionDeclSyntax] {
        memberBlock.members.compactMap { $0.decl.as(FunctionDeclSyntax.self) }
    }
}

