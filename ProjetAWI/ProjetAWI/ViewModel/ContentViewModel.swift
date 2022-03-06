//
//  ContentViewModel.swift
//  ProjetAWI
//
//  Created by m1 on 01/03/2022.
//
import Foundation
import SwiftUI

class ContentViewModel : ObservableObject {
    @Published private var etiquette = Etiquette()
   /* var index : Int {
        get { etiquette.index }
        set (newRecette){
            etiquette.index = newRecette
        }
    }*/
    
    var plat : String {
        get { etiquette.plat }
        set (newPlat){
            etiquette.plat = newPlat
        }
    }
    
    var ingredients : String {
        get { etiquette.ingredients }
        set (newIng){
            etiquette.ingredients = newIng
        }
    }
}
extension ContentViewModel {
    func pdfData() -> Data? {
        return PdfCreator().pdfData(plat : self.plat,
                                    ingredients: self.ingredients)
    }
    
    func clear(){
        self.plat = ""
        self.ingredients = ""
    }
    
    func test(list: FTVM)
    {
        var newing : String = ""
        let recette : FicheTechnique = list.getRecetteByName(name: etiquette.plat)
        print(recette.ficheTechniqueName)
        for etape in recette.listEtapes{
            for ing in etape.listIng{
                newing.append(contentsOf: ing.ingredientName)
                newing.append(" ")
            }
        }
        self.ingredients = newing
        //print(list.fts[0].listEtapes[0].listIng[0].ingredientName)
        //self.ingredients = list.fts[0].listEtapes[0].listIng[0].ingredientName
    }
}
