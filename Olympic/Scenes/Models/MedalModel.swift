//
//  MedalModel.swift
//  Olympic
//
//  Created by MacBook on 10/03/2023.
//

import Foundation
struct MedalModel: Decodable, Identifiable, Equatable {
    var id: String?
    var city: String?
    var year:Int?
    var gold:Int?
    var silver:Int?
    var bronze:Int?

    enum CodingKeys:String,CodingKey{
        case id = "game_id"
        case city = "city"
        case year = "year"
        case gold = "gold"
        case silver = "silver"
        case bronze = "bronze"
    }
    
    init(id: String?, city: String?,year:Int?, gold:Int?, silver:Int?,bronze:Int?){
        self.id = id
        self.city = city
        self.year = year
        self.gold = gold
        self.silver = silver
        self.bronze = silver
    }
    
    init(from decoder: Decoder) throws {
       
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        id = UUID().uuidString
        
        city = try values.decode(String.self, forKey: .city)
        do{
            year = try values.decode(Int.self, forKey: .year)
        }catch(_){
            do{
                let val = try values.decode(String.self, forKey: .year)
                year = Int(val)
            }catch(let error){
                print("error=",error)
            }
        }
        
        do{
            gold = try values.decode(Int.self, forKey: .gold)
        }
        do{
            silver = try values.decode(Int.self, forKey: .silver)
        }
        do{
            bronze = try values.decode(Int.self, forKey: .bronze)
        }
    }
}
