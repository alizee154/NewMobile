//
//  ListIngredientView.swift
//  ProjetAWI
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import SwiftUI

struct ListIngredientView : View {
    @ObservedObject var ingredient : Ingredient
    //@ObservedObject var ingredient : IngredientViewModel

    @ObservedObject var ingredientsVM : IngredientsVM
    var body : some View {
        VStack(alignment: .leading){
            NavigationLink(destination: IngredientUIView(ingredientsVM : ingredientsVM, ingredient : IngredientViewModel(ingredient : ingredient))){
                VStack(alignment: .leading){
                    Text(ingredient.ingredientName).bold()
                    Spacer()
                    Text("Stock : \(ingredient.ingredientStocks)")
                    
                }
                
            }
           // .environmentObject(ingredientsVM)
        }.onAppear(){
            self.ingredientsVM.fetchData()}
        
    }
}
