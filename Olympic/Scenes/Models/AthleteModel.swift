//
//  AthleteModel.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//

import Foundation
struct AthleteModel: Decodable, Identifiable {
    var id: String?
    var name: String?
    var surname:String?
    var dateOfBirth:String?
    var bio:String?
    var weight:Int?
    var height:Int?
    var image: String?
    var medals = [MedalModel]()
    var globalScore:Int = 0
    
    enum CodingKeys:String,CodingKey{
        case id = "athlete_id"
        case name = "name"
        case surname = "surname"
        case dateOfBirth = "dateOfBirth"
        case bio = "bio"
        case weight = "weight"
        case height = "height"
        case image = "photo_id"
    }
    
    init(id: String?, name: String?,surname:String?, image:String?){
        self.id = id
        self.name = name
        self.surname = surname
        self.image = image
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
        name = try values.decode(String.self, forKey: .name)
        surname = try values.decode(String.self, forKey: .surname)
        dateOfBirth = try values.decode(String.self, forKey: .dateOfBirth)
        bio = try values.decode(String.self, forKey: .bio)
        weight = try values.decode(Int.self, forKey: .weight)
        height = try values.decode(Int.self, forKey: .height)
        do{
            image = try values.decode(String.self, forKey: .image)
        }catch(_){
            do{
                let val = try values.decode(Int.self, forKey: .image)
                image = String(val)
            }catch(let error){
                print("error=",error)
            }
        }
    }
}
