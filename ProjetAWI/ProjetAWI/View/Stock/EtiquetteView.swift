//
//  EtiquetteView.swift
//  ProjetAWI
//
//  Created by m1 on 01/03/2022.
//
import Foundation
import SwiftUI
import PDFKit

struct EtiquetteView: View {
    @ObservedObject var ftvm : FTVM
   

    @StateObject private var contentViewModel = ContentViewModel()
    @State private var showShareSheet : Bool = false
    var body: some View {
        
        NavigationView {
            VStack {
                form()
                
                /*Button(action : {
                   /* var buy = self.ftvm.getRecetteByNameBack(name: "Al");print("hola"); print(ftvm.doc); print("hey")*/

                }, label : {
                    Text("Mettre les ingrédients associés")
                        .bold()
                        .frame(width: 400, height: 40, alignment: .center)
                        .background(Color.red.opacity(0.35))
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                })*/
                shareButton()
                Spacer()
              
                
            }
            .sheet(isPresented: $showShareSheet, content: {
                if let data = contentViewModel.pdfData() {
                    ShareView(activityItems: [data])
                }
            })
            .navigationTitle(Text(" Imprimer une étiquette"))
        } .environmentObject(contentViewModel)
        
        
        
        
        //.navigationBarTitleDisplayMode(.inline)
        
    }
}
extension EtiquetteView {
    
    private func form() -> some View {
        Form {
            /*Section(header : Text("recette ")) {
                Picker(selection: $contentViewModel.recette, label: Text("Choisir un plat")) {
                    ForEach(ftvm.fts){ recette in
                        Text(recette.ficheTechniqueName)
                            .tag(recette)
                    }
                }
                .pickerStyle(.menu)
            }*/
            Section(header : Text("Plat ")) {
                Picker(selection: $contentViewModel.plat, label: Text("Choisir un plat")) {
                    ForEach(ftvm.fts){ recette in
                        Text(recette.ficheTechniqueName)
                            .tag(recette.ficheTechniqueName)
                    }
                }
                .pickerStyle(.menu)
            }
            /*Section(header : Text("Plat ")) {
                Picker(selection: $contentViewModel.index, label: Text("Choisir un plat")) {
                    ForEach(ftvm.fts){ recette in
                        Text(recette.ficheTechniqueName)
                            .tag(1)
                    }
                }
                .pickerStyle(.menu)
            }*/
            //TextField("Plat", text: $contentViewModel.plat )
            
            
            
            /*TextEditor(text: $contentViewModel.ingredients)
                .frame(height: 100)*/
        }
        .frame(height: 270)
        .padding(4)
    }
    
    
    private func shareButton() -> some View {
        
        Button(action: {
            self.contentViewModel.test(list : ftvm);
            self.showShareSheet.toggle()
        }, label: {
            Text("Partager l'étiquette")
                .padding(10)
                .frame(width: 100)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(20)
        })
    }
}
