//
//  AthleteCardView.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//
// AthleteCardView shows athlete photo and name

import SwiftUI
import SDWebImageSwiftUI

struct AthleteCardView: View {
    
    @State var athlete:AthleteModel
    
    var body: some View {
        HStack{
            VStack{
                WebImage(url: UrlManager.athletePhotoUrl(athlete.image ?? ""))
                    .resizable()
                    .placeholder(Image("placeholder"))
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    //.overlay(Circle().strokeBorder(.red, lineWidth: 4.0))
                    .shadow(radius: 1)
                    .frame(width: 100, height: 100)
                HStack{
                    Text((athlete.surname ?? "") + " " + (athlete.name ?? ""))
                        .font(.subheadline)
                }
            }
        }.padding(.horizontal)
    }
}

struct AthleteCardView_Previews: PreviewProvider {
    static var previews: some View {
        AthleteCardView(athlete: GameAthletesViewlData.generateData()[0])
            
    }
}
