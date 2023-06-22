//
//  FiltroIngRestritosView.swift
//  SousChef
//
//  Created by Student on 09/05/23.
//

import SwiftUI

struct FiltroIngRestritosView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel : ViewModel
    
    @State var resultadoIngredientes : [QResultadoIngrediente] = []
    
    @State private var ingredienteSearchText = ""
    @State private var ingredienteValido = false
    @State private var novoIngredienteRestrValido = false
    @State private var ingVazio = true
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                }

                TextField("Eu não quero...", text: $ingredienteSearchText)
                    .onChange(of: ingredienteSearchText) { ing in
                        ingVazio = ing.isEmpty
                        
                        resultadoIngredientes = getIngredientesSuggestionsList(ingList: viewModel.ingredientes, ingName: ing)
                        ingredienteValido = isNomeIngredienteValido(ingList: viewModel.ingredientes, ingNome: ing)

                        let inDesej = isPresenteEmDesej(ingrDesej: viewModel.ingrDesej, ingNome: ing)
                        let inRestr = isPresenteEmRestr(ingrRestr: viewModel.ingrRestr, ingNome: ing)

                        novoIngredienteRestrValido = ingredienteValido && !inDesej && !inRestr
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay (alignment: .trailing) {
                        if (!ingVazio) {
                            Button {
                                ingredienteSearchText = ""
                            } label: {
                                Image(systemName: "xmark")
                            }
                        }
                    }

                Button {
                    if novoIngredienteRestrValido {
                        viewModel.ingrRestr = updateListaFiltrosIngredientesDR(ingList: viewModel.ingredientes, ingFilterList: viewModel.ingrRestr, ingNome: ingredienteSearchText)
                        ingredienteSearchText = ""
                    }
                    
                } label: {
                    HStack {
                        Image(systemName: "minus")
                    }
                    .fixedSize()
                }
                .buttonStyle(.borderedProminent)
                .disabled(!novoIngredienteRestrValido)
            }

            ScrollView (.horizontal) {
                HStack {
                    ForEach(viewModel.ingrRestr) { ingR in
                        HStack {
                            Button {
                                viewModel.ingrRestr = deleteListaFiltrosIngredientesDR(ingList: viewModel.ingredientes, ingFilterList: viewModel.ingrRestr, ingNome: ingR.ingrediente.nome!)
                            } label: {
                                Image(systemName: "xmark")
                            }

                            Text(ingR.ingrediente.nome!)
                        }
                        .padding(5)
                        .foregroundColor(.white)
                        .background {
                            Color(red: 0.19, green: 0.29, blue: 0.47)
                        }
                        .cornerRadius(5)
                    }
                }
            }

            ScrollView {
                ForEach(resultadoIngredientes) { qIng in
                    HStack {
                        Text(qIng.ingrediente.nome!)
                        Spacer()
                    }
                    .onTapGesture {
                        let ing = qIng.ingrediente.nome!
                        let inDesej = isPresenteEmDesej(ingrDesej: viewModel.ingrDesej, ingNome: ing)
                        let inRestr = isPresenteEmRestr(ingrRestr: viewModel.ingrRestr, ingNome: ing)
                        
                        if !inDesej && !inRestr {
                            viewModel.ingrRestr = updateListaFiltrosIngredientesDR(ingList: viewModel.ingredientes, ingFilterList: viewModel.ingrRestr, ingNome: ing)
                            ingredienteSearchText = ""
                        }
                    }
                    .overlay(alignment: .trailing) {
                        Button {
                            ingredienteSearchText = qIng.ingrediente.nome!
                        } label: {
                            Image(systemName: "arrow.up.left")
                        }
                    }
                    .padding(.top)
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
