//
//  ContentView.swift
//  SousChef
//
//  Created by Student on 27/04/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    init() {
    UITabBar.appearance().backgroundColor = UIColor.white

    }
    
    var body: some View {
        NavigationStack {
            TabView {
                InicialView(viewModel: viewModel)
                    .tabItem {
                        Label("Início", systemImage: "house.fill")
                    }
                
                BuscaV2View(viewModel: viewModel)
                    .tabItem {
                        Label("Buscar", systemImage: "magnifyingglass")
                    }
                
                ListaView(viewModel: viewModel)
                    .tabItem {
                        Label("Listas", systemImage: "star.fill")
                    }
                
                PerfilView()
                    .tabItem {
                        Label("Perfil", systemImage: "person.fill")
                    }
            }
            .background {
                Color(.black)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
