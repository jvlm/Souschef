//
//  BuscaV2View.swift
//  SousChef
//
//  Created by Student on 09/05/23.
//

import SwiftUI

struct BuscaV2View: View {
    @StateObject var viewModel : ViewModel

    @State var resultadoReceitas : [QResultadoReceita] = []
    @State var resultadoIngredientes : [QResultadoIngrediente] = []

    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("souschef")
                        .font(.headline)
                        .foregroundColor(Color("TabBarHighlight"))
                    Spacer()
                    Image(systemName: "person.circle")
                        .foregroundColor(Color("TabBarHighlight"))
                }
                .padding(.horizontal)
                Divider()
                    .background(Color.black)
                VStack {
                    HStack {
                        Text("Ingredientes Desejados")
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        NavigationLink {
                            FiltroIngDesejadosView(viewModel: viewModel).navigationBarBackButtonHidden(true)
                        } label: {
                            Image(systemName: "plus")
                        }
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
                    
                    HStack {
                        Text("Ingredientes Restritos")
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        NavigationLink {
                            FiltroIngRestritosView(viewModel: viewModel).navigationBarBackButtonHidden(true)
                        } label: {
                            Image(systemName: "plus")
                        }
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
                    
                    Button(
                        "Buscar",
                        action: {
                            resultadoReceitas = filtrarReceitas(recList: viewModel.receitas, ingQDesjList: viewModel.ingrDesej, ingQRestList: viewModel.ingrRestr)
                        }
                    )
                    .buttonStyle(.borderedProminent)
                    
                    ScrollView {
                        ForEach(resultadoReceitas) { r in
                            NavigationLink {
                                RecipeView(receita: r.receita)
                            } label: {
                                VStack{
                                    AsyncImage(
                                        url: URL(string: r.receita.imgUrl!),
                                        content: { image in
                                            image.resizable()
                                                .frame(maxWidth: 400, maxHeight: 200)
                                        },
                                        placeholder: {
                                            ProgressView()
                                        }
                                    )
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(r.receita.nome!)
                                                .font(.headline)
                                                .foregroundColor(Color.white)
                                            HStack(spacing: 4.0) {
                                                Image(systemName: "clock")
                                                Text(String(r.receita.tempoPreparo!))
                                            }
                                            .foregroundColor(.white)
                                            .padding(.bottom)
                                        }
                                        .padding(.leading)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(red: 0.19, green: 0.29, blue: 0.47))
                                .clipShape(RoundedRectangle(cornerRadius: 24.0))
                                .shadow(radius: 5)
                            }
                            
                        }
                        Spacer()
                    }
                }
                .onAppear() {
                    viewModel.fetchReceitas()
                    viewModel.fetchIngredientes()
                }
                .padding()
            }//
        }
    }
}

struct BuscaV2View_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        BuscaV2View(viewModel: vm)
    }
}
