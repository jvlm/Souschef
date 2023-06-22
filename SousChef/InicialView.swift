//
//  InicialView.swift
//  SousChef
//
//  Created by Student on 28/04/23.
//

import SwiftUI

struct InicialView: View {
    @StateObject var viewModel : ViewModel

    var body: some View {
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
            Divider()
                .background(Color.black)
            ScrollView {
                VStack {
                    Text("Novidades")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack {
                        ForEach (viewModel.receitas) { receita in
                            NavigationLink {
                                RecipeView(receita: receita)
                            } label: {
                                VStack {
                                    AsyncImage(
                                        url: URL(string: receita.imgUrl!),
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
                                            Text(receita.nome!)
                                                .font(.headline)
                                                .foregroundColor(Color.white)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            HStack(spacing: 4.0){
                                                Image(systemName: "clock")
                                                Text("\(receita.tempoPreparo!) minutos")
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(.white)
                                            .padding(.bottom)
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
            }
            .onAppear() {
                viewModel.fetchReceitas()
            }
        }
    }
}

struct InicialView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        InicialView(viewModel: vm)
    }
}
