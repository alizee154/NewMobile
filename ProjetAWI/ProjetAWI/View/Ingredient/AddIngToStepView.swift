//
//  AddIngToStepView.swift
//  ProjetAWI
//
//  Created by m1 on 02/03/2022.
//

import SwiftUI

struct AddIngToStepView: View {
    @ObservedObject var step : Etape
    @EnvironmentObject var ingredientsVM : IngredientsVM
    @State private var search : String = ""
    @State private var ingredient : Ingredient = Ingredient(ingredientId: "", ingredientName: "", ingredientUnit: "", ingredientStocks: "", ingredientUnitprice: "", ingredientCategory: "", ingredientAllergene: "")
    @State private var quantity : String = ""
    @State private var selectedIngredient : String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form{
                Section(header : Text("Ingrédient")) {
                    Picker(selection: $ingredient.ingredientName, label: Text("Choisir un ingrédient")) {
                        ForEach(search == "" ? ingredientsVM.ingredients : ingredientsVM.ingredients.filter{ $0.ingredientName.contains(search)}) {
                            ing in
                                Text("\(ing.ingredientName)")
                                .tag(ing.ingredientName as String)
                                }
                            }
                    .pickerStyle(.menu)
                    }
                
                Section(header : Text("Quantité")) {
                    TextField("Quantité", text: $quantity)
                }
            }
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search ingredient")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action : {
                        dismiss()
                    }){
                        Label("Cancel", systemImage : "xmark")
                            .labelStyle(.iconOnly)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    //                    NavigationLink(isActive: $navigate) {
                    //                        ListFTView(ftvm: ftvm)
                    //                    } label: {
                    Button(action : {
//                        intent.intentToChange()
//                        saveEtape()
                        
                        saveIng(ing: getIngByName(ing: ingredient, ingredients: ingredientsVM), quantity: quantity)
                        dismiss()
                    }){
                        Label("Done", systemImage : "checkmark")
                            .labelStyle(.iconOnly)
                    }
                    .disabled(ingredient.ingredientName.isEmpty || quantity.isEmpty)
                }
            })
            .navigationTitle("Add Ingredient")
            .navigationBarTitleDisplayMode(.inline)
        }
       // .onAppear() {
           // self.ingredientsVM.fetchData()
       // }
    }
}

extension AddIngToStepView {
    private func saveIng(ing : Ingredient, quantity : String) {
        print("\(ing.ingredientName)")
        print("oui")
        print(quantity)
        print("\(ing.ingredientUnit)")
        step.listIng.append(ing)
        step.listQuantity.append(quantity)
    }
    
    private func getIngByName(ing : Ingredient, ingredients : IngredientsVM) -> Ingredient{
        var result : Ingredient = Ingredient(ingredientId: "", ingredientName: "", ingredientUnit: "", ingredientStocks: "", ingredientUnitprice: "", ingredientCategory: "", ingredientAllergene: "")
        for i in 0...ingredients.ingredients.count - 1 {
            if(ing.ingredientName == ingredients.ingredients[i].ingredientName){
                result = ingredients.ingredients[i]
                print(result.ingredientId)
            }
        }
        return result
    }
}

