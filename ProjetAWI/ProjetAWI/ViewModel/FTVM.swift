//
//  FTVM.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import simd

class FTVM : ObservableObject, Subscriber, Identifiable{
    @Published var fts : [FicheTechnique] = []
    @Published var doc : String = ""
    private var db = Firestore.firestore()
    //var intent : Intent
    //@ObservedObject var vmingredient : IngredientViewModel = IngredientViewModel(ingredient: Ingredient(ingredientId: "", ingredientName: "", ingredientUnit: "", ingredientStocks: "", ingredientUnitprice: "", ingredientCategory: "", ingredientAllergene: ""))
    //@ObservedObject var ingredientsVM : IngredientsVM = IngredientsVM()

    init(){
        //fetch data of a real database
       // self.intent = Intent()
        //self.intent.addObserver(viewModel: self.vmingredient)
        //self.intent.addObserver(listViewModel: self.ingredientsVM)
        //le VM est enregistré comme souscrivant aux actions demandées (publications des modifs du state de l'Intent)
        self.fetchData()

    }
    
    init(fts : [FicheTechnique]){
        self.fts = []
    }
    
    
    func addFT(ft : FicheTechnique) {
        fts.append(ft)
    }
    
    func applyFilter(category : Category){
        let filtered = fts.filter {
            $0.ficheTechniqueCategory == category.rawValue
        }
        //print(self.fts)
        self.fts = filtered
        print(filtered)
        print("---------")
    }
    func filter(category : Category) -> FTVM {
        self.applyFilter(category: category)
        return self
    }
    func getRecetteByName(name : String)-> FicheTechnique{
        let recettas : FicheTechnique = FicheTechnique(ficheTechniqueId: "", image: "", ficheTechniqueName: "", ficheTechniqueAuthor: "", ficheTechniqueDesc: "", listEtapes: [], ficheTechniqueCategory: "")
        for recette in fts {
            if recette.ficheTechniqueName == name{
            print(recette.ficheTechniqueName)
                return recette
            }
            
            
        }
        return recettas
        
    }
    func downIng(ft : String){
        let fiche : FicheTechnique = getRecetteByName(name: ft)
        //on recup les  ing
        var tabIng : [IngredientViewModel] = []
        var tabQuantity : [Int] = []
        for etape in fiche.listEtapes{
            for quantity in etape.listQuantity{
                tabQuantity.append(Int(quantity)!)
            }
        }
        
        for etape in fiche.listEtapes{
            for ing in etape.listIng{
                tabIng.append(IngredientViewModel(ingredient : ing))
                
            }
        }
        var i : Int = 0

        for ing in tabIng{
            //ing.downQuantity(quantity : tabQuantity[i])
            i = i + 1

            updateStocks(ingredient: ing, stocks: "3")
           // self.intent.addObserver(viewModel: ing)
            //intent.intentToChangeStocks(stocks: ing.ingredientStocks);
        }
        
        
    }
   
    func recupIng(ft: String)-> [IngredientViewModel]{
        let fiche : FicheTechnique = getRecetteByName(name: ft)
        print(fiche)
        //on recup les  ing
        var tabIng : [IngredientViewModel] = []
       
        
        for etape in fiche.listEtapes{
            for ing in etape.listIng{
                print(ing.ingredientName)
                print(ing.ingredientId)
                print("hhhh")
                tabIng.append(IngredientViewModel(ingredient : ing))
                //tabIng.append(ing)
            }
        }
        return tabIng
        
    }
    func recupQuantity(ft:String)->[Int]{
        let fiche : FicheTechnique = getRecetteByName(name: ft)

        var tabQuantity : [Int] = []
        
        for etape in fiche.listEtapes{
            for quantity in etape.listQuantity{
                tabQuantity.append(Int(quantity)!)
            }
        }
        return tabQuantity

        
    }
    
    func updateStocks(ingredient: IngredientViewModel, stocks : String){
        ingredient.changeStocks(stocks: stocks)
        ingredient.testt(name : "3")
        //self.vmingredient = ingredient
        //intent.intentToChangeStocks(stocks: "5")
        print(ingredient.ingredientName)
        print(ingredient.model.ingredientName)
        print(ingredient.ingredientStocks)
        //ingredient.model.ingredientStocks = "5"
        print(ingredient.model.ingredientStocks)
        print(ingredient.ingredientId)
        //ingredient.up(ingredient : ingredient.model)
        //var ingID = ingredient.model.ingredientId
        //print(ingID)
        
        }
    func getRecetteByNameBack(name : String)-> String{
       /* let docRef = db.collection("ficheTechnique").document("Al")
        docRef.getDocument{
            (document,error) in if let document = document, document.exists{
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            }else{
                print("doc not exists")
            }
        }*/
        /*var citiesRef = db.collection("ficheTechnique")
        
        citiesRef.whereIn("name", "Al")*/
        db.collection("ficheTechnique").whereField("name", isEqualTo: "Al").getDocuments() { (querySnapshot, err) in if let err = err{
            print("err getting doc : \(err)")
        }
            else{
                for document in querySnapshot!.documents{
                   //print("\(document.documentID)=>\(document.data())")
                    print(document.documentID)
                    self.doc = document.documentID
                    print(self.doc)
                }
            }
        
        
        /*let docRef = db.collection("ficheTechnique").document("Al")
        docRef.getDocument(source: .cache){(document, error)in
            if let document = document{
                let property = document.get(name)
                print(property)
            }
            else{print("Doc not exit")
                
            }
        }*/
        
    }
        print("jj")
        //print("\(doc) hhh")
        print("\(self.doc) hhh")
        return self.doc
    }

    func deleteTrack(indexSet: IndexSet){
        fts.remove(atOffsets: indexSet)
    }
    
    func moveTrack(from: IndexSet, to: Int){
        fts.move(fromOffsets: from, toOffset : to)
    }
    
//    func addTrack(track : Track){
//        let newFT = Track(trackId: track.trackId+1,trackName: "\(track.trackName) v2", artistName: track.artistName, collectionName: track.collectionName, releaseDate: track.releaseDate)
//        tracks.append(newTrack)
//        //print(tracks)
//    }
    
    typealias Input = FTSListState
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
            db.collection("ficheTechnique").addSnapshotListener { (querySnapshot, error ) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }

//                self.fts = documents.map{ (QueryDocumentSnapshot) -> FicheTechnique in
//                    let data = QueryDocumentSnapshot.data()
//                    let author = data["author"] as? String ?? ""
//                    let category = data["category"] as? String ?? ""
//                    let name = data["name"] as? String ?? ""
//                    let desc = data["desc"]
//                        as? String ?? ""
//                    return FicheTechnique(ficheTechniqueId: .init(), image: "", ficheTechniqueName: name, ficheTechniqueAuthor: author, ficheTechniqueDesc: desc, listEtapes: [], ficheTechniqueCategory: category)
//
//                }
                
                self.fts = documents.compactMap { QueryDocumentSnapshot -> FicheTechnique? in
                    return try? QueryDocumentSnapshot.data(as: FicheTechnique.self)
                    
                }

            }
        }
    
}
