//
//  ContentView.swift
//  Olympic
//
//  Created by MacBook on 09/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    //// state manager of home screen and also to manage selected game and athlete
    @StateObject var vmHomeScene = HomeSceneViewModel()
    //// after splash show home screen
    @State var showNextScreen:Bool = false
    
    var body: some View {
        NavigationStack{
            
            Group{
                if showNextScreen == false{
                    VStack {
                        Image("splash_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.accentColor)
                        Text("Olympic")
                            .font(.largeTitle)
                    }
                    .padding()
                }else{
                    HomeSceneView()
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    showNextScreen = true
                }
            }

        }.environmentObject(vmHomeScene)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
