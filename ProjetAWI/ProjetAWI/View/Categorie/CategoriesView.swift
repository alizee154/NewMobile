//
//  CategoriesView.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import Foundation
import SwiftUI

struct CategoriesView : View {
    @ObservedObject var ftvm : FTVM
    var body : some View {
            List{
                ForEach(Category.allCases){ category in
                    NavigationLink{
                            ListFTView(ftvm : filter(category: category, ftvm: ftvm))
                    } label : {
                        Text(category.rawValue)
                    }
                }
            }
            .navigationTitle("Catégories")
            .navigationViewStyle(.stack)
       
    }
    func filter(category : Category, ftvm : FTVM) -> FTVM {
        let result : FTVM = FTVM(fts : [])
        for i in stride(from: 0, to: ftvm.fts.count, by: 1){
            if(ftvm.fts[i].ficheTechniqueCategory == category.rawValue){
                print(ftvm.fts[i].ficheTechniqueName)
                result.fts.append(ftvm.fts[i])
            }
        }
        print(result.fts)
        return result
    }
}
