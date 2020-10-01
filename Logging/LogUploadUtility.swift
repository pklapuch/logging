//
//  LogUploadUtility.swift
//  Logging
//
//  Created by Pawel Klapuch on 9/29/20.
//

import Foundation

public struct LogUploadUtility {
    
    enum Error: Swift.Error {
        
        case fatal(String)
    }
    
    static func getTemporaryLogDirectoryURL(tmpDirectory: String) throws -> URL {
        
        let documentsURL = try FileUtility.documentsUrl()
        return documentsURL.appendingPathComponent(tmpDirectory)
    }
    
    private static func createTemporaryLogContainer(with name: String, tmpDirectory: String) throws -> TemporaryLogContainer {
        
        let documentsURL = try FileUtility.documentsUrl()
        let tmpLogDirURL = documentsURL.appendingPathComponent(tmpDirectory)
        
        let container = TemporaryLogContainer(base: tmpLogDirURL,
                                              uuidString: UUID().uuidString,
                                              directory: name)
        
        return container
    }
    
    public static func copy(files: [URL], to container: TemporaryLogContainer) throws {
        
        for file in files {
            
            let dirURL = container.getLogDirectory()
            let destURL = dirURL.appendingPathComponent(file.lastPathComponent)
            try FileUtility.copy(fileURL: file, to: destURL)
        }
    }
    
    
    public static func createTemporaryDirectory(tmpDirectory: String) throws {
    
        let tmpLogURL = try getTemporaryLogDirectoryURL(tmpDirectory: tmpDirectory)
        if !FileUtility.fileExists(at: tmpLogURL.path) {
            try FileUtility.createDirectory(at: tmpLogURL)
            try FileUtility.excludeFromBackup(url: tmpLogURL)
        }
    }
    
    public static func deleteTemporaryDirectory(tmpDirectory: String) throws {
        
        let tmpLogURL = try getTemporaryLogDirectoryURL(tmpDirectory: tmpDirectory)
        if FileUtility.fileExists(at: tmpLogURL.path) {
            //log.debug("delete temporary log directory")
            try? FileUtility.deleteItem(at: tmpLogURL)
        }
    }
    
    public static func getLogFileURLs(from logger: LogUploadProtocol) throws -> [URL] {
        
        let logsURL = try logger.getLogDirectoryURL()
        let allFiles = try FileUtility.directoryContents(at: logsURL)
        return allFiles.filter { $0.pathExtension == logger.getLogFileExtension() }
    }
    
    public static func createTemporaryLogContainerDirectories(tmpDirectory: String, name: String) throws -> TemporaryLogContainer {
        
        let container = try LogUploadUtility.createTemporaryLogContainer(with: name, tmpDirectory: tmpDirectory)
        try FileUtility.createDirectory(at: container.getUUIDURL())
        try FileUtility.createDirectory(at: container.getLogDirectory())
        
        return container
    }

    public static func delete(container: TemporaryLogContainer) throws {
        
        try FileUtility.deleteItem(at: container.getUUIDURL())
    }
}
