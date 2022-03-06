//
//  FTUIView.swift
//  ProjetAWI
//
//  Created by m1 on 28/02/2022.
//
import SwiftUI

struct FTUIView : View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSheet = false
    @State private var actionSheet = false
    @State private var number = 1
    @State private var pdv : Double = 1.0
    @State private var cp : Double = 1.0
    @State private var chf : Double = 1.0
    @State private var listI : [Ingredient] = []
    @ObservedObject var ft : FTViewModel
    @ObservedObject var ftvm : FTVM
    
    
    var body : some View {
        
        ScrollView{
                AsyncImage(url: URL(string: ft.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300, alignment: .center)
                        .clipped()
                       // .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } placeholder : {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.white.opacity(0.7))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height : 300)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                
                Spacer()
                
                VStack(){
                    Group{
                        Text(ft.ficheTechniqueName)
                            .font(.largeTitle)
                            //.italic()
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(5)
                        Image("MainDishDivider")
                            .resizable()
                            .frame(width: 300, height: 30, alignment: .center)
                            .padding(.bottom, 10)
                            .padding(.top, 10)
                        Text("Réalisé par \(ft.ficheTechniqueAuthor)")
                            .padding(.bottom, 10)
                            .padding(.top, 10)
                        Text("\(ft.ficheTechniqueDesc)")
                            .padding(5)
                        Text("Nombre de couverts :")
                            .padding(5)
                        Stepper("\(number)",value: $number, in :  1...100)
                            .padding(.leading, 100)
                            .padding(.trailing, 100)
                            .padding(.bottom, 30)
                        VStack(alignment : .leading){
                            Text("Etapes :")
                                .font(.title)
                                .underline()
                        }
                        .padding(10)
                        Divider()
                        ForEach(ft.listEtapes, id: \.titreEtape)//tracksVM.tracks, id: \.trackId){
                        {
                            etape in
                            ListEtapeView(ft : ft, ftvm : ftvm, etape : etape)
                            
                        }
                        
                    }
                    Text("Synthèse : ")
                        .font(.title)
                        .underline()
                        .padding(.top, 30)
                    Group{
                        Text("Ingrédients utilisés : ")
                            .font(.headline)
                            .padding(10)
                        VStack{
                            ForEach(listIng(ft: ft).indices, id: \.self)//tracksVM.tracks, id: \.trackId){
                            {
                                ing in
                                HStack{
                                    Text(listIng(ft: ft)[ing].ingredientName)
                                    Text("\(Int(listQuantity(ft: ft)[ing])!*number)")
                                    Text(listIng(ft: ft)[ing].ingredientUnit)
                                    
                                }

                            }
                        }
                        Image("divider3")
                            .resizable()
                            .frame(width: 100, height: 60, alignment: .center)
                        Text("Paramètres pour le calcul de coûts : ")
                            .font(.headline)
                            .padding(10)
                        VStack(alignment :.leading){
                            HStack{
                                Spacer()
                                Text("Coef prix de vente : ")
                                    .font(.callout)
                                Spacer()
                                Text("Coef coût personnel : ")
                                    .font(.callout)
                                Spacer()
                                Text("Coût horaire des fluides : ")
                                    .font(.callout)
                                Spacer()
                            }
                            HStack{
                                Spacer()
                                TextField("\(pdv)", value : $pdv, formatter : NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Spacer()
                                TextField("\(cp)", value : $cp, formatter : NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Spacer()
                                TextField("\(chf)", value : $chf, formatter : NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Spacer()
                            }
                        }
                        .padding(10)
                    }
                    Image("divider3")
                        .resizable()
                        .frame(width: 100, height: 60, alignment: .center)
                    Text("Coûts")
                        .font(.headline)
                        .padding(10)
                    HStack{
                        VStack(alignment : .leading){
                            Text("Coût matière : ")
                                .padding(.bottom, 5)
                            Text("\(coutMatiere(listI: listIng(ft: ft), listQ: listQuantity(ft: ft))*Double(number)) euros")
                                .underline()
                            Spacer()
                            Text("Coût du personnel : ")
                                .padding(.bottom, 5)
                            Text("\(coutPersonnelOrFluide(ft:ft)*cp) euros")
                                .underline()
                            Spacer()
                            Text("Coût des fluides : ")
                                .padding(.bottom, 5)
                            Text("\(coutPersonnelOrFluide(ft:ft)*chf) euros")
                                .underline()
                            Spacer()
                        }
                        Divider()
                            .padding(10)
                        VStack(alignment : .leading){
                            Text("Coût de production : ")
                                .padding(.bottom, 5)
                            Text("\(coutMatiere(listI: listIng(ft: ft), listQ: listQuantity(ft: ft)) + coutPersonnelOrFluide(ft:ft)*cp + coutPersonnelOrFluide(ft:ft)*chf ) euros")
                                .underline()
                            Spacer()
                            Text("Coût de production par portion : ")
                                .padding(.bottom, 5)
                            Text("\((coutMatiere(listI: listIng(ft: ft), listQ: listQuantity(ft: ft)) + coutPersonnelOrFluide(ft:ft)*cp + coutPersonnelOrFluide(ft:ft)*chf)/Double(number) ) euros")
                                .underline()
                            Spacer()
                            Text("Coût des charges : ")
                                .padding(.bottom, 5)
                            Text("\(coutPersonnelOrFluide(ft:ft)*cp + coutPersonnelOrFluide(ft:ft)*chf) euros")
                                .underline()
                            Spacer()
                        }
                    }
                    .padding(10)
                    Image("divider3")
                        .resizable()
                        .frame(width: 100, height: 60, alignment: .center)
                    Text("Prix de vente et bénéfice")
                        .font(.headline)
                        .padding(10)
                    HStack{
                        VStack(alignment : .leading){
                            Text("Prix de vente : ")
                                .padding(.bottom, 5)
                            Text("\((coutMatiere(listI: listIng(ft: ft), listQ: listQuantity(ft: ft)) + coutPersonnelOrFluide(ft:ft)*cp + coutPersonnelOrFluide(ft:ft)*chf)*pdv ) euros")
                                .underline()
                            Spacer()
                            Text("Prix de vente par portion : ")
                                .padding(.bottom, 5)
                            Text("\(((coutMatiere(listI: listIng(ft: ft), listQ: listQuantity(ft: ft)) + coutPersonnelOrFluide(ft:ft)*cp + coutPersonnelOrFluide(ft:ft)*chf)*pdv)/Double(number) ) euros")
                                .underline()
                        }
                        Divider()
                            .padding(10)
                        VStack(alignment : .leading){
                            Text("Bénéfice par portion : ")
                                .padding(.bottom, 5)
                            Text("\((((coutMatiere(listI: listIng(ft: ft), listQ: listQuantity(ft: ft)) + coutPersonnelOrFluide(ft:ft)*cp + coutPersonnelOrFluide(ft:ft)*chf)*pdv)/Double(number))*0.9 - (coutMatiere(listI: listIng(ft: ft), listQ: listQuantity(ft: ft)) + coutPersonnelOrFluide(ft:ft)*cp + coutPersonnelOrFluide(ft:ft)*chf)/Double(number)) euros")
                                .underline()
                            Spacer()
                            Text("Seuil de rentabilité : ")
                                .padding(.bottom, 5)
                            Text("\((coutMatiere(listI: listIng(ft: ft), listQ: listQuantity(ft: ft)) + coutPersonnelOrFluide(ft:ft)*cp + coutPersonnelOrFluide(ft:ft)*chf)/(0.9*(coutMatiere(listI: listIng(ft: ft), listQ: listQuantity(ft: ft)) + coutPersonnelOrFluide(ft:ft)*cp + coutPersonnelOrFluide(ft:ft)*chf)*pdv)/Double(number)) euros")
                                .underline()
                        }
                    }
                    .padding(10)
                    HStack{
                        //Spacer()
                        Button(action : {
                            showingSheet.toggle()
                        }, label : {
                            Text("Modifier")
                                .bold()
                                .frame(width: 100, height: 40, alignment: .center)
                                .background(Color.green.opacity(0.35))
                                .cornerRadius(8)
                                .foregroundColor(Color.white)
                        }).sheet(isPresented: $showingSheet) { ModifFTView(ft : ft, ftvm : ftvm) }
                        .padding(30)
                        //Spacer()
                        Button(action : {
                            self.actionSheet = true
                            //self.ft.delete()
//                            NavigationView{
//                                ListFTView(ftvm: ftvm)
//                                }

                        }, label : {
                            Text("Supprimer")
                                .bold()
                                .frame(width: 100, height: 40, alignment: .center)
                                .background(Color.red.opacity(0.35))
                                .cornerRadius(8)
                                .foregroundColor(Color.white)
                        })
                        .padding(30)
                       // Spacer()
                    }
                    
                    
                }
                //.frame(maxWidth : .infinity, alignment :.leading)
                //.padding(.horizontal)
            }
        .actionSheet(isPresented: $actionSheet){
        ActionSheet(title: Text("Etes-vous sûr ?"),
                    buttons: [
                        .destructive(Text("Supprimer"), action : {
                            self.ft.delete()
                        }),
                        .cancel()
                    ])
            
        }
        .ignoresSafeArea()
        .background(Color(red: 0.8784, green : 0.8039, blue : 0.6627).opacity(0.5))

        
    }
    
    private func listIng(ft : FTViewModel) -> [Ingredient]{
        var result : [Ingredient] = []
        for i in stride(from: 0, to: ft.listEtapes.count, by: 1) {
            for j in stride(from: 0, to: ft.listEtapes[i].listIng.count, by: 1) {
                result.append(ft.listEtapes[i].listIng[j])
                //print(ft.listEtapes[i].listIng[j].ingredientId)
            }
        }
        return result
    }
    
    private func listQuantity(ft : FTViewModel) -> [String]{
        var result : [String] = []
        for i in stride(from: 0, to: ft.listEtapes.count, by: 1) {
            for j in stride(from: 0, to: ft.listEtapes[i].listIng.count, by: 1) {
                result.append(ft.listEtapes[i].listQuantity[j])
            }
        }
        return result
    }
    
    private func coutMatiere(listI : [Ingredient], listQ : [String]) -> Double{
        var result : Double = 0
        for i in stride(from: 0, to: listI.count, by: 1){
            let quantity = Double(listQ[i]) ?? 0
            let price = Double(listI[i].ingredientUnitprice) ?? 0
            result = result + (price*quantity)
        }
        result = (result * 1.05).roundToDecimal(2)
        return result
    }
    
    private func coutPersonnelOrFluide(ft: FTViewModel) -> Double {
        var result : Double = 0
        for i in stride(from: 0, to: ft.listEtapes.count, by: 1){
            let duree = Double(ft.listEtapes[i].duree) ?? 0
            result = result + duree / 60
        }
        return result
    }
    
    
}

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self*multiplier) / multiplier
    }
}

