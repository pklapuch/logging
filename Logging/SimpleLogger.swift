//
//  ConsoleLogger.swift
//  Logging
//
//  Created by Pawel Klapuch on 9/28/20.
//

import Foundation

public class SimpleLogger: LogProtocol {
    
    public enum Error: Swift.Error {
        
        case unsupported
    }
    
    private let formatter = DefaultDateFormatter()
    
    public init() { }
    
    public func debug(_ message: String) {
        
        log(message: message, level: .debug)
    }
    
    public func info(_ message: String) {
        
        log(message: message, level: .info)
    }
    
    public func error(_ message: String) {
        
        log(message: message, level: .error)
    }
    
    public func fatal(_ message: String) {
        
        log(message: message, level: .fatal)
    }
    
    private func log(message: String, level: LogLevel) {
        
        print("\(formatter.string(from: Date())) [\(level.rawValue)]: \(message)")
    }
}

fileprivate class DefaultDateFormatter: DateFormatter {
    
    override init() {
        super.init()
        dateFormat = "dd-MM-yy hh:mm:ss.sss ZZZ"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SimpleLogger: LogUploadProtocol {
    
    public var supportsLogUpload: Bool { return false }
    public func getLogDirectoryURL() throws -> URL { throw Error.unsupported }
    public func getLogFileExtension() -> String? { return nil }
}
