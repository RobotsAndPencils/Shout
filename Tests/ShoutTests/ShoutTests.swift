//
// ShoutTests.swift
// Shout
//
//  Created by Jake Heiser on 3/4/18.
//

import XCTest
@testable import Shout

class ShoutTests: XCTestCase {
    
    func testCapture() throws {
        let ssh = try SSH(host: "jakeheis.com")
        try ssh.authenticate(username: "", privateKey: "")
        print(try ssh.capture("ls -a"))
        print(try ssh.capture("pwd"))
    }

    func testConnect() throws {
        try SSH.connect(host: "jakeheis.com", username: "", authMethod: SSHAgent()) { (ssh) in
            print(try ssh.capture("ls -a"))
            print(try ssh.capture("pwd"))
        }
    }

    func testSendFile() throws {
        try SSH.connect(host: "jakeheis.com", username: "", authMethod: SSHAgent()) { (ssh) in
            try ssh.sendFile(localURL: URL(fileURLWithPath: String(#file)), remotePath: "/tmp/upload_test.swift", mode: 0o644)
            print(try ssh.capture("cat /tmp/upload_test.swift"))
            print(try ssh.capture("ls -l /tmp/upload_test.swift"))
            print(try ssh.capture("rm /tmp/upload_test.swift"))
        }
    }

    static var allTests = [
        ("testCapture", testCapture),
        ("testConnect", testConnect),
        ("testSendFile", testSendFile),
    ]

}
