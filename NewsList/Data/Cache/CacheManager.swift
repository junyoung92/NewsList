//
//  CacheManager.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/21/24.
//

import Foundation

final class CacheManager {
    
    static let shared = CacheManager()
    
    private var fileManager = FileManager.default
    
    func cacheData<T: Codable>(_ data: T, fileName: String) {
        do {
            let fileURL = try getFileURL(fileName: fileName, create: true)
            if fileManager.fileExists(atPath: fileURL.path) {
                deleteCacheData(fileName: fileName)
            }
            try JSONEncoder().encode(data).write(to: fileURL)
        } catch {
            print("Error caching data: \(error)")
        }
    }
    
    func getCacheData<T: Codable>(fileName: String) -> T? {
        do {
            let fileURL = try getFileURL(fileName: fileName)
            let data = try Data(contentsOf: fileURL)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error loading cached data: \(error)")
            return nil
        }
    }
    
    func deleteCacheData(fileName: String) {
        do {
            let fileURL = try getFileURL(fileName: fileName)
            guard fileManager.fileExists(atPath: fileURL.path) else {
                return
            }
            try fileManager.removeItem(at: fileURL)
        } catch {
            print("Error deleting cached data: \(error)")
        }
    }
    
    private func getFileURL(fileName: String, create: Bool = false) throws -> URL {
        let documentDirectoryURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: create)
        return documentDirectoryURL.appendingPathComponent(fileName)
    }
}
