//
//  IngredientUIView.swift
//  ProjetAWI
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import SwiftUI

struct IngredientUIView : View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSheet = false
    //@ObservedObject var ingredient : Ingredient
    @ObservedObject var ingredientsVM : IngredientsVM
    @ObservedObject var ingredient : IngredientViewModel

    var body : some View {
        ScrollView{
        VStack{
            Image(systemName: "heart.fill")
                .imageScale(.large)
                .foregroundColor(.green)
                .padding(10)
            Text(ingredient.ingredientName).bold()
            /*Text("Nom de l'ingrédient : \(ingredient.ingredientName)")
                .padding(10)*/
            VStack(alignment: .leading){
                Text("Unité :   \(ingredient.ingredientUnit)")
                .padding(10)
            Text("Stock :   \(ingredient.ingredientStocks)")
                .padding(10)
            Text("Prix unitaire :   \(ingredient.ingredientUnitprice)")
                .padding(10)
            Text("Catégorie :   \(ingredient.ingredientCategory)")
                .padding(10)
            Text("Allergène :   \(ingredient.ingredientAllergene)")
                .padding(10)
            }
            Button(action : {
                showingSheet.toggle()
            }, label : {
                Text("Modifier l'ingrédient")
                    .bold()
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(Color.green.opacity(0.85))
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
            }).sheet(isPresented: $showingSheet) { SheetView(vmingredient : ingredient, ingredientsVM : ingredientsVM) }
            .padding(30)
        }

        Button(action : {
            //intent.intentToCreate(ft: vmft)
            //saveFT()
            self.ingredient.delete()
            //navigate = true
            
        },label : {
            Text("Supprimer l'ingrédient")
                .bold()
                .frame(width: 200, height: 40, alignment: .center)
                .background(Color.red.opacity(0.85))
                .cornerRadius(8)
                .foregroundColor(Color.white)
        })
        /*Button(action : {
            //intent.intentToCreate(ft: vmft)
            //saveFT()
            self.ingredient.updateStocks(ingredient: ingredient, stocks: "5")
            //navigate = true
            
        },label : {
            Text("Test")
                .bold()
                .frame(width: 200, height: 40, alignment: .center)
                .background(Color.green.opacity(0.85))
                .cornerRadius(8)
                .foregroundColor(Color.white)
        })*/
        }
        //.background(Color(red: 0.8784, green : 0.8039, blue : 0.6627).edgesIgnoringSafeArea(.all))
        
    }
    
}
