//
//  FTCardView.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//


import SwiftUI

struct FTCardView : View {
    @ObservedObject var ft : FTViewModel
    @ObservedObject var ftvm : FTVM
    var body : some View {
        //        VStack(alignment: .leading){
        //            NavigationLink(destination: FTUIView(ft : ft, ftvm : ftvm)){
        //                VStack(alignment: .leading){
        //                    Text(ft.ficheTechniqueName)
        //                    Spacer()
        //                    Text("\(ft.ficheTechniqueAuthor)")
        //                        .bold()
        //                    Spacer()
        //
        //                }
        //
        //            }
        //        }
        VStack{
            AsyncImage(url: URL(string: ft.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment : .bottom) {
                        Text(ft.ficheTechniqueName)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 136)
                            .padding()
                    }
                    .overlay(alignment : .top) {
                        Text(ft.ficheTechniqueAuthor)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 136)
                            .padding()
                    }
            } placeholder : {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment : .bottom) {
                        Text(ft.ficheTechniqueName)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 136)
                            .padding()
                    }
                    .overlay(alignment : .top) {
                        Text(ft.ficheTechniqueAuthor)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 136)
                            .padding()
                    }
            }
        }
        .frame(width: 160, height: 217, alignment: .top)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
    }
}





