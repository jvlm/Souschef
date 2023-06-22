//
//  InicialView.swift
//  SousChef
//
//  Created by Student on 28/04/23.
//

import SwiftUI

struct ListaView: View {
    @StateObject var viewModel : ViewModel
    @State var isPlaying = false
    @State var color = Color.red
    var body: some View {
        ScrollView {
            VStack{
                HStack{
                    Text("souschef")
                        .font(.headline)
                        .foregroundColor(Color("TabBarHighlight"))
                    Spacer()
                    Image(systemName: "person.circle")
                        .foregroundColor(Color("TabBarHighlight"))
                }
                .padding(.horizontal)
                
                
                VStack {
                    Text("Favoritos")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack {
                        ForEach (global.favoritas) { r in
                            NavigationLink {
                                RecipeView(receita: r.receita)
                            } label: {
                                VStack {
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
                                        VStack {
                                            Text(r.receita.nome!)
                                                .font(.headline)
                                                .foregroundColor(color)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            HStack {
                                                HStack(spacing: 4.0){
                                                    Image(systemName: "clock")
                                                    HStack(spacing: 4.0){
                                                        Text("\(r.receita.tempoPreparo!) minutos")
                                                        Button(action: {
                                                            self.isPlaying.toggle()
                                                            global.favoritas = removeReceitaFavorita(rec: r.receita, listaFavoritas: global.favoritas)
                                                            
                                                            color = .white
                                                        }, label: {
                                                            Image(systemName: "xmark")
                                                                .padding(.trailing)
                                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                                                .foregroundColor(.white)
                                                            
                                                        })
                                                    }
                                                }
                                                .foregroundColor(.white)
                                                .padding(.bottom)
                                                
                                            }
                                        }
                                        .padding(.leading)
                                    }
                                }
                            }
                        }
                        .background(Color(red: 0.19, green: 0.29, blue: 0.47))
                        .clipShape(RoundedRectangle(cornerRadius: 24.0))
                        .shadow(radius: 5)
                    }
                }
                .padding(10)
            }.onAppear() {
                viewModel.fetchReceitas()
                color = [.red, .blue].randomElement()!
            }
        }
        
    }
}

struct ListaView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        ListaView(viewModel: vm)
    }
}

