// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(peer, names: suffixed(Service))
public macro Service(_ typeName: String? = nil) = #externalMacro(module: "MacroNetPlugin", type: "ServiceMacro")
