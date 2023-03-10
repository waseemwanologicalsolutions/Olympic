//
//  String+Extension.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//

import Foundation
extension String{
    var encodeURL:String{
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    
    func markdownToAttributed() -> AttributedString {
        do {
            return try AttributedString(markdown: self) /// convert to AttributedString
        } catch {
            return AttributedString("Error parsing markdown: \(error)")
        }
    }
}
