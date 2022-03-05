//
//  AddEtapeView.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct AddEtapeView : View {
    @ObservedObject var ft : FTViewModel
    @State private var showingSheet = false
    @State private var newstep : Etape = Etape(titreEtape: "", descEtape: "", listIng: [], duree: "", listQuantity: [])
    @State private var titre : String = ""
    @State private var desc : String = ""
    @State private var duree : String = ""
    @State private var listIng : [Ingredient] = []
    @State private var i : Int = 0
    var intent : Intent
    
    @Environment(\.dismiss) var dismiss
    
    init(ft : FTViewModel){
        self.ft = ft
        self.intent = Intent()
        //le VM est enregistré comme souscrivant aux actions demandées (publications des modifs du state de l'Intent)
        self.intent.addObserver(viewModel: self.ft)
    }
    
    var body : some View {
        NavigationView {
            Form{
                Section(header : Text("Titre")) {
                    TextField("Titre de l'étape", text: $newstep.titreEtape)
                }
                
                Section(header : Text("Description")) {
                    TextEditor(text: $newstep.descEtape)
                }
                
                Section(header : Text("Durée")) {
                    TextField("Durée", text: $newstep.duree)
                }
                
                Section(header : Text("Ingrédients")) {
                    List{
                        ForEach(newstep.listIng.indices, id : \.self){
                            ing in
                                VStack(alignment: .leading){
                                    Text(newstep.listIng[ing].ingredientName)
                                        .foregroundColor(Color.black)
                                    Spacer()
                                    Text("\(newstep.listQuantity[ing])  \(newstep.listIng[ing].ingredientUnit)")
                            }
                        }
                        //.onDelete(perform : delete)
                    }
                    HStack{
                        Spacer()
                        Button(action : {
                           // incr()
                            print(i)
                            showingSheet.toggle()
                        }){
                            Image(systemName: "plus")
                                .font(.system(size: 25, weight: .regular, design : .default))
                                .foregroundColor(Color.black)
                        }
                        .sheet(isPresented: $showingSheet) { AddIngToStepView(step : newstep) }
                        Spacer()
                    }
                    
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action : {
                        dismiss()
                    }){
                        Label("Cancel", systemImage : "xmark")
                            .labelStyle(.iconOnly)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    //                    NavigationLink(isActive: $navigate) {
                    //                        ListFTView(ftvm: ftvm)
                    //                    } label: {
                    Button(action : {
                        //intent.intentToCreate(ft: vmft)
                        intent.intentToChange()
                        saveEtape()
                        //navigate = true
                        dismiss()
                    }){
                        Label("Done", systemImage : "checkmark")
                            .labelStyle(.iconOnly)
                    }
                    .disabled(newstep.titreEtape.isEmpty || newstep.descEtape.isEmpty || newstep.duree.isEmpty)
                    //}
                }
            })
            .navigationTitle("New Step")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        .navigationViewStyle(.stack)
        
    }
}

extension AddEtapeView {
    private func saveEtape() {
        ft.addFT(etape : newstep)
    }
    
    func incr(){
        self.i = self.i + 1
        
    }
}


