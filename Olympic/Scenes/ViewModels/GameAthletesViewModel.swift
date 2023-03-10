//
//  GameAthletesViewModel.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//

import Foundation
import SwiftUI

class GameAthletesViewModel:ObservableObject{
    //// API loading and error showing
    @Published var isLoading: Bool = false
    @Published var isAPILoaded: Bool = false
    @Published var alertTitle:String = ""
    @Published var alertMessage:String = ""
    @Published var showAlert:Bool = false
    ///holds the athletes list of specific game
    @Published var athletes = [AthleteModel]()
    ////local instance to call network requests
    let networkManger = NetworkManager()
    
    /// fetch game athletes list
    func getGameAthletes(_ game:GameModel){
        self.isLoading = true
        self.networkManger.executeNetworkRequest(UrlManager.gameAthletesUrl(game.id ?? ""),httpMethod: AppConstants.httpMethod.get, completionHandler: { (response) in
            switch response{
            case .failure(let error):
                self.isLoading = false
                self.alertTitle = "Oops!"
                self.alertMessage = error.errorDescription ?? error.localizedDescription
                self.showAlert = true
                self.athletes = []
            case .success(let result):
                if let data = result{
                    let decoderParser = JSONDecoder()
                    decoderParser.dateDecodingStrategy = .iso8601
                    do{
                        self.athletes = try decoderParser.decode([AthleteModel].self, from: data)
                    }catch(let error){
                       print("error in viewmodel=",error)
                    }
                }else{
                    self.athletes = []
                }
            }
            self.isAPILoaded = true
            self.isLoading = false
        })
    }
}

class GameAthletesViewlData{
    static func generateData()->[AthleteModel]{
        var data = [AthleteModel]()
        data.append(AthleteModel.init(id: UUID().uuidString, name: "Arianna", surname: "Fontana", image: "1"))
        data.append(AthleteModel.init(id: UUID().uuidString, name: "Arianna", surname: "Fontana", image: "1"))
        data.append(AthleteModel.init(id: UUID().uuidString, name: "Arianna", surname: "Fontana", image: "1"))
        data.append(AthleteModel.init(id: UUID().uuidString, name: "Arianna", surname: "Fontana", image: "1"))
        data.append(AthleteModel.init(id: UUID().uuidString, name: "Arianna", surname: "Fontana", image: "1"))
        data.append(AthleteModel.init(id: UUID().uuidString, name: "Arianna", surname: "Fontana", image: "1"))
        return data
    }
}
