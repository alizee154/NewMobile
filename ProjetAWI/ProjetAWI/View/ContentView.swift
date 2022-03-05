//
//  ContentView.swift
//  ProjetAWI
//
//  Created by m1 on 17/02/2022.
//

import SwiftUI

struct ContentView: View {
    var ftvm : FTVM = FTVM()
    var ingredientsVM : IngredientsVM = IngredientsVM()

    var body: some View {
       TabBar(ftvm: ftvm, ingredientsVM: ingredientsVM)
            .environmentObject(ingredientsVM)
        
    }

}
    


