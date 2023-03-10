//
//  HomeSceneView.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//
//  HomeSceneView is home screen of the app, it shows games list

import SwiftUI

struct HomeSceneView: View {
    
    @EnvironmentObject var vmHomeScene:HomeSceneViewModel
    
    let rows: [GridItem] = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        ZStack{
            VStack() {
                if vmHomeScene.isLoading == true && vmHomeScene.isAPILoaded == false {
                    ProgressView()
                    Text("Loading Results")
                        .font(.appFont(14))
                }
                ScrollView(.vertical) {
                    ForEach(vmHomeScene.games) { game in
                        GameAthletesView(game: game)
                            .padding([.bottom], 15)
                    }
                }.redacted(if: vmHomeScene.isAPILoaded == false)
            }
            if vmHomeScene.showRetry{
                RetryView
            }
        }
        .onAppear{
            Task{
                if vmHomeScene.games.isEmpty{
                    vmHomeScene.isLoading = true
                    /// generate temp data for skelton loading animation
                    vmHomeScene.games = HomeSceneViewModelData.generateData()
                    /// first fetch athletes alongwith results
                    vmHomeScene.athletes = try await vmHomeScene.getAllAthletes()
                    /// now finally get games
                    vmHomeScene.getAllGames()
                }
            }
        }
        .alert(isPresented: $vmHomeScene.showAlert) {
            Alert(title: Text(vmHomeScene.alertTitle), message: Text(vmHomeScene.alertMessage))
        }
        .refreshable {
            Task {
                vmHomeScene.isLoading = true
                vmHomeScene.isAPILoaded = false
                vmHomeScene.getAllGames()
            }
        }
        .navigationTitle("Olympic Athletes")
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.bottom)
        .padding([.top], 1)
        .navigationDestination(isPresented: $vmHomeScene.showDetailsScreen) {
            DetailsAthleteSceneView()
        }
    }
    
    var RetryView: some View{
        VStack{
            Image(systemName: "repeat.circle")
                .resizable()
                .frame(width: 30, height: 30)
            Text("Retry")
                .font(.appFont(14))
        }.onTapGesture {
            vmHomeScene.showRetry = false
            vmHomeScene.isLoading = true
            vmHomeScene.games = HomeSceneViewModelData.generateData()
            vmHomeScene.getAllGames()
        }
    }
}

struct HomeSceneView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSceneView()
    }
}
