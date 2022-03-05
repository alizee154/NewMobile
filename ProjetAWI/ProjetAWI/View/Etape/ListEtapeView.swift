//
//  ListEtapeView.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct ListEtapeView : View {
    @ObservedObject var ft : FTViewModel
    @ObservedObject var ftvm : FTVM
    @ObservedObject var etape : Etape
    var body : some View {
        VStack(alignment: .leading){
            NavigationLink(destination: EtapeUIView(ft : ft, ftvm : ftvm, etape : etape)){
                VStack(alignment: .center){
                    Text("\(etape.titreEtape)")
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(etape.duree) minutes")
                        .foregroundColor(.black)
                        .bold()
                    Divider()
                }
            }
        }
    }
}


