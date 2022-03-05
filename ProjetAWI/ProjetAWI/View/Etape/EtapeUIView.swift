//
//  EtapeUIView.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct EtapeUIView : View {
    @ObservedObject var ft : FTViewModel
    @ObservedObject var ftvm : FTVM
    @ObservedObject var etape : Etape
    
    var body : some View {
        VStack(spacing : 30){
            Text("\(etape.titreEtape)")
                .font(.largeTitle)
                .padding(10)
            Text("\(etape.descEtape)")
                .font(.headline)
                .padding(10)
            List{
                ForEach(etape.listIng.indices){ ing in
                    HStack{
                        Text("\(etape.listIng[ing].ingredientName)")
                        Text("\(etape.listQuantity[ing])")
                        Text("\(etape.listIng[ing].ingredientUnit)")
                    }
                }
            }
            .background(Color(red: 0.8784, green : 0.8039, blue : 0.6627))
        }
        .navigationBarItems(trailing: Text("\(etape.duree) min")
                                .bold())
        .background(Color(red: 0.8784, green : 0.8039, blue : 0.6627))
    }
}

