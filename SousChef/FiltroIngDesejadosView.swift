//
//  FiltroIngDesejadosView.swift
//  SousChef
//
//  Created by Student on 09/05/23.
//

import SwiftUI

struct FiltroIngDesejadosView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel : ViewModel

    @State var resultadoIngredientes : [QResultadoIngrediente] = []
    
    @State private var ingredienteSearchText = ""
    @State private var ingredienteValido = false
    @State private var novoIngredienteDesejValido = false
    @State private var ingVazio = true
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                }

                TextField("Eu quero...", text: $ingredienteSearchText)
                    .onChange(of: ingredienteSearchText) { ing in
                        ingVazio = ing.isEmpty
                        
                        resultadoIngredientes = getIngredientesSuggestionsList(ingList: viewModel.ingredientes, ingName: ing)
                        ingredienteValido = isNomeIngredienteValido(ingList: viewModel.ingredientes, ingNome: ing)

                        let inDesej = isPresenteEmDesej(ingrDesej: viewModel.ingrDesej, ingNome: ing)
                        let inRestr = isPresenteEmRestr(ingrRestr: viewModel.ingrRestr, ingNome: ing)

                        novoIngredienteDesejValido = ingredienteValido && !inDesej && !inRestr
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
                    if novoIngredienteDesejValido {
                        viewModel.ingrDesej = updateListaFiltrosIngredientesDR(ingList: viewModel.ingredientes, ingFilterList: viewModel.ingrDesej, ingNome: ingredienteSearchText)
                        ingredienteSearchText = ""
                    }
                } label: {
                    HStack {
                        Image(systemName: "plus")
                    }
                    .fixedSize()
                }
                .buttonStyle(.borderedProminent)
                .disabled(!novoIngredienteDesejValido)
            }
            ScrollView (.horizontal) {
                HStack {
                    ForEach(viewModel.ingrDesej) { ingD in
                        HStack {
                            Button {
                                viewModel.ingrDesej = deleteListaFiltrosIngredientesDR(ingList: viewModel.ingredientes, ingFilterList: viewModel.ingrDesej, ingNome: ingD.ingrediente.nome!)
                            } label: {
                                Image(systemName: "xmark")
                            }
                            Text(ingD.ingrediente.nome!)
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
                            viewModel.ingrDesej = updateListaFiltrosIngredientesDR(ingList: viewModel.ingredientes, ingFilterList: viewModel.ingrDesej, ingNome: ing)
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
        }
        .padding()
    }
}
