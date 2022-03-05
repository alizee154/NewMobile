//
//  FormIngredientView.swift
//  ProjetAWI
//
//  Created by m1 on 23/02/2022.
//

import Foundation
import SwiftUI

struct FormIngredientView : View {
    
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var ingredientsVM : IngredientsVM
    @State private var name : String = ""
    @State private var unit : String = ""
    @State private var stocks : String = ""
    @State private var unitprice : String = ""
    @Environment(\.dismiss) var dismiss

    @StateObject var newing : IngredientViewModel = IngredientViewModel(ingredient: Ingredient(ingredientId: "", ingredientName: "a", ingredientUnit: "",ingredientStocks: "",ingredientUnitprice: "",ingredientCategory: "",ingredientAllergene: ""))

    @StateObject var ingredient = IngredientViewModel(ingredient : Ingredient(ingredientId:"",ingredientName:"", ingredientUnit: "", ingredientStocks: "", ingredientUnitprice: "", ingredientCategory: "", ingredientAllergene: ""))
    var body : some View{
        NavigationView{
        Form{
            Section(header : Text("Nom")) {
                TextField("Enter a name", text: $newing.model.ingredientName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(5)
            }
            Section(header : Text("Unité")) {
                TextField("Enter an unit", text: $newing.model.ingredientUnit)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(5)
            }
            Section(header : Text("Stocks")) {
                TextField("Enter a stock", text: $newing.model.ingredientStocks)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(5)
            }
            Section(header : Text("Prix Unitaire")) {
                TextField("Enter a unitprice", text: $newing.model.ingredientUnitprice)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(5)
            }
            Section(header : Text("Catégorie")) {
                Picker("Catégorie", selection: $newing.model.ingredientCategory) {
                    ForEach(CategoryIng.allCases){ categorie in
                        Text(categorie.rawValue)
                            .tag(categorie)
                    }
                }.pickerStyle(.menu)
            }
            Section(header : Text("Allergène")) {
                Picker("Allergène", selection: $newing.model.ingredientAllergene) {
                        Text("Oui").tag("oui")
                        Text("Non").tag("non")
                    }
            }.pickerStyle(.menu)
        }
        /*VStack{
           
        
            Button("add",action : {
                
                /* ingredientsVM.addIngredient(ingredient: Ingredient(ingredientId: "ttt", ingredientName: name, ingredientUnit: unit, ingredientStocks: stocks, ingredientUnitprice: unitprice, ingredientCategory: "", ingredientAllergene:""))*/
                self.newing.save()
               
                 presentationMode.wrappedValue.dismiss()
             })
        }*/
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
                    //intent.intentToCreate(ft: vmft)
                    //saveFT()
                    
                    self.newing.save()
                    //navigate = true
                    dismiss()
                }){
                    Label("Done", systemImage : "checkmark")
                        .labelStyle(.iconOnly)
                }.disabled(newing.model.ingredientName.isEmpty || newing.model.ingredientStocks.isEmpty || newing.model.ingredientUnit.isEmpty || newing.model.ingredientUnitprice.isEmpty || newing.model.ingredientCategory.isEmpty || newing.model.ingredientAllergene.isEmpty)
                
            //}
        }
    }).navigationTitle("New Ingredient")
                .navigationBarTitleDisplayMode(.inline)
}
}
}
extension FormIngredientView {
    private func saveIng() {
        let ing = Ingredient(ingredientId: "" , ingredientName: newing.model.ingredientName, ingredientUnit: newing.model.ingredientUnit, ingredientStocks: newing.ingredientStocks, ingredientUnitprice: newing.model.ingredientUnitprice, ingredientCategory: "", ingredientAllergene:"")
        ingredientsVM.addIngredient(ingredient : ing)
    }
}
