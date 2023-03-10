//
//  NetworkController.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//
//  NetworkController and UrlMangers are responsible for all kind of apis call and sending and retrieving
//  data from remote servers

import Foundation
import SwiftUI
import Combine

class UrlManager{
    /**
     To get all games
     */
    static func gamesUrl()->URL{
        let path = AppConstants.api.baseHostUrl + AppConstants.api.games
        return URL(string: path.encodeURL)!
    }
    
    /**
     To get all athletes
     */
    static func athletesUrl()->URL{
        let path = AppConstants.api.baseHostUrl + AppConstants.api.athletes
        return URL(string: path.encodeURL)!
    }
    
    /**
     To get game athletes
     */
    static func gameAthletesUrl(_ id:String)->URL{
        let path = AppConstants.api.baseHostUrl + AppConstants.api.games + id + "/" + AppConstants.api.athletes
        return URL(string: path.encodeURL)!
    }
    
    /**
     To get athletes medals list
     */
    static func athleteDetailsUrl(_ id:String)->URL{
        let path = AppConstants.api.baseHostUrl + AppConstants.api.athletes + id + "/" + AppConstants.api.results
        return URL(string: path.encodeURL)!
    }
    
    /**
     To get  athlete photo
     */
    static func athletePhotoUrl(_ id:String)->URL{
        let path = AppConstants.api.baseHostUrl + AppConstants.api.athletes + id + "/" + AppConstants.api.photo
        return URL(string: path.encodeURL)!
    }
    
}

class NetworkManager{
    
    var cancellables = Set<AnyCancellable>()
    
    /**
     To fetch data from remote server
     @param url - API end point
     @param httpMethod, GET or POST
     @param completionHandler
     */
    func executeNetworkRequest(_ url:URL, httpMethod:String, completionHandler: @escaping (Result<Data?, APIError>)-> Void) {
        
        print("url=", url)
        var request = URLRequest(url: url)

        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = ["Accept": "application/json"]
        //request.addValue("Bearer  \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        ///due to some non standard parameters names in the api response
        let decoderParser = JSONDecoder()
        decoderParser.dateDecodingStrategy = .iso8601
        
        // Set up the URL Session
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                #if DEBUG
                print("data=", String(data:data, encoding: .utf8) ?? "")
                #endif
                guard let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                        print(response)
                        throw URLError(.badServerResponse)
                }
                return data
            }
            //.decode(type: [GameModel].self, decoder: decoderParser)
            .sink { (completion) in
                switch completion{
                case .finished:
                    print("COMPLETION \(completion)")
                case .failure(let error):
                    print("COMPLETION \(error)")
                    completionHandler(.failure(APIError.requestFailedReason(reason: error.localizedDescription)))
                }
                
            } receiveValue: { (returnedData) in
                print("This is completing")
                completionHandler(.success(returnedData))
            }
            .store(in: &cancellables)
        }
}
