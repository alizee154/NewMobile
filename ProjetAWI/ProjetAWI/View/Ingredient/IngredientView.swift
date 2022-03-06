//
//  IngredientView.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct IngredientView: View {
    //@ObservedObject var ingredientsVM : IngredientsVM = IngredientsVM()
    @ObservedObject var ingredientsVM : IngredientsVM
    @State private var search : String = ""
    @State private var showingSheet = false

    //@State private var jsonData = JSONHelper.loadFromFile(name: "playlist2", extension1: json)
    
    var body: some View {
        VStack{
            
            Button(action : {
                showingSheet.toggle()
            }, label : {
                Text("Ajouter un ingrédient")
                    .bold()
                    .frame(width: 200, height: 40, alignment: .center)
                    .background(Color.green.opacity(0.85))
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
            }).sheet(isPresented: $showingSheet) { FormIngredientView(ingredientsVM: ingredientsVM) }
            .padding(30)
        
        List {
            /*Text("Féculent")
            ForEach("Féculent" == "" ? ingredientsVM.ingredients: ingredientsVM.ingredients.filter{ $0.ingredientCategory.contains("Féculent") || $0.ingredientCategory.contains(search)}, id: \.ingredientName)//tracksVM.tracks, id: \.trackId){
            {
                ingredient in
                ListIngredientView(ingredient : ingredient, ingredientsVM : ingredientsVM)
            }
            Text("Sauce")
            ForEach("Sauce" == "" ? ingredientsVM.ingredients: ingredientsVM.ingredients.filter{ $0.ingredientCategory.contains("Sauce") || $0.ingredientCategory.contains(search)}, id: \.ingredientName)//tracksVM.tracks, id: \.trackId){
            {
                ingredient in
                ListIngredientView(ingredient : ingredient, ingredientsVM : ingredientsVM)
            }*/
            ForEach(search == "" ? ingredientsVM.ingredients: ingredientsVM.ingredients.filter{ $0.ingredientName.contains(search) || $0.ingredientCategory.contains(search)}, id: \.ingredientName)//tracksVM.tracks, id: \.trackId){
            {
                ingredient in
                ListIngredientView(ingredient : ingredient, ingredientsVM : ingredientsVM)
            }
            //.listStyle(PlainListStyle())
            .onDelete(perform : ingredientsVM.deleteIngredient)
            .onMove(perform : ingredientsVM.moveIngredient)
        }
        
        .navigationTitle("Mes Ingrédients")
        .searchable(text : $search)
            
                    
                }
            }
        
        
    }
        
    
     
//
//  ListFTView.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//
/*
import SwiftUI

struct IngredientView: View {
    @State private var search : String = ""
    @ObservedObject var ingredientsVM : IngredientsVM
    var body : some View {
            ScrollView {
                //Spacer()
                VStack{
                    HStack{
                        Text("Ingrédients")
                            .font(.title)
                            .fontWeight(.medium)
                            .opacity(0.7)
                        
                        Spacer()
                    }
                    List{
                        
                        ForEach(search == "" ? ingredientsVM.ingredients: ingredientsVM.ingredients.filter{ $0.ingredientName.contains(search) || $0.ingredientCategory.contains(search)}, id: \.ingredientName)//tracksVM.tracks, id: \.trackId){
                        {
                            ingredient in
                            ListIngredientView(ingredient : ingredient, ingredientsVM : ingredientsVM)
                               /* NavigationLink(destination: IngredientUIView(ingredient : ingredient, ingredientsVM : ingredientsVM)){
                                    VStack(alignment: .leading){
                                        Text(ingredient.ingredientName).bold()
                                        Spacer()
                                        
                                        
                                    }
                                    
                                }*/
                            
                            }
                            
                        
                    }
                    .navigationBarTitleDisplayMode(.inline)
                
                    .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
                    .padding(.top)
                }
                .padding(.horizontal)
            }
                
        }
        
        
        //.ignoresSafeArea()
    }



    
*/
