//
//  AthleteInfoView.swift
//  Olympic
//
//  Created by MacBook on 10/03/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct AthleteInfoView: View {
    
    @Binding var athlete:AthleteModel
    @Binding var medals:[MedalModel]
    
    var body: some View {
        HStack{
            HStack{
                WebImage(url: UrlManager.athletePhotoUrl(athlete.image ?? ""))
                    .resizable()
                    .placeholder(Image("placeholder"))
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .shadow(radius: 1)
                    .frame(width: 120, height: 120)
                Spacer()
                HStack{
                    VStack(spacing:5){
                        HStack{
                            Text("Name:")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text((athlete.surname ?? "") + " " + (athlete.name ?? ""))
                                .font(.subheadline)
                            Spacer()
                        }
                        Divider()
                        HStack{
                            Text("DOB:")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text((athlete.dateOfBirth ?? ""))
                                .font(.subheadline)
                            Spacer()
                        }
                        Divider()
                        HStack{
                            Text("Weight:")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text(String((athlete.weight ?? 0)) + " Kg")
                                .font(.subheadline)
                            Spacer()
                        }
                        Divider()
                        HStack{
                            Text("Height:")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text(String((athlete.height ?? 0)) + " cm")
                                .font(.subheadline)
                            Spacer()
                        }
                    }
                }
            }
        }
        .frame(maxWidth:.infinity)
        .padding(.horizontal)
    }
}

struct AthleteInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AthleteInfoView(athlete: .constant(GameAthletesViewlData.generateData()[0]), medals: .constant(DetailsAthleteSceneViewModelData.generateData()))
    }
}
