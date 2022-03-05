//
//  AddFTView.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct AddFTView : View {
    @ObservedObject var ftvm : FTVM
    @StateObject var newft : FTViewModel = FTViewModel(ft: FicheTechnique(ficheTechniqueId: "", image: "", ficheTechniqueName: "", ficheTechniqueAuthor: "", ficheTechniqueDesc: "", listEtapes: [], ficheTechniqueCategory: ""))
    @State private var showingSheet = false
    @State private var name : String = ""
    @State private var selectedCategory : String = ""
    @State private var author : String = ""
    @State private var description : String = ""
    @State private var steps : String = ""
    @State private var navigate = false
    //var intent : Intent
    
    @Environment(\.dismiss) var dismiss
    
    var body : some View {
        NavigationView {
            Form{
                Section(header : Text("Name")) {
                    TextField("Recipe Name", text: $newft.model.ficheTechniqueName)
                }
                
                Section(header : Text("Category")) {
                    Picker(selection: $newft.model.ficheTechniqueCategory, label: Text("Choisir une catégorie")) {
                        ForEach(Category.allCases){ category in
                            Text(category.rawValue)
                                .tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header : Text("Author")) {
                    TextField("Author", text: $newft.model.ficheTechniqueAuthor)
                }
                
                Section(header : Text("Image")) {
                    TextField("Image Link", text: $newft.model.image)
                        .keyboardType(.URL)
                        .textContentType(.URL)
                }
                
                Section(header : Text("Description")) {
                    TextEditor(text: $newft.model.ficheTechniqueDesc)
                }
                
                Section(header : Text("Steps")) {
                    List{
                        ForEach(newft.model.listEtapes){
                            etape in
                            NavigationLink(destination: EtapeUIView(ft : newft, ftvm : ftvm, etape : etape)){
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
                        .sheet(isPresented: $showingSheet) { AddEtapeView(ft : newft) }
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
                            //saveFT()
                            self.newft.save()
                            //navigate = true
                            dismiss()
                        }){
                            Label("Done", systemImage : "checkmark")
                                .labelStyle(.iconOnly)
                        }
                        .disabled(newft.model.ficheTechniqueName.isEmpty || newft.model.ficheTechniqueDesc.isEmpty || newft.model.ficheTechniqueAuthor.isEmpty || newft.model.ficheTechniqueCategory.isEmpty || newft.model.listEtapes.isEmpty)
                    //}
                }
            })
            .navigationTitle("New Recipe")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        
    }
}

extension AddFTView {
    
    func delete(at offsets : IndexSet){
        newft.listEtapes.remove(atOffsets: offsets)
    }
}


