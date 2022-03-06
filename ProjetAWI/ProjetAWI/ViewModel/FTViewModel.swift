//
//  FTViewModel.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//

import Foundation
import Combine
import FirebaseFirestore

class FTViewModel : ObservableObject, FicheTechniqueObserver, Subscriber {
    
    @Published var model : FicheTechnique
    
    private var db = Firestore.firestore()
    
    @Published var ficheTechniqueId : String
    @Published var image: String
    @Published var ficheTechniqueName: String
    @Published var ficheTechniqueAuthor : String
    @Published var ficheTechniqueDesc : String
    @Published var listEtapes : [Etape]
    @Published var ficheTechniqueCategory : String
    @Published var error : TrackError = .noError
    
    init(ft : FicheTechnique){
        self.model = ft
        self.ficheTechniqueId = ft.ficheTechniqueId!
        self.image = ft.image
        self.ficheTechniqueName = ft.ficheTechniqueName
        self.ficheTechniqueAuthor = ft.ficheTechniqueAuthor
        self.ficheTechniqueDesc = ft.ficheTechniqueDesc
        self.listEtapes = ft.listEtapes
        self.ficheTechniqueCategory = ft.ficheTechniqueCategory
        ft.observer = self
    }
    
    
    func addFT(etape : Etape) {
        self.model.listEtapes.append(etape)
    }
//
//    func deleteStep(etape : Etape){
//        self.model.listEtapes.re
//    }
//
    func deleteStep(indexSet: IndexSet){
        listEtapes.remove(atOffsets: indexSet)
    }
    
    
    
    // MARK: -
    // MARK: FTObserver
    
    func change(name: String){
        print("vm observer : name changed => self.name = '\(name)'")
        self.ficheTechniqueName = name
    }
    
    func change(author: String){
        print("vm observer : name changed => self.author = '\(author)'")
        self.ficheTechniqueAuthor = author
    }
    
    func change(description: String){
        print("vm observer : name changed => self.description = '\(description)'")
        self.ficheTechniqueDesc = description
    }
    
    func change(category : String){
        print("vm observer : name changed => self.category = '\(category)'")
        self.ficheTechniqueCategory = category
    }
    
    func change(etapes : [Etape]){
        print("vm observer : name changed => self.etapes = '\(etapes)'")
        self.listEtapes = etapes
    }
    
    typealias Input = FTState
    typealias Failure = Never
    //appelée à l'inscription
    func receive(subscription: Subscription) {
        subscription.request(.unlimited) //unlimited : on veut recevoir toutes les valeurs
    }
    
    //au cas où le publisher déclare qu'il finit d'émettre : nous concerne pas
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    //activée à chaque send() du publisher
    func receive(_ input: Input) -> Subscribers.Demand {
        print("vm => intent \(input)")
        switch input{
        case .ready : break
        case .creatingFT(_): break
        case .changingFT(let ft) :
            print("vm : change model to \(self.model)")
            self.model.ficheTechniqueName = ft.ficheTechniqueName
            if ficheTechniqueName != self.model.ficheTechniqueName {
                print("vm : error detected => set vm error")
                self.error = .tooShortName
                self.ficheTechniqueName = self.model.ficheTechniqueName
                print("vm : error detected => self.ficheTechniqueName = '\(self.model.ficheTechniqueName)'")
            }
            self.model.ficheTechniqueAuthor = ft.ficheTechniqueAuthor
            if ficheTechniqueAuthor != self.model.ficheTechniqueAuthor {
                print("vm : error detected => set vm error")
                self.error = .tooShortName
                self.ficheTechniqueAuthor = self.model.ficheTechniqueAuthor
                print("vm : error detected => self.ficheTechniqueAuthor = '\(self.model.ficheTechniqueAuthor)'")
            }
            self.model.ficheTechniqueDesc = ft.ficheTechniqueDesc
            if ficheTechniqueDesc != self.model.ficheTechniqueDesc {
                print("vm : error detected => set vm error")
                self.error = .tooShortName
                self.ficheTechniqueDesc = self.model.ficheTechniqueDesc
                print("vm : error detected => self.ficheTechniqueDesc = '\(self.model.ficheTechniqueDesc)'")
            }
            self.model.ficheTechniqueCategory = ft.ficheTechniqueCategory
            if ficheTechniqueCategory != self.model.ficheTechniqueCategory {
                print("vm : error detected => set vm error")
                self.error = .tooShortName
                self.ficheTechniqueCategory = self.model.ficheTechniqueCategory
                print("vm : error detected => self.ficheTechniqueCategory = '\(self.model.ficheTechniqueCategory)'")
            }
            self.model.listEtapes = ft.listEtapes
            if listEtapes.elementsEqual(self.model.listEtapes, by: { $0.titreEtape == $1.titreEtape}) {
                self.listEtapes = self.model.listEtapes
            }
        case .changingSteps :
            print("list updated !")
            self.objectWillChange.send()
        case .nameChanged(_) : break
        }
        return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    // MARK: - Firestore
    
    private func addFT(_ ft: FicheTechnique) {
        do {
          let _ = try db.collection("ficheTechnique").addDocument(from: ft)
        }
        catch {
          print(error)
        }
      }
    
    private func deleteFT() {
        if let documentID = model.ficheTechniqueId {
            db.collection("ficheTechnique").document(documentID).delete {
                error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }

    }
    
    private func updateFT(_ ft : FicheTechnique) {
        if let documentID = model.ficheTechniqueId {
            print("oui")
            do {
                try db.collection("ficheTechnique").document(documentID).setData(from: ft)
            }
            catch {
                print(error)
            }
        }
    }
    
    func delete(){
        deleteFT()
    }
    
    func save(){
        addFT(self.model)
    }
    
    func update(){
        updateFT(self.model)
    }
    
}

