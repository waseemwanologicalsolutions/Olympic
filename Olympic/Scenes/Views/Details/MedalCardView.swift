//
//  MedalCardView.swift
//  Olympic
//
//  Created by MacBook on 10/03/2023.
//

import SwiftUI

struct MedalCardView: View {
    
    @State var medal:MedalModel
    var body: some View {
        HStack{
            HStack{
                Text((medal.city ?? "") + " " + (String(medal.year ?? 0)))
                    .font(.subheadline)
                Spacer()
                HStack(spacing:15){
                    if (medal.gold ?? 0) > 0{
                        HStack(spacing:3){
                            Text(String(medal.gold ?? 0))
                            Image("medals")
                                .resizable()
                                .foregroundColor(Color.ol_gold)
                                .aspectRatio(contentMode: .fit)
                                .frame(width:20, height:20)
                        }.padding(0)
                    }
                    if (medal.silver ?? 0) > 0{
                        HStack(spacing:3){
                            Text(String(medal.silver ?? 0))
                            Image("medals")
                                .resizable()
                                .foregroundColor(Color.ol_silver)
                                .aspectRatio(contentMode: .fit)
                                .frame(width:20, height:20)
                        }.padding(0)
                    }
                    if (medal.bronze ?? 0) > 0{
                        HStack(spacing:3){
                            Text(String(medal.bronze ?? 0))
                            Image("medals")
                                .resizable()
                                .foregroundColor(Color.ol_bronze)
                                .aspectRatio(contentMode: .fit)
                                .frame(width:20, height:20)
                        }.padding(0)
                    }
                }
            }
        }.padding(.horizontal)
    }
}

struct MedalCardView_Previews: PreviewProvider {
    static var previews: some View {
        MedalCardView(medal: MedalModel(id: UUID().uuidString, city: "Tokyo", year: 2006, gold: 1, silver: 2, bronze: 3))
    }
}
