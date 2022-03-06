//
//  IngredientsVM.swift
//  ProjetAWI
//
//  Created by m1 on 22/02/2022.
//
import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class IngredientsVM : ObservableObject, Subscriber, Identifiable{
    @Published var ingredients : [Ingredient] = []
        
        private var db = Firestore.firestore()
    
    init(){
        self.fetchData()
        //getIngredients()
//getIngredients()
    }
    
    func getIngredients(){
        /*let newIngredients : [Ingredient] = [Ingredient(ingredientId:"1",ingredientName: "Saumon",ingredientUnit: "kg",ingredientStocks: "10",ingredientUnitprice: "15",ingredientCategory: "Poisson",ingredientAllergene: "oui")]*/
        
        //[
        //Track(trackId:1443921474,trackName: "That’s Life", artistName: "James Brown", collectionName: "Gettin Down to It", releaseDate: "1969-05-01T12:00:00Z"),
        //Track(trackId:728317195,trackName: "Shoot the Moon", artistName: "Norah Jones", collectionName: "Come Away With Me (Deluxe Edition)", releaseDate: "2002-02-26T08:00:00Z"),
        //Track(trackId:1073650453,trackName: "Kozmic Blues", artistName: "Janis Joplin", collectionName: "I Got Dem Ol' Kozmic  Blues Again Mama!", releaseDate: "1969-09-11T07:00:00Z"),
        //Track(trackId:1445844382,trackName: "You Found Another Lover (I Lost Another Friend)", artistName: "Ben Harper & Charlie Musselwhite", collectionName: "Get Up! (Deluxe Version)", releaseDate: "2013-01-29T12:00:00Z")
        //]
        //ingredients.append(contentsOf : newIngredients)
    }
    
    func deleteIngredient(indexSet: IndexSet){
        ingredients.remove(atOffsets: indexSet)
    }
    
    func moveIngredient(from: IndexSet, to: Int){
        ingredients.move(fromOffsets: from, toOffset : to)
    }
    
    func addIngredient(ingredient : Ingredient){
        /*let newIngredient = Ingredient(ingredientId: "bbb",ingredientName: "\(ingredient.ingredientName) v2", ingredientUnit: ingredient.ingredientUnit, ingredientStocks: ingredient.ingredientStocks, ingredientUnitprice: ingredient.ingredientUnitprice, ingredientCategory: ingredient.ingredientCategory, ingredientAllergene: ingredient.ingredientAllergene)*/
        print("ddd\(ingredient.ingredientName)")
        ingredients.append(ingredient)
        //print(tracks)
    }
    
    typealias Input = IngredientsListState
    typealias Failure = Never
    //appelée à l'inscription
    func receive(subscription: Subscription) {
        subscription.request(.unlimited) //unlimited : on veut recevoir toutes les valeurs
    }
    
    //au cas où le publisher déclare qu'il finit d'émettre : nous concerne pas
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    //activée à chaque send() du publisher
    func receive(_ input: Input) -> Subscribers.Demand {
        switch input{
        case .ready : break
        case .listUpdated :
            print("list updated !")
            self.objectWillChange.send()
        }
        return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    func fetchData() {
           /*db.collection("ingredients").addSnapshotListener { (querySnapshot, error ) in
               guard let documents = querySnapshot?.documents else {
                   print("No documents")
                   return
               }
               
               self.ingredients = documents.map{ (QueryDocumentSnapshot) -> Ingredient in
                   let data = QueryDocumentSnapshot.data()
                   let allergene = data["allergene"] as? String ?? ""
                   let category = data["category"] as? String ?? ""
                   let name = data["name"] as? String ?? ""
                   let stocks = data["stocks"] as? String ?? ""
                   let unit = data["unit"] as? String ?? ""
                   let unitprice = data["unitprice"] as? String ?? ""
                   return Ingredient(ingredientId: "1", ingredientName: name, ingredientUnit: unit, ingredientStocks: stocks, ingredientUnitprice: unitprice, ingredientCategory: category, ingredientAllergene: allergene)
                   
               }
               
           }*/
        db.collection("ingredients").addSnapshotListener { (querySnapshot, error ) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            
            self.ingredients = documents.compactMap { QueryDocumentSnapshot -> Ingredient? in
                return try? QueryDocumentSnapshot.data(as: Ingredient.self)
                
            }

        }
    
       }

       func updateIngredient(_ ingredient : Ingredient){
           if let ingID = ingredient.ingredientId {
               do {
                   try db.collection("ingredients").document(ingID).setData(from: ingredient)
               }
               catch {
                   print(error)
               }
           }
       }
    

    
}
