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
        let functions = try type.buildFunctions(accessSpecifier: type.accessSpecifier)
        let result = try type.expandService(name: name, content: functions)
        
        return [
            """
            \(raw: result)
            """
        ]
    }
}


@main
struct MacroNetPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ServiceMacro.self
    ]
}
