# Olympic
This app allows public to view the Olympic games and Athletes details.
Video https://youtu.be/4AhgSybfRz4

# Platform
iOS

# Development Stack
SwiftUI, Xcode14

# Requirements
- Xcode v 14+
- Inernet connection
- Simulator iOS 16+

# How to run the project
In order to run the project please follow below steps.
1- Clone or download zip
2- Open the folder 'Olympic'
3- Double tap 'Olympic.xcodeproj'
4- Once Xcode finsih loding and indexing, select Simulator from the devices list
5- Run the project

# How to use the app
After splash screen app will show 'Olymic Athletes' screen which is home screen of the app,
This screen shows list of games, and in each game there is athletes list being shown,
Scroll vertically to see more games
Scroll horizontally to see more athletes
Tap on athlete photo view details about athlete games and medals
In case no app shows error, pull down to refersh the screen

# Understaning Implementation
Project architecure is MVVM, app has two scenes(navigations)
## HomeSceneView: 
its home screen which shows games list and athleses inside each game
### 'HomeSceneViewModel' 
view model fetch the games list
### 'GameAthletesView' 
view shows the game atheletes list
#### 'AthleteCardView' 
view shows the athelete

## DetailsAthleteSceneView: 
its shows the athlete details and medals list
### 'DetailsAthleteSceneViewModel' 
view model fetch the medals list
### 'AthleteInfoView' 
view shows the athelete info
### 'MedalCardView' 
view shows medal details

