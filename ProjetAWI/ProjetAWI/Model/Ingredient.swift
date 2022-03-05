//
//  Ingredient.swift
//  ProjetAWI
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

import Foundation
import FirebaseFirestoreSwift

protocol IngredientObserver {
    func changeName(name: String)
    func changeUnit(unit: String)
    func changeStocks(stocks: String)
    func changeUnitprice(unitprice : String)
    func changeCategory(category : String)
    func changeAllergene(allergene : String)

}
enum CategoryIng : String, CaseIterable, Identifiable {
    var id : String { self.rawValue}
    case poisson = "Poisson"
    case viande = "Viande"
    case legumes = "Légume"
    case fruits = "Fruit"
    case sauce = "Sauce"
    case cremerie = "Crèmerie"
    case epices = "Epice"
    case feculent = "Féculent"

}

class Ingredient : Identifiable, Decodable, ObservableObject, Encodable {
    
    /*static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.ingredientId == rhs.ingredientId &&
        lhs.ingredientName == rhs.ingredientName &&
        lhs.ingredientUnit == rhs.ingredientUnit &&
        lhs.ingredientStocks == rhs.ingredientStocks &&
        lhs.ingredientUnitprice == rhs.ingredientUnitprice &&
        lhs.ingredientCategory == rhs.ingredientCategory &&
        lhs.ingredientAllergene == rhs.ingredientAllergene 
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ingredientId)
    }*/
    
    
    enum CodingKeys : String, CodingKey {

        case ingredientId
        case ingredientName = "name"
        case ingredientUnit = "unit"
        case ingredientStocks = "stocks"
        case ingredientUnitprice = "unitprice"
        case ingredientCategory = "category"
        case ingredientAllergene = "allergene"
    }
    
    public var observer : IngredientObserver?

    @DocumentID var ingredientId : String?
    
    public var ingredientName: String {
        didSet{
            let newname = ingredientName.trimmingCharacters(in : .whitespacesAndNewlines)
            if newname.count < 1 {
                self.ingredientName = oldValue
            }
            else{
                self.observer?.changeName(name: self.ingredientName)
            }
        }
    }
    public var ingredientUnit: String {
        didSet{
            let newunit = ingredientUnit.trimmingCharacters(in : .whitespacesAndNewlines)
            if newunit.count < 1 {
                self.ingredientUnit = oldValue
            }
            else{
                self.observer?.changeUnit(unit: self.ingredientUnit)
            }
        }
    }
     
    public var ingredientStocks: String{
        didSet{
            let newstocks = ingredientStocks.trimmingCharacters(in : .whitespacesAndNewlines)
            if newstocks.count < 1 {
                self.ingredientStocks = oldValue
            }
            else{
                self.observer?.changeStocks(stocks: self.ingredientStocks)
            }
        }
    }
    public var ingredientUnitprice: String{
        didSet{
            let newunitprice = ingredientUnitprice.trimmingCharacters(in : .whitespacesAndNewlines)
            if newunitprice.count < 1 {
                self.ingredientUnitprice = oldValue
            }
            else{
                self.observer?.changeUnitprice(unitprice: self.ingredientUnitprice)
            }
        }
    }
    public var ingredientCategory : String{
    didSet{
        let newcategory = ingredientCategory.trimmingCharacters(in : .whitespacesAndNewlines)
        if newcategory.count < 1 {
            self.ingredientCategory = oldValue
        }
        else{
            self.observer?.changeCategory(category: self.ingredientCategory)
        }
    }
    }
    public var ingredientAllergene : String{
        didSet{
            let newallergene = ingredientAllergene.trimmingCharacters(in : .whitespacesAndNewlines)
            if newallergene.count < 1 {
                self.ingredientAllergene = oldValue
            }
            else{
                self.observer?.changeAllergene(allergene: self.ingredientAllergene)
            }
        }
        }
    
    init(ingredientId: String, ingredientName: String, ingredientUnit: String, ingredientStocks: String, ingredientUnitprice: String, ingredientCategory: String, ingredientAllergene : String){
        self.ingredientId = ingredientId
        self.ingredientName = ingredientName
        self.ingredientUnit = ingredientUnit
        self.ingredientStocks = ingredientStocks
        self.ingredientUnitprice = ingredientUnitprice
        self.ingredientCategory = ingredientCategory
        self.ingredientAllergene = ingredientAllergene
        
    }
}
