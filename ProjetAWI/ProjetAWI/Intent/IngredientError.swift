//
//  IngredientError.swift
//  ProjetAWI
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import SwiftUI

enum IngredientError : Error, Equatable, CustomStringConvertible{
    case noError
    case tooShortName
    
    var description : String{
        switch self{
        case .tooShortName:
            return "Le nom doit comporter au moins 1 caractère"
        default:
            return "Erreur méconnue"
        }
    }
}
