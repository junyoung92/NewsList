//
//  AppConfiguration.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Foundation

final class AppConfiguration {
    
    lazy var dictionary: NSDictionary = {
        guard let filePath = Bundle.main.path(forResource: "Privacy", ofType: "plist") else {
            fatalError("not exists filePath")
        }
        return NSDictionary(contentsOfFile: filePath) ?? [:]
    }()
    
    lazy var apiKey: String = {
        guard let apiKey = dictionary["API_KEY"] as? String else {
            fatalError("APIKey must not be empty in plist")
        }
        return apiKey
    }()
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = dictionary["API_URL"] as? String else {
            fatalError("BaseAPI must not be empty in plist")
        }
        return apiBaseURL
    }()
}
