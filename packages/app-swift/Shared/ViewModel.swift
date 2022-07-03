//
//  ViewModel.swift
//  Joplin
//
//  Created by Kyle Alan Hale on 7/1/22.
//

import Foundation
import SwiftUI
import JavaScriptCore

class ViewModel: ObservableObject {
    @Published var thing: String?
    let context = JSContext()!
    let exports: JSValue

    init() {
        guard let url = Bundle.main.url(forResource: "bundle", withExtension: "js"),
              let script = try? String(contentsOf: url) else {
            fatalError("Could not find Joplin host script (see ViewModel.swift)")
        }

        exports = context.evaluateScript(script, withSourceURL: URL(string: "joplin-swift-host:/index.js"))
    }

    func update() {
        let thing: String?
        do {
            thing = try call("getMessage")?.toString()
        }
        catch JavaScriptCoreError.unhandled(let message) {
            thing = message
        }
        catch {
            thing = "Unknown error!"
        }
        self.thing = thing
    }

    func call(_ name: String, args: [Any] = []) throws -> JSValue? {
        let value = self.exports
            .objectForKeyedSubscript("default")
            .objectForKeyedSubscript(name)
            .call(withArguments: args)

        if let exception = context.exception?.toString(),
           let stack = context.exception.objectForKeyedSubscript("stack").toString() {
            throw JavaScriptCoreError.unhandled(message: "\(exception)\nStack trace:\n\(stack)")
        }

        return value
    }
}

enum JavaScriptCoreError: Error {
    case unhandled(message: String)
}
