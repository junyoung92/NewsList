//
//  AppConfiguration.swift
//  NewsList
//
//  Created by Junyoung Kil on 4/20/24.
//

import Foundation

final class AppConfiguration {
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String else {
            fatalError("APIKey must not be empty in plist")
        }
        return apiKey
    }()
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "APIBaseURL") as? String else {
            fatalError("BaseAPI must not be empty in plist")
        }
        return apiBaseURL
    }()
}
