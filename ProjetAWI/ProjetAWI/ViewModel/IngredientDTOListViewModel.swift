//
//  IngredientDTOListViewModel.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import Foundation
import FirebaseFirestore

/*class IngredientDTOListViewModel : ObservableObject{
   @Published var list = [IngredientDTO]()
    
    private let firestore = Firestore.firestore()
    
    let data = try? await Firestore.collection("ingredients").getDocuments()
    
    let ingredients : [IngredientDTO] = data.documents.map
    { (doc) -> IngredientDTO in
      return IngredientDTO(id: doc.documentID, ingredientName:
      doc["name"] as? String ?? "",ingredientUnit:
                            doc["unit"] as? String ?? "", ingredientStocks:
                            doc["stocks"] as? String ?? "",ingredientUnitprice:
                            doc["unitprice"] as? String ?? "",ingredientCategory:
                            doc["category"] as? String ?? "",ingredientAllergene:
                            doc["allergene"] as? String ?? "")
    }
    
    func fetchData() {
            firestore.collection("ingredients").addSnapshotListener { (data, error ) in
                guard let documents = data?.documents else {
                    print("No documents")
                    return
                }
                
                self.list = self.ingredients
            }
        }
}*/
