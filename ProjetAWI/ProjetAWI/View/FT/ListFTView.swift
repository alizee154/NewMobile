//
//  ListFTView.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct ListFTView : View {
    @State private var search : String = ""
    @ObservedObject var ftvm : FTVM
    var body : some View {
            ScrollView {
                //Spacer()
                VStack{
                    HStack{
                        Text("Fiches techniques")
                            .font(.title)
                            .fontWeight(.medium)
                            .opacity(0.7)
                        
                        Spacer()
                    }
                    LazyVGrid(columns : [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15){
                        ForEach(search == "" ? ftvm.fts: ftvm.fts.filter{ $0.ficheTechniqueName.contains(search) || $0.ficheTechniqueAuthor.contains(search)}) {
                            ft in
                            NavigationLink(destination : FTUIView(ft : FTViewModel(ft: ft), ftvm : ftvm)){
                                FTCardView(ft: FTViewModel(ft: ft), ftvm: ftvm)
                            
                            }
                            
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("MyRecipeApp")
                    .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
                    //.padding(.top)
                }
                .padding(.horizontal)
        }
        //.onAppear(){
            //self.ftvm.getRecetteByNameBack(name: "Al")}
           // self.ftvm.fetchData()}
        //.onAppear(){
            //self.ftvm.getRecetteByNameBack(name: "Al")}
        
        //.ignoresSafeArea()
    }
}

