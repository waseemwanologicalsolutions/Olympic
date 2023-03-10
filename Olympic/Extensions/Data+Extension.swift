//
//  Data+Extension.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//

import Foundation
extension Data{
    
    func dataToJsonStringArray() -> [String]?{
        
        do {
            if let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String] {

                return json
                
            }else{
                
                return nil
            }
        } catch let error as NSError {
            
            print("Failed in model calss: \(error.localizedDescription)")
            return nil
        }
    }
    func dataToJson() -> [String: Any]?{
        
        do {
            if let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] {

                return json
                
            }else{
                
                return nil
            }
        } catch let error as NSError {
            
            print("Failed in model calss: \(error.localizedDescription)")
            return nil
        }
    }
    func dataToJsonList() -> [[String: Any]]?{
        
        do {
            if let json = try JSONSerialization.jsonObject(with: self, options: []) as? [[String: Any]] {

                return json
                
            }else{
                
                return nil
            }
        } catch let error as NSError {
            
            print("Failed in model calss: \(error.localizedDescription)")
            return nil
        }
    }
    
    func decodeTo<T:Decodable>(_ objectType: T.Type)->T?{
        do {
            let obj = try JSONDecoder().decode(T.self, from: self)
            return obj
        }catch let error as NSError{
            print("Failed in model calss: \(error.localizedDescription)")
            print(error)
            return nil
        }
    }
    
    func fileMimieType(extensionFile:String = "") -> String{
        
        let array = [UInt8](self)
        var ext: String = ""
        
        switch (array[0]) {
        case 0xFF:
            ext = "image/jpg"
        case 0x89:
            ext = "image/png"
        case 0x47:
            ext = "image/gif"
        case 0x49, 0x4D :
            ext = "image/tiff"
        default:
            ext = "image/unknown"
            if extensionFile.lowercased() == "pdf"{
                ext = "application/pdf"
            }
        }
        
        print(ext)
        
        return ext
    }
}
