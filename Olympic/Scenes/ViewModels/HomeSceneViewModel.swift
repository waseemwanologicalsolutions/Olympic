//
//  HomeSceneViewModel.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//

import Foundation
import SwiftUI

class HomeSceneViewModel:ObservableObject{
    
    //// API loading and error showing
    @Published var isLoading: Bool = false
    @Published var isAPILoaded: Bool = false
    @Published var alertTitle:String = ""
    @Published var alertMessage:String = ""
    @Published var showAlert:Bool = false
    @Published var showRetry:Bool = false
    //// When games api loading finished then this state triger fetching game athletes
    @Published var isGamesLoaded:Bool = false
    //// Hold all games
    @Published var games = [GameModel]()
    //// Hold all athletes
    @Published var athletes = [AthleteModel]()
    //// When tapped on some athlete pic, it navigate to details screen
    @Published var showDetailsScreen:Bool = false
    //// this hold the selected game as environment object, can be used globally
    @Published var selectedGame:GameModel = HomeSceneViewModelData.generateData()[0]
    //// this hold the selected athlete as environment object, can be used globally
    @Published var selectedAthlete:AthleteModel = GameAthletesViewlData.generateData()[0]
    
    ////local instance to call network requests
    let networkManger = NetworkManager()
    
    /// fetch all games
    func getAllGames(){
        self.isLoading = true
        self.isGamesLoaded = false
        self.networkManger.executeNetworkRequest(UrlManager.gamesUrl(),httpMethod: AppConstants.httpMethod.get, completionHandler: { (response) in
            switch response{
            case .failure(let error):
                self.isLoading = false
                self.alertTitle = "Oops!"
                self.alertMessage = error.errorDescription ?? error.localizedDescription
                self.showAlert = true
                self.games = []
                self.isGamesLoaded = true
                self.showRetry = true
            case .success(let result):
                
                if let data = result{
                    let decoderParser = JSONDecoder()
                    decoderParser.dateDecodingStrategy = .iso8601
                    do{
                        let gamesList = try decoderParser.decode([GameModel].self, from: data)
                        self.games = gamesList.sorted(by: {Int($0.year!)! > Int($1.year!)!})
                    }catch(let error){
                       print("error in viewmodel=",error)
                        self.games = []
                    }
                }else{
                    self.games = []
                }
                self.isAPILoaded = true
                self.isLoading = false
                //little delay is needed here so that first games lists view render properly then athletes satart fetching
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                    self.isGamesLoaded = true
                }
               
            }
            
        })
    }
    
    /// fetch all athletes
    func getAllAthletes() async throws ->[AthleteModel]{
        
        do{
            let data = try await self.networkManger.executeNetworkRequestAsync(UrlManager.athletesUrl(), httpMethod: AppConstants.httpMethod.get)
            let decoderParser = JSONDecoder()
            decoderParser.dateDecodingStrategy = .iso8601
            do{
                var athletesList = try decoderParser.decode([AthleteModel].self, from: data)
                for item in athletesList{
                    do{
                        print("fetching result for=", item.id ?? "")
                        let results = try await self.getAthleteResult(item.id ?? "")
                        if let index = athletesList.firstIndex(where: {$0.id == item.id}){
                            athletesList[index].medals = results
                        }
                    }
                }
                return athletesList
            }catch(let error){
                print("error in viewmodel=",error)
                throw APIError.requestFailedReason(reason: error.localizedDescription)
            }
        }catch(let error){
            throw APIError.requestFailedReason(reason: error.localizedDescription)
        }
    
    }
    /// fetch all athlete results
    func getAthleteResult(_ id:String) async throws ->[MedalModel]{
        
        do{
            let data = try await self.networkManger.executeNetworkRequestAsync(UrlManager.athleteDetailsUrl(id), httpMethod: AppConstants.httpMethod.get)
            let decoderParser = JSONDecoder()
            decoderParser.dateDecodingStrategy = .iso8601
            do{
                let medalsList = try decoderParser.decode([MedalModel].self, from: data)
                print("fetched result for=", id,",count=", medalsList.count)
                return medalsList
            }catch(let error){
                print("error in viewmodel=",error)
                throw APIError.requestFailedReason(reason: error.localizedDescription)
            }
        }catch(let error){
            throw APIError.requestFailedReason(reason: error.localizedDescription)
        }
    
    }

}

class HomeSceneViewModelData{
    static func generateData()->[GameModel]{
        var data = [GameModel]()
        data.append(GameModel.init(id: UUID().uuidString, city: "Tokyo", year: "2020"))
        data.append(GameModel.init(id: UUID().uuidString, city: "Tokyo", year: "2020"))
        data.append(GameModel.init(id: UUID().uuidString, city: "Tokyo", year: "2020"))
        data.append(GameModel.init(id: UUID().uuidString, city: "Tokyo", year: "2020"))
        data.append(GameModel.init(id: UUID().uuidString, city: "Tokyo", year: "2020"))
        data.append(GameModel.init(id: UUID().uuidString, city: "Tokyo", year: "2020"))
        return data
    }
}
