//
//  ProjetAWIApp.swift
//  ProjetAWI
//
//  Created by m1 on 17/02/2022.
//

import SwiftUI
import Firebase

@main
struct ProjetAWIApp: App {
    //var tracksVM : TracksVM = TracksVM()
    //var ftvm : FTVM = FTVM()
    init(){
        FirebaseApp.configure()

    }
    	
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
        }
    }
}


