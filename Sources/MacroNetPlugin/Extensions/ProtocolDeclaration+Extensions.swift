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

extension ProtocolDeclSyntax {
    func expandService(name: String, content: String) throws -> String {
        """
        \(accessSpecifier)struct \(name): \(typeName) {
            let session: URLSessionManager
        
            \(accessSpecifier)init(session: URLSessionManager) {
                self.session = session
            }
        
            \(content)
        }
        """
    }
    
    func buildFunctions(accessSpecifier: String) throws -> String {
        let functions = self.memberBlock.members.compactMap { member  -> String? in
            guard let fDecl = member.decl.as(FunctionDeclSyntax.self) else { return nil }
            var function: String?
            function = fDecl.mapFunction(accessModifer: accessSpecifier)
            return function
        }.joined(separator: "\n\n")
        return
        """
        \(functions)
        """
    }
}

extension FunctionDeclSyntax {
    func mapFunction(accessModifer: String) -> String {
        let name = self.name.text
        let effectSpecifiers = self.signature.effectSpecifiers?.description ?? ""
        let returnClause = self.signature.returnClause?.type.description ?? ""
        return """
        \(accessModifer)func \(name)() \(effectSpecifiers)-> \(returnClause) {
                return session.request()
                    .async()
        }
        """
    }
}

