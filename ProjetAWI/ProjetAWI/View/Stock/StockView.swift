//
//  StockView.swift
//  ProjetAWI
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import SwiftUI

struct StockView : View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedPlat: String = ""
    @State private var showingSheet = false
   /* var ftt : FicheTechnique = FicheTechnique(ficheTechniqueId: "", image: "", ficheTechniqueName: "", ficheTechniqueAuthor: "", ficheTechniqueDesc: "", listEtapes: [], ficheTechniqueCategory: "")*/
    @ObservedObject var ftvm : FTVM


    let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    @State var nbPlat : Int = 1
    var body : some View {
        
       

        VStack(alignment: .center){
            Image(systemName: "bag.fill")
                .imageScale(.large)
               // .resizable()
                //.frame(width: 300, height: 30, alignment: .center)
                .padding(.bottom, 10)
                .foregroundColor(.green.opacity(0.35))

                .padding(.top, 10)
                form()
            HStack{
                Spacer()
            Image("bon-appetit-removebg-preview")
                //.imageScale(.large)
                .resizable()
                .frame(width: 100, height: 75, alignment: .center)
                .padding(.bottom, 10)
                .foregroundColor(.green.opacity(0.35))
                .padding(.top, 10)
                Spacer()
            }
            
              
        
        
            Button(action : {
                 //self.ftvm.getRecetteByName(name:selectedPlat)
               // self.ftvm.downIng(ft: selectedPlat)
                //recuperer les ingredients
                let tabIng : [IngredientViewModel] = self.ftvm.recupIng(ft: selectedPlat)
//                for i in stride(from: 0, to: tabIng.count, by: 1){
//                    // print(tabIng[i].getIngredient(name: tabIng[i].ingredientName))
//                }
                let tabQuantity : [Int] = self.ftvm.recupQuantity(ft: selectedPlat)
                var i : Int = 0
                var stocks : String = "100"
                var passage : Int = 100
                for ing in tabIng{
                    

                    passage = Int(ing.ingredientStocks)! - Int(tabQuantity[i])*nbPlat
                    stocks = String(passage)
                    //print(ing.ingredientName)
                    //print(ing.ingredientId)
                    ing.updateIngredient(ingredient: ing.model, stocks : stocks)
                    i = i + 1
                    
                }
                
            }, label : {
            Text("Ajouter la vente")
                    .bold()
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(Color.green.opacity(0.85))
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
                
            })
                Button(action : {showingSheet.toggle()
                    
                }, label : {
                Text("Imprimer une étiquette")
                        .bold()
                        .frame(width: 200, height: 40, alignment: .center)
                        .background(Color.green.opacity(0.85))
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                }).sheet(isPresented: $showingSheet) { EtiquetteView(ftvm : ftvm) }
        }.navigationTitle("Gérer vos stocks")
        .navigationViewStyle(.stack)
}

}

extension StockView {
    
    private func form() -> some View {
        Form {
            Text("Sélectionner un plat pour effectuer une vente et mettre les stocks à jour")

            Section(header : Text("Plat ")) {
                Picker(selection: $selectedPlat, label: Text("Choisir un plat")) {
                    ForEach(ftvm.fts){ recette in
                        Text(recette.ficheTechniqueName)
                            .tag(recette.ficheTechniqueName)
                    }
                }
                .pickerStyle(.menu)
            }
            
            Section(header : Text("Nombre de plats vendus")) {
                TextField("Entrer le nombre de plats vendus", value: $nbPlat, formatter : formatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(5)
            
           
        }
           
        
    }
        

    }
   
}
