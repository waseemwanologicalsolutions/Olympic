//
//  GameAthletesView.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//  GameAthletesView shows list of athletes of specific game

import SwiftUI

struct GameAthletesView: View {
    
    @EnvironmentObject var vmHomeScene:HomeSceneViewModel
    @StateObject var vmGameAthletesView = GameAthletesViewModel()
    @State var game:GameModel
    @State var athletesTemplate = GameAthletesViewlData.generateData()

    let rows: [GridItem] = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            HStack{
                Text((game.city ?? "") + " " + (game.year ?? ""))
                    .font(.headline)
                Spacer()
            }.padding()
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .center, spacing: 0) {
                    if vmGameAthletesView.isAPILoaded == false{
                        ForEach(athletesTemplate) { athlete in
                            AthleteCardView(athlete: athlete)
                        }
                    }else{
                        ForEach(vmGameAthletesView.athletes) { athlete in
                            AthleteCardView(athlete: athlete)
                                .onTapGesture{
                                    print("tapped")
                                    vmHomeScene.selectedGame = game
                                    vmHomeScene.selectedAthlete = athlete
                                    vmHomeScene.showDetailsScreen.toggle()
                                }
                        }
                        if vmGameAthletesView.athletes.isEmpty{
                            VStack{
                                RetryView
                            }
                            .padding(.horizontal)
                            .frame(maxWidth:.infinity)
                        }
                    }
                }
            }.redacted(if: vmGameAthletesView.isAPILoaded == false)
        }
        .onChange(of: vmHomeScene.isGamesLoaded){ newVal in
            Task{
                if newVal == true{
                    vmGameAthletesView.getGameAthletes(game, globalAthletes: vmHomeScene.athletes)
                }
            }
        }

    }
    var RetryView: some View{
        VStack{
            Text("No Athletes Found")
                .font(.footnote)
            Image(systemName: "repeat.circle")
                .resizable()
                .frame(width: 30, height: 30)
            Text("Retry")
                .font(.appFont(14))
        }.onTapGesture {
            vmGameAthletesView.isAPILoaded = false
            vmGameAthletesView.isLoading = true
            vmGameAthletesView.getGameAthletes(game, globalAthletes: vmHomeScene.athletes)
        }
    }
}

struct GameAthletesView_Previews: PreviewProvider {
    static var previews: some View {
        GameAthletesView(game: HomeSceneViewModelData.generateData()[0])
            .environmentObject(HomeSceneViewModel())
    }
}
