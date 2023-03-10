//
//  View+Extension.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//

import Foundation
import SwiftUI
/** shows skelton while loading*/

extension View {
    @ViewBuilder
    func redacted(if condition: @autoclosure () -> Bool) -> some View {
        redacted(reason: condition() ? .placeholder : [])
    }
}

extension View{
    func navigationBarHidden() -> some View{
        self
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
    }
}

