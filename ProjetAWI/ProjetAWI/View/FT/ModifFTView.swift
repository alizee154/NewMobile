//
//  ModifFTView.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct ModifFTView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var ft : FTViewModel
    @ObservedObject var ftvm : FTVM
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    @State private var showingSheet = false
    var intent : Intent
    
    init(ft : FTViewModel, ftvm : FTVM){
        self.ft = ft
        self.ftvm = ftvm
        //self.ft = ft
        self.intent = Intent()
        //le VM est enregistré comme souscrivant aux actions demandées (publications des modifs du state de l'Intent)
        self.intent.addObserver(viewModel: self.ft)
        self.intent.addObserver(listViewModel: self.ftvm)
    }
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header : Text("Name")) {
                        TextField("Recipe Name", text: $ft.model.ficheTechniqueName)
                    }
                    
                    Section(header : Text("Category")) {
                        Picker("Catégorie", selection: $ft.model.ficheTechniqueCategory) {
                            ForEach(Category.allCases){ category in
                                Text(category.rawValue)
                                    .tag(category)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Section(header : Text("Author")) {
                        TextField("Author", text: $ft.model.ficheTechniqueAuthor)
                    }
                    
                    Section(header : Text("Image")) {
                        TextField("Image Link", text: $ft.model.image)
                            .keyboardType(.URL)
                            .textContentType(.URL)
                    }
                    
                    Section(header : Text("Description")) {
                        TextEditor(text: $ft.model.ficheTechniqueDesc)
                    }
                    Section(header : Text("Steps")) {
                        List{
                            ForEach(ft.model.listEtapes){
                                etape in
                                NavigationLink(destination: EtapeUIView(ft : ft, ftvm : ftvm, etape : etape)){
                                    VStack(alignment: .leading){
                                        Text(etape.titreEtape)
                                        Spacer()
                                        Text("\(etape.duree)")
                                            .bold()
                                    }
                                }
                            }
                            .onDelete(perform : delete)
                        }
                        HStack{
                            Spacer()
                            Button(action : {
                                showingSheet.toggle()
                            }){
                                Image(systemName: "plus")
                                    .font(.system(size: 25, weight: .regular, design : .default))
                                    .foregroundColor(Color.black)
                            }
                            .sheet(isPresented: $showingSheet) { AddEtapeView(ft : ft) }
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
                            self.ft.update()
                            intent.intentToChange(ft: ft)
                            dismiss()
                        }){
                            Label("Done", systemImage : "checkmark")
                                .labelStyle(.iconOnly)
                        }
                        .disabled(ft.ficheTechniqueName.isEmpty || ft.ficheTechniqueDesc.isEmpty || ft.ficheTechniqueAuthor.isEmpty)
                        //}
                    }
                })
                .navigationTitle("New Recipe")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        
    }
    
    func delete(at offsets : IndexSet){
        ft.listEtapes.remove(atOffsets: offsets)
        ft.update()
    }
    
}


