//
//  SheetView.swift
//  ProjetAWI
//
//  Created by m1 on 17/02/2022.
//

import Foundation
import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vmingredient : IngredientViewModel
    @ObservedObject var ingredientsVM : IngredientsVM
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    var intent : Intent
    
    init(vmingredient : IngredientViewModel, ingredientsVM : IngredientsVM){
        self.vmingredient = vmingredient
        self.ingredientsVM = ingredientsVM
        self.intent = Intent()
        //le VM est enregistré comme souscrivant aux actions demandées (publications des modifs du state de l'Intent)
        self.intent.addObserver(viewModel: self.vmingredient)
        self.intent.addObserver(listViewModel: self.ingredientsVM)
    }
    var body: some View {
        VStack{
            Form{
                Section{
                    VStack(alignment: .leading){Text("Nouveau nom : ")
                        .padding(10)
                    TextField("Entrer le nouveau nom", text: $vmingredient.ingredientName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(10)
                    Text("Nouvelle unité : ")
                        .padding(10)
                    TextField("Entrer la nouvelle unité", text: $vmingredient.ingredientUnit)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(10)}
                    Text("Nouveau stock : ")
                        .padding(10)
                    TextField("Entrer le nouveau stock", text: $vmingredient.ingredientStocks)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(10)
                    Text("Nouveau prix unitaire : ")
                        .padding(10)
                    TextField("Entrer le nouveau prix unitaire", text: $vmingredient.ingredientUnitprice)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(10)
                    Text("Nouvelle catégorie : ")
                        .padding(10)
                    Picker("Catégorie", selection: $vmingredient.ingredientCategory) {
                        ForEach(CategoryIng.allCases){ categorie in
                            Text(categorie.rawValue)
                                .tag(categorie)
                        }
                    }.pickerStyle(.menu)
                    Text("Allergène : ")
                        .padding(10)
                    Picker("Allergène", selection: $vmingredient.ingredientAllergene) {
                            Text("Oui").tag("oui")
                            Text("Non").tag("non")
                        }.pickerStyle(.menu)
                }
            }
            Button(action : {

                intent.intentToChangeName(name: vmingredient.ingredientName); intent.intentToChangeUnit(unit: vmingredient.ingredientUnit); intent.intentToChangeStocks(stocks: vmingredient.ingredientStocks); intent.intentToChangeUnitprice(unitprice: vmingredient.ingredientUnitprice); intent.intentToChangeCategory(category: vmingredient.ingredientCategory); intent.intentToChangeAllergene(allergene: vmingredient.ingredientAllergene);
                self.vmingredient.update();

                dismiss()

                //print(Bundle.main.url(forResource : "playlist2", withExtension : "json"))
                //dismiss()
                
            }, label : {
                Text("Enregistrer")
                    .bold()
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(Color.green.opacity(0.85))
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
            })
                .padding()
        }
        .onChange(of: vmingredient.error){
            error in
            switch error{
            case .noError:
                return
            case .tooShortName:
                self.errorMessage = "\(error)"
                self.showingAlert = true
            }
        }
        .alert(errorMessage, isPresented: $showingAlert){
            Button("Ok", role: .cancel) { }
        }
        
    }
    
}
