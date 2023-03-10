//
//  APIError.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//

import Foundation
enum APIError: Error, LocalizedError {
    case requestFailedReason(reason: String)
    case jsonParsingFailure
    case noInternet
    case failedSerialization
    case unauthorized
    case requestCancelled
    case invalidURL
    case couldntParseResponse
    case keyNotFound
    case noDataFound
    
    // error text for user
    var localizedDescription: String {
        switch self {
        case let .requestFailedReason(description): return description
        case .jsonParsingFailure: return "JSON Parsing Failure error)"
        case .noInternet: return "No internet connection."
        case .failedSerialization: return "serialization print for debug failed."
        case .unauthorized: return "This request is unauthorized."
        case .requestCancelled: return "Cancelled"
        case .invalidURL: return ""
        case .couldntParseResponse: return ""
        case .keyNotFound: return ""
        case .noDataFound: return "No record found."
        }
    }
    
    // error for logs
    var errorDescription: String? {
        switch self {
            
        case let .requestFailedReason(description):
            return "\(description)"
            
        case .unauthorized:
            return "You have been logged out. Please sign back in."
            
        case .invalidURL:
            return NSLocalizedString(
                "Invalid request URL",
                comment: ""
            )
        case .couldntParseResponse:
            return NSLocalizedString(
                "Couldn't parse response JSON",
                comment: ""
            )
            
        case .keyNotFound:
            return NSLocalizedString(
                "Decoding keys not found",
                comment: ""
            )
            
        default:
            return localizedDescription
        }
    }
}
