import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

public struct ServiceMacro: PeerMacro {
    public static func expansion(of node: AttributeSyntax,
                                 providingPeersOf declaration: some DeclSyntaxProtocol,
                                 in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        
        guard let type = declaration.as(ProtocolDeclSyntax.self) else {
            context.addDiagnostics(from: MacroNetPluginError(message: "@Service can be applied to Protcols only"),
                                   node: node)
            return []
        }
        let name = node.firstArgument ?? "\(type.typeName)\(node.attributeName)"
        let result = try type.expandService(name: name)
        return [
            """
            \(raw: result)
            """
        ]
    }
}

extension AttributeSyntax {
    var firstArgument: String? {
        if case let .argumentList(list) = arguments {
            return list.first?.expression.description.withoutQuotes
        }
        return nil
    }
}

extension String {
    var withoutQuotes: String {
        filter { $0 != "\"" }
    }
}


extension ProtocolDeclSyntax {
    func expandService(name: String) throws -> String {
        """
        \(accessSpecifier)struct \(name): \(typeName) {
            let session: URLSessionManager
        
            \(accessSpecifier)init(session: URLSessionManager) {
                self.session = session
            }
        
            
        }
        """
    }
}

@main
struct MacroNetPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ServiceMacro.self
    ]
}
