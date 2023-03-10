//
//  DetailsAthleteSceneViewModel.swift
//  Olympic
//
//  Created by MacBook on 10/03/2023.
//

import Foundation
import SwiftUI

class DetailsAthleteSceneViewModel:ObservableObject{
    //// API loading and error showing
    @Published var alertTitle:String = ""
    @Published var alertMessage:String = ""
    @Published var showAlert:Bool = false
    @Published var isLoading: Bool = false
    @Published var isAPILoaded: Bool = false
    /// holds the mdeals list of selected athlete
    @Published var medals = [MedalModel]()
   
    ////local instance to call network requests
    let networkManger = NetworkManager()
    
    /// fetch medals list of selected athelte
    func getAthleteResults(_ athlete:AthleteModel){
        self.isLoading = true
        self.networkManger.executeNetworkRequest(UrlManager.athleteDetailsUrl(athlete.id ?? ""),httpMethod: AppConstants.httpMethod.get, completionHandler: { (response) in
            switch response{
            case .failure(let error):
                self.isLoading = false
                self.alertTitle = "Oops!"
                self.alertMessage = error.errorDescription ?? error.localizedDescription
                self.showAlert = true
                self.medals = []
            case .success(let result):
                if let data = result{
                    let decoderParser = JSONDecoder()
                    decoderParser.dateDecodingStrategy = .iso8601
                    do{
                        let medalsList = try decoderParser.decode([MedalModel].self, from: data)
                        self.medals = medalsList.sorted(by: {$0.year! > $1.year!})
                    }catch(let error){
                       print("error in viewmodel=",error)
                        self.alertTitle = "Oops!"
                        self.alertMessage = error.localizedDescription
                        self.showAlert = true
                    }
                }else{
                    self.medals = []
                }
            }
            self.isAPILoaded = true
            self.isLoading = false
        })
    }
}

class DetailsAthleteSceneViewModelData{
    static func generateData()->[MedalModel]{
        var data = [MedalModel]()
        data.append(MedalModel(id: UUID().uuidString, city: "Tokyo", year: 2016, gold: 2, silver: 1, bronze: 1))
        data.append(MedalModel(id: UUID().uuidString, city: "Sochi", year: 2014, gold: 0, silver: 2, bronze: 1))
       
        return data
    }
}
