//
//  GameModel.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//

import Foundation
struct GameModel: Decodable, Identifiable {
    var id: String?
    var city: String?
    var year:String?

    enum CodingKeys:String,CodingKey{
        case id = "game_id"
        case city = "city"
        case year = "year"
    }
    
    init(id: String?, city: String?,year:String?){
        self.id = id
        self.city = city
        self.year = year
    }
    
    init(from decoder: Decoder) throws {
       
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        do{
            id = try values.decode(String.self, forKey: .id)
        }catch(_){
            do{
                let val = try values.decode(Int.self, forKey: .id)
                id = String(val)
            }catch(let error){
                print("error=",error)
            }
        }
        city = try values.decode(String.self, forKey: .city)
        do{
            year = try values.decode(String.self, forKey: .year)
        }catch(_){
            do{
                let val = try values.decode(Int.self, forKey: .year)
                year = String(val)
            }catch(let error){
                print("error=",error)
            }
        }
        //self.athletes = GameAthletesViewlData.generateData()
    }
}
