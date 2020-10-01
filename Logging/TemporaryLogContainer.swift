//
//  TemporaryLogContainer.swift
//  Logging
//
//  Created by Pawel Klapuch on 9/29/20.
//

import Foundation

public struct TemporaryLogContainer {

    let base: URL
    let uuidString: String
    let directory: String
    
    public func getUUIDURL() -> URL {
        
        return base.appendingPathComponent(uuidString)
    }
    
    public func getLogDirectory() -> URL {
        
        return base.appendingPathComponent(uuidString).appendingPathComponent(directory)
    }
    
    public func createArchiveURL(ext: String) -> URL {
        
        return getUUIDURL().appendingPathComponent(directory).appendingPathExtension(ext)
    }
}
