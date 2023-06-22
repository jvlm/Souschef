//
//  RecipeView.swift
//  test souchef
//
//  Created by Student on 09/05/23.
//

import SwiftUI

struct RecipeView: View {
    @State var receita : Receita
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(receita.nome!)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        
                        Button {
                            global.favoritas = addReceitaFavorita(rec: receita)
                            print("FOI")
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                    }
                    .padding(.bottom)
                    
                    Text("Tempo de preparo: \(receita.tempoPreparo!) minutos")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Serve: \(receita.porcoes!) porções")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    AsyncImage(
                        url: URL(string: receita.imgUrl!),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .cornerRadius(10)
                                .padding(.bottom)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    Divider()
                        .background(Color.black)
                   
                    Text("Ingredientes necessários: ")
                        .font(.title3)
                        .bold()
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(receita.descricaoIngredientes!, id: \.self ){ ing in
                        Text(ing)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        //                        .multilineTextAlignment(.leading)
                    }
                    Divider()
                        .background(Color.black)
                    
                    Text("Modo de preparo: ")
                        .font(.title3)
                        .bold()
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ForEach(receita.preparo!, id: \.self ){ ing in
                        Text(ing)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                }
                .padding()
            }
        }
    }
}

//struct RecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        let vm = ViewModel()
//        RecipeView(viewModel: vm)
//    }
//}
