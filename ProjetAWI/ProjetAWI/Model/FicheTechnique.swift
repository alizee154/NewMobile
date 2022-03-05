//
//  FicheTechnique.swift
//  ProjetAWI
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI
import Foundation
import FirebaseFirestoreSwift

protocol FicheTechniqueObserver {
    func change(name: String)
    func change(author : String)
    func change(description : String)
    func change(category : String)
    func change(etapes : [Etape])
}

enum Category : String, CaseIterable, Identifiable {
    var id : String { self.rawValue}
    case plat = "Plats"
    case amusesbouches = "Amuses bouches"
    case boisson = "Boissons"
    case entree = "Entrées"
    case acc = "Accompagnements"
    case sauce = "Sauces"
    case dessert = "Desserts"
}

class FicheTechnique : Identifiable, ObservableObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case ficheTechniqueId
        case image
        case ficheTechniqueName = "name"
        case ficheTechniqueAuthor = "author"
        case ficheTechniqueDesc = "desc"
        case listEtapes
        case ficheTechniqueCategory = "category"
    }
    
    public var observer : FicheTechniqueObserver?
    
    @DocumentID var ficheTechniqueId : String?
    public var image: String
    public var ficheTechniqueName: String {
        didSet{
            let newname = ficheTechniqueName.trimmingCharacters(in : .whitespacesAndNewlines)
            if newname.count < 1 {
                self.ficheTechniqueName = oldValue
            }
            else{
                self.observer?.change(name: self.ficheTechniqueName)
            }
        }
    }
    public var ficheTechniqueAuthor: String {
        didSet{
            let newauthor = ficheTechniqueAuthor.trimmingCharacters(in : .whitespacesAndNewlines)
            if newauthor.count < 1 {
                self.ficheTechniqueAuthor = oldValue
            }
            else{
                self.observer?.change(author: self.ficheTechniqueAuthor)
            }
        }
    }
    public var ficheTechniqueDesc : String {
        didSet{
            let newdesc = ficheTechniqueDesc.trimmingCharacters(in : .whitespacesAndNewlines)
            if newdesc.count < 1 {
                self.ficheTechniqueDesc = oldValue
            }
            else{
                self.observer?.change(description : self.ficheTechniqueDesc)
            }
        }
    }
    public var listEtapes: [Etape] {
        didSet{
            self.observer?.change(etapes: self.listEtapes)
        }
    }
    public var ficheTechniqueCategory : String {
        didSet{
            let newcat = ficheTechniqueCategory.trimmingCharacters(in : .whitespacesAndNewlines)
            if newcat.count < 1 {
                self.ficheTechniqueCategory = oldValue
            }
            else{
                self.observer?.change(category: self.ficheTechniqueCategory)
            }
        }
    }
    
    init(ficheTechniqueId: String,image : String, ficheTechniqueName: String, ficheTechniqueAuthor: String, ficheTechniqueDesc: String, listEtapes: [Etape], ficheTechniqueCategory : String){
        self.ficheTechniqueId = ficheTechniqueId
        self.image = image
        self.ficheTechniqueName = ficheTechniqueName
        self.ficheTechniqueAuthor = ficheTechniqueAuthor
        self.ficheTechniqueDesc = ficheTechniqueDesc
        self.listEtapes = listEtapes
        self.ficheTechniqueCategory = ficheTechniqueCategory
        
    }
}
