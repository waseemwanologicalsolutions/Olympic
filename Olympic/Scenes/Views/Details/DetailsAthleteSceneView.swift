//
//  DetailsAthleteSceneView.swift
//  Olympic
//
//  Created by MacBook on 10/03/2023.
//
//  DetailsAthleteSceneView shows athlete info and medals list

import SwiftUI

struct DetailsAthleteSceneView: View {
    
    @EnvironmentObject var vmHomeScene:HomeSceneViewModel
    @StateObject var vmDetailsAthleteSceneViewModel = DetailsAthleteSceneViewModel()
    @State var medals = [MedalModel]()
    
    var body: some View {
        ZStack{
            VStack() {
                ScrollView(.vertical) {
                    AthleteInfoView(athlete: .constant(vmHomeScene.selectedAthlete), medals: $medals)
                        .padding([.top], 20)
                    
                    VStack{
                        HStack{
                            Text("Medals")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding()
                            Spacer()
                        }
                        ForEach(medals) { medal in
                            MedalCardView(medal: medal)
                            Divider()
                                .padding(.horizontal)
                        }
                        HStack{
                            Text("Bio")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding()
                            Spacer()
                        }
                        Text((vmHomeScene.selectedAthlete.bio ?? "").markdownToAttributed())
                            .padding(.horizontal)
                            .padding([.bottom], 25)
                    }
                    
                }.redacted(if: vmDetailsAthleteSceneViewModel.isAPILoaded == false)
            }
        }
        .toolbar {
            Link(destination: URL(string: "https://www.youtube.com/watch?v=4AhgSybfRz4")!) {
                Image("youtube").resizable().frame(width: 28, height: 28)
            }
        }
        .onAppear{
            Task{
                if vmDetailsAthleteSceneViewModel.isAPILoaded == false{
                    vmDetailsAthleteSceneViewModel.isLoading = true
                    vmDetailsAthleteSceneViewModel.medals = DetailsAthleteSceneViewModelData.generateData()
                    vmDetailsAthleteSceneViewModel.getAthleteResults(vmHomeScene.selectedAthlete)
                }
            }
        }
        .alert(isPresented: $vmDetailsAthleteSceneViewModel.showAlert) {
            Alert(title: Text(vmDetailsAthleteSceneViewModel.alertTitle), message: Text(vmDetailsAthleteSceneViewModel.alertMessage))
        }
        .refreshable {
            Task {
                vmDetailsAthleteSceneViewModel.isLoading = true
                vmDetailsAthleteSceneViewModel.isAPILoaded = false
                vmDetailsAthleteSceneViewModel.getAthleteResults(vmHomeScene.selectedAthlete)
            }
        }
        .onChange(of: vmDetailsAthleteSceneViewModel.medals){ newVal in
            Task{
                self.medals = newVal
            }
        }
        .navigationTitle(navigationTitleString)
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.bottom)
        .padding([.top], 1)
    }
    
    var navigationTitleString:String{
        var subStrings = [String]()
        subStrings.append((vmHomeScene.selectedAthlete.surname ?? ""))
        subStrings.append(" ")
        subStrings.append((vmHomeScene.selectedAthlete.name ?? ""))
        return subStrings.joined()
    }
}

struct DetailsAthleteSceneView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsAthleteSceneView(medals: DetailsAthleteSceneViewModelData.generateData())
            .environmentObject(HomeSceneViewModel())
    }
}
