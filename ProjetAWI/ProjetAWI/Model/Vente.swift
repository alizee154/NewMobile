//
//  Vente.swift
//  ProjetAWI
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

import Foundation
import SwiftUI



class Vente: Identifiable, Decodable, ObservableObject, Encodable {
    
    enum CodingKeys : String, CodingKey {
        case name
        case nbPlat
    }
    
    
    public var name : String
    public var nbPlat: String
    
    init(name: String, nbPlat: String){
        self.name = name
        self.nbPlat = nbPlat
        
    }
}
