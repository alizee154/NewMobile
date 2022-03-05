//
//  IngredientViewModel.swift
//  ProjetAWI
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class IngredientViewModel : ObservableObject, IngredientObserver, Subscriber {
    
    private var db = Firestore.firestore()
    
    func changeName(name: String){
        print("vm observer : ame changed => self.name = '\(name)'")
        self.ingredientName = name
    }
    
    func changeUnit(unit: String){
        print("vm observer : unit changed => self.unit = '\(unit)'")
        self.ingredientUnit = unit
    }
    
    func changeUnitprice(unitprice: String){
        print("vm observer : unitprice changed => self.unitprice = '\(unitprice)'")
        self.ingredientUnitprice = unitprice
    }
    
    func changeStocks(stocks: String){
        print("vm observer : stocks changed => self.stocks = '\(stocks)'")
        self.ingredientStocks = stocks
       // self.model.ingredientStocks = stocks
    }
    
    func changeCategory(category: String){
        print("vm observer : category changed => self.category = '\(category)'")
        self.ingredientCategory = category
    }
    func changeAllergene(allergene: String){
        print("vm observer : allergene changed => self.allergene = '\(allergene)'")
        self.ingredientAllergene = allergene
    }
    @Published var model : Ingredient
    
    @Published var ingredientId : String
    @Published var ingredientName: String
    @Published var ingredientUnit: String
    @Published var ingredientStocks: String
    @Published var ingredientUnitprice: String
    @Published var ingredientCategory : String
    @Published var ingredientAllergene : String
    @Published var error : IngredientError = .noError
    
    init(ingredient : Ingredient){
        self.model = ingredient
        self.ingredientId = ingredient.ingredientId!
        self.ingredientName = ingredient.ingredientName
        self.ingredientUnit = ingredient.ingredientUnit
        self.ingredientStocks = ingredient.ingredientStocks
        self.ingredientUnitprice = ingredient.ingredientUnitprice
        self.ingredientCategory = ingredient.ingredientCategory
        self.ingredientAllergene = ingredient.ingredientAllergene
        ingredient.observer = self
    }
    // MARK: -
    // MARK: IngredientObserver
    
    func testt(name : String){
        changeStocks(stocks: name)
        self.model.ingredientStocks = name
        if ingredientStocks != self.model.ingredientStocks {
            print("vm : error detected => set vm error")
            self.error = .tooShortName
            self.ingredientStocks = self.model.ingredientStocks
            print("vm : error detected => self.ingredientStocks = '\(self.model.ingredientStocks)'")
    }
        update()

    }
    
    typealias Input = IngredientState
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
        print("vm => intent \(input)")
        switch input{
        case .ready : break
        case .changingName(let name) :
            print("vm : change model name to \(self.model.ingredientName)")
            self.model.ingredientName = name
            if ingredientName != self.model.ingredientName {
                print("vm : error detected => set vm error")
                self.error = .tooShortName
                self.ingredientName = self.model.ingredientName
                print("vm : error detected => self.ingredientName = '\(self.model.ingredientName)'")
            }
        case .changingUnit(let unit) :
            print("vm : change model unit to \(self.model.ingredientUnit)")
            self.model.ingredientUnit = unit
            if ingredientUnit != self.model.ingredientUnit {
                print("vm : error detected => set vm error")
                self.error = .tooShortName
                self.ingredientUnit = self.model.ingredientUnit
                print("vm : error detected => self.ingredientUnit = '\(self.model.ingredientUnit)'")
            }
        case .changingStocks(let stocks) :
            print("vm : change model stocks to \(self.model.ingredientStocks)")
            self.model.ingredientStocks = stocks
            if ingredientStocks != self.model.ingredientStocks {
                print("vm : error detected => set vm error")
                self.error = .tooShortName
                self.ingredientStocks = self.model.ingredientStocks
                print("vm : error detected => self.ingredientStocks = '\(self.model.ingredientStocks)'")
            }
        case .changingUnitprice(let unitprice) :
            print("vm : change model unitprice to \(self.model.ingredientUnitprice)")
            self.model.ingredientUnitprice = unitprice
            if ingredientUnitprice != self.model.ingredientUnitprice {
                print("vm : error detected => set vm error")
                self.error = .tooShortName
                self.ingredientUnitprice = self.model.ingredientUnitprice
                print("vm : error detected => self.ingredientUnitprice = '\(self.model.ingredientUnitprice)'")
            }
        case .changingCategory(let category) :
            print("vm : change model allergene to \(self.model.ingredientCategory)")
            self.model.ingredientCategory = category
            if ingredientCategory != self.model.ingredientCategory {
                print("vm : error detected => set vm error")
                self.error = .tooShortName
                self.ingredientCategory = self.model.ingredientCategory
                print("vm : error detected => self.ingredientCategory = '\(self.model.ingredientCategory)'")
            }
        case .changingAllergene(let allergene) :
            print("vm : change model allergene to \(self.model.ingredientAllergene)")
            self.model.ingredientAllergene = allergene
            if ingredientAllergene != self.model.ingredientAllergene {
                print("vm : error detected => set vm error")
                self.error = .tooShortName
                self.ingredientAllergene = self.model.ingredientAllergene
                print("vm : error detected => self.ingredientAllergene = '\(self.model.ingredientAllergene)'")
            }
        case .nameChanged(_) : break
        case .unitChanged(_) : break
        case .stocksChanged(_) : break
        case .unitpriceChanged(_) : break
        case .categoryChanged(_) : break
        case .allergeneChanged(_) : break



        }
        return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    func addIng(_ ingredient: Ingredient) {
        do {
          let _ = try db.collection("ingredients").addDocument(from: ingredient)
            print(self.model.ingredientName)
            print(ingredient.ingredientName)

        }
        catch {
          print(error)
        }
      }
    /*func deleteIng(_ ingredient: Ingredient){
        do{
            if (ingredient.ingredientId != nil){
                
                var id : String? = ingredient.ingredientId
        
            let _ = try db.collection("ingredients").document(id!).delete()
            print("supprimé")
            }
        }
        catch{
            print(error)
        }
           
    }*/
    
    
    private func deleteIng(ingredient : Ingredient) {
        if let documentID = ingredient.ingredientId {
            print("hey")
            print(documentID)

            db.collection("ingredients").document(documentID).delete {
                error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
         print("hey")


    }
    
    func delete(){
        deleteIng(ingredient : self.model)
        print("hey")

    }

    
    
    func updateIngredient(ingredient : Ingredient, stocks : String){
           /* if let ingID = model.ingredientId {
                do {
                    try db.collection("ingredients").document(ingID).setData(from: ingredient)
                    print("helooooo")
                }
                catch {
                    print(error)
                }
            }*/
         print("oh")
        //changeStocks(stocks: stocks)
        testt(name : stocks)
        db.collection("ingredients").whereField("name", isEqualTo: ingredient.ingredientName).getDocuments() { (querySnapshot, err) in if let err = err{
            print("err getting doc : \(err)")
        }
            else{
                for document in querySnapshot!.documents{
                   //print("\(document.documentID)=>\(document.data())")
                    print("\(document.documentID)bandedenouille")
                    
                    do {
                        try self.db.collection("ingredients").document(document.documentID).setData(from: ingredient)
                        print("helooooo")
                    }
                    catch {
                        print(error)
                    }
                }
                    
                
            }
        
        
        }
    }
    func save(){
        addIng(self.model)
        print(self.model.ingredientName)
    }
//
//    func getIngredient(name : String) -> [String]{
////        var result : [String] = []
////        //var name : String
////
////        db.collection("ingredients").whereField("name", isEqualTo: name)
////            .getDocuments() { (querySnapshot, err) in
////                if let err = err {
////                    print("Error getting documents: \(err)")
////                } else {
////                    let documents =  querySnapshot!.documents
////                      return  result = documents.map { queryDocumentSnapshot -> String in
////                            let data = queryDocumentSnapshot.data()
////                            print(data)
////                            let name2 = data["name"] as? String ?? ""
////                            print(name2)
////                            return name2
////                    }
////                }
////        }
////       // return result
//        db.collection("ficheTechnique").whereField("name", isEqualTo: name).getDocuments() { (querySnapshot, error ) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//
//
//            self.model = documents.compactMap { QueryDocumentSnapshot -> Ingredient? in
//                return try? QueryDocumentSnapshot.data(as: Ingredient.self)
//
//            }
//    }
    func update(){
        //updateIngredient(self.model)
    }
    func up(ingredient : Ingredient){
        
        if let ingID = model.ingredientId {
            print(ingID)
                do {
                    try db.collection("ingredients").document(ingID).setData(from: ingredient)
                    print("helooooo")
                }
                catch {
                    print(error)
                }
            }
    }
   
}

