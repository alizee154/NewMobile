//
//  TabBar.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct TabBar : View {
    @State var selectedIndex = 0
    @State var presented = false
    let icons = [
        "house",
        "heart.text.square",
        "plus",
        "leaf.circle",
        "cart"
    ]
    
    @ObservedObject var ftvm : FTVM
    @ObservedObject var ingredientsVM : IngredientsVM

    var body : some View {
        VStack(spacing : 0){
            //Content
            ZStack{
                
                Spacer().sheet(isPresented: $presented, content : {
                    AddFTView(ftvm : ftvm)
                    Button(action :{
                        presented.toggle()
                    }){
                        
//                        Text("Close")
//                            .frame(width: 200, height : 50)
//                            .background(Color.pink)
//                            .cornerRadius(12)
//                            .padding()
                    }
                })
                switch selectedIndex {
                case 0:
//NavigationView{
                        ListFTView(ftvm: ftvm)
                      //  }
                case 1:
                   // NavigationView {
                        CategoriesView(ftvm : ftvm)
                   // }
                case 2:
                   // NavigationView {
                        AddFTView(ftvm : ftvm)
                  //  }
                case 3:
                   // NavigationView {
                        
                        IngredientView(ingredientsVM : ingredientsVM)
                   // }
                case 4:
                   // NavigationView {
                        StockView(ftvm : ftvm)
                   // }
                default:
                   // NavigationView {
                        ListFTView(ftvm: ftvm)
                   // }
                }
            }
            
            Spacer()
            
            Divider()
            
            Spacer()
            HStack{
                ForEach(0..<5, id : \.self) { number in
                    Spacer()
                    Button(action : {
                        if number == 2 {
                            presented.toggle()
                        }
                        else {
                            self.selectedIndex = number
                        }
                    }){
                        if number == 2 {
                            Image(systemName: icons[number])
                                .font(.system(size: 25, weight: .regular, design : .default))
                                .foregroundColor(.white)
                                .frame(width : 50, height : 50)
                                .background(Color.green)
                                .cornerRadius(25)
                                
                        }
                        else {
                            Image(systemName: icons[number])
                                .font(.system(size: 25, weight: .regular, design : .default))
                                .foregroundColor(selectedIndex == number ? Color(.label) : Color(UIColor.lightGray))
                        }
                    }
                    Spacer()
                }
            }
            Spacer()
        }
        
    }
}

