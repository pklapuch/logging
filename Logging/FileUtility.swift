//
//  FileUtility.swift
//  Logging
//
//  Created by Pawel Klapuch on 10/1/20.
//

import Foundation

struct FileUtility {
    
    static func documentsUrl() throws -> URL {
        
        return try FileManager.default.url(for: .documentDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil,
                                           create: true)
    }
    
    static func copy(fileURL: URL, to destinationURL: URL) throws {
        
        try FileManager.default.copyItem(at: fileURL, to: destinationURL)
    }
    
    static func createDirectory(at url: URL) throws {
        
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
    }
    
    static func fileExists(at path: String) -> Bool {
        
        return FileManager.default.fileExists(atPath: path)
    }
    
    static func excludeFromBackup(url: URL) throws {
        
        if (FileManager.default.fileExists(atPath: url.path)) {
            
            let values = URLResourceValues.excludedFromBackup
            var mutableUrl = url
            try mutableUrl.setResourceValues(values)
        }
    }
    
    static func deleteItem(at url: URL) throws {
        
        try FileManager.default.removeItem(at: url)
    }
    
    static func directoryContents(at url: URL) throws -> [URL] {
        
        return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
    }
}

extension URLResourceValues {
    
    fileprivate static var excludedFromBackup: URLResourceValues {
        
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        return values
    }
}
