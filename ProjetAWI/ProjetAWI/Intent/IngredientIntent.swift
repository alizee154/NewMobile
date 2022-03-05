//
//  IngredientIntent.swift
//  ProjetAWI
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import SwiftUI
import Combine

enum IngredientState :  Equatable, CustomStringConvertible {
    case ready
    case changingName(String)
    case nameChanged(String)
    case changingUnit(String)
    case unitChanged(String)
    case changingStocks(String)
    case stocksChanged(String)
    case changingUnitprice(String)
    case unitpriceChanged(String)
    case changingCategory(String)
    case categoryChanged(String)
    case changingAllergene(String)
    case allergeneChanged(String)


    
    var description : String{
        switch self{
        case .ready: return "State: ready"
        case .changingName(let name): return "State changingName(\(name))"
        case .nameChanged(let name): return "State nameChanged(\(name))"
        case .changingUnit(let unit): return "State changingUnit(\(unit))"
        case .unitChanged(let unit): return "State unitChanged(\(unit))"
        case .changingStocks(let stocks): return "State changingUnit(\(stocks))"
        case .changingUnitprice(let unitprice): return "State changingUnit(\(unitprice))"

        case .stocksChanged(let stocks): return "State unitChanged(\(stocks))"
        case .unitpriceChanged(let unitprice): return "State unitChanged(\(unitprice))"
        case .categoryChanged(let category): return "State categoryChanged(\(category))"
        case .changingCategory(let category): return "State changingCategory(\(category))"
        case .allergeneChanged(let allergene): return "State allergeneChanged(\(allergene))"
        case .changingAllergene(let allergene): return "State changingAllergene(\(allergene))"

        }
    }
}

enum IngredientsListState :  Equatable, CustomStringConvertible {
    case ready
    case listUpdated
    
    var description : String{
        switch self{
        case .ready: return "State: ready"
        case .listUpdated: return "State listUpdated"
            
            
        }
    }
}

enum FTState : CustomStringConvertible {
    case ready
    case creatingFT(FTViewModel)
    case changingFT(FTViewModel)
    case changingSteps
    case nameChanged(String)
    
    var description : String{
        switch self{
        case .ready: return "State: ready"
        case .creatingFT(let ft) : return "State: creatingFT(\(ft)"
        case .changingFT(let ft): return "State changingFT(\(ft))"
        case .changingSteps : return "State changingSteps"
        case .nameChanged(let name): return "State nameChanged(\(name))"
        
        }
    }
}

enum FTSListState :  Equatable, CustomStringConvertible {
    case ready
    case listUpdated
    
    var description : String{
        switch self{
        case .ready: return "State: ready"
        case .listUpdated: return "State listUpdated"
            
            
        }
    }
}

enum StepListState :  Equatable, CustomStringConvertible {
    case ready
    case listUpdated
    
    var description : String{
        switch self{
        case .ready: return "State: ready"
        case .listUpdated: return "State listUpdated"
            
            
        }
    }
}
struct Intent{
    private var state = PassthroughSubject<IngredientState, Never>()
    private var stateList = PassthroughSubject<IngredientsListState, Never>()
    private var ftstate = PassthroughSubject<FTState, Never>()
    private var stateListFT = PassthroughSubject<FTSListState, Never>()
    private var stateListStep = PassthroughSubject<StepListState, Never>()    //private var listIntent = TracksListIntent()
    
    func addObserver(viewModel : IngredientViewModel){
        self.state.subscribe(viewModel)
        //self.stateList.subscribe(listViewModel)
    }
    
    func addObserver(listViewModel : IngredientsVM){
        self.stateList.subscribe(listViewModel)
    }
    
    func addObserver(viewModel : FTViewModel){
        self.ftstate.subscribe(viewModel)
        //self.stateListStep.subscribe(viewModel)
        //self.stateList.subscribe(listViewModel)
    }
    
    func addObserver(listViewModel : FTVM){
        self.stateListFT.subscribe(listViewModel)
    }
    
    
    
//    func intentToCreate(ft : FTViewModel){
//        self.state.send(.creatingFT(ft))
//        self.stateList.send(.listUpdated)
//    }
    
    func intentToChangeName(name : String){
        self.state.send(.changingName(name))
        //self.state.send(.listUpdated)
        self.stateList.send(.listUpdated)
        //self.listIntent.intentToChange(name: name)
        
    }
    
    func intentToChangeUnit(unit : String){
        self.state.send(.changingUnit(unit))
        //self.state.send(.listUpdated)
        self.stateList.send(.listUpdated)
        //self.listIntent.intentToChange(name: name)
        
    }
    
    func intentToChangeStocks(stocks : String){
        self.state.send(.changingStocks(stocks))
        //self.state.send(.listUpdated)
        self.stateList.send(.listUpdated)
        //self.listIntent.intentToChange(name: name)
        
    }
    func intentToChangeUnitprice(unitprice : String){
        self.state.send(.changingUnitprice(unitprice))
        //self.state.send(.listUpdated)
        self.stateList.send(.listUpdated)
        //self.listIntent.intentToChange(name: name)
        
    }
    func intentToChangeCategory(category : String){
        self.state.send(.changingCategory(category))
        //self.state.send(.listUpdated)
        self.stateList.send(.listUpdated)
        //self.listIntent.intentToChange(name: name)
        
    }
    func intentToChangeAllergene(allergene : String){
        self.state.send(.changingAllergene(allergene))
        //self.state.send(.listUpdated)
        self.stateList.send(.listUpdated)
        //self.listIntent.intentToChange(name: name)
        
    }
    
    func intentToChange(){
        self.ftstate.send(.changingSteps)
    }
    func intentToChange(ft : FTViewModel){
        self.ftstate.send(.changingFT(ft))
        //self.state.send(.listUpdated)
        self.stateListFT.send(.listUpdated)
        //self.listIntent.intentToChange(name: name)
        
    }}
