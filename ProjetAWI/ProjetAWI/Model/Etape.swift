//
//  Etape.swift
//  ProjetAWI
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI
import Foundation

protocol EtapeObserver {
    func change(name : String)
}

class Etape : Identifiable, ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case titreEtape
        case descEtape
        case listIng
        case duree
        case listQuantity
    }
    
    public var observer : EtapeObserver?
    
    public var titreEtape : String
    public var descEtape : String
    public var listIng : [Ingredient]
    public var duree : String
    public var listQuantity : [String]
    
    init(titreEtape : String, descEtape : String, listIng : [Ingredient], duree : String, listQuantity : [String]){
        self.titreEtape = titreEtape
        self.descEtape = descEtape
        self.listIng = listIng
        self.duree = duree
        self.listQuantity = listQuantity
    }
    
}
