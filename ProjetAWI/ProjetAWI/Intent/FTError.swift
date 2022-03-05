//
//  FTError.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import Foundation

enum TrackError : Error, Equatable, CustomStringConvertible{
    case noError
    case tooShortName
    
    var description : String{
        switch self{
        case .tooShortName:
            return "Le mot doit comporter au moins 1 caractère"
        default:
            return "Erreur méconnue"
        }
    }
}
