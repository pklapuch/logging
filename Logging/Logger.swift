//
//  Logger.swift
//  Logging
//
//  Created by Pawel Klapuch on 10/09/2020.
//

import Foundation

public enum LogLevel: String {
    
    case debug = "debug"
    case info = "info"
    case error = "error"
    case fatal = "fatal"
}

public protocol LogUploadProtocol {
    
    var supportsLogUpload: Bool { get }
    func getLogDirectoryURL() throws -> URL
    func getLogFileExtension() -> String?
}

public protocol LogProtocol {
    
    func debug(_ message: String)
    func info(_ message: String)
    func error(_ message: String)
    func fatal(_ message: String)
}

public protocol LogConfiguratorProtocol {
    
    func set(logger: LogProtocol)
}
