//
//  ViewModel.swift
//  SousChef
//
//  Created by Student on 27/04/23.
//

import Foundation




class ViewModel : ObservableObject {
    @Published var receitas : [Receita] = []
    @Published var ingredientes : [Ingrediente] = []
    @Published var ingrDesej : [QResultadoIngrediente] = []
    @Published var ingrRestr : [QResultadoIngrediente] = []
    
    
    func fetchReceitas() {
        guard let url = URL(string: "http://172.20.10.2:1880/souschef/getreceitas") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([Receita].self, from: data)
                
                DispatchQueue.main.async {
                    self?.receitas = parsed
                    for i in 0..<self!.receitas.count {
                        self?.receitas[i].id = i
                    }
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func fetchIngredientes() {
        guard let url = URL(string: "http://172.20.10.2:1880/souschef/getingredientes") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([Ingrediente].self, from: data)
                
                DispatchQueue.main.async {
                    self?.ingredientes = parsed
                    for i in 0..<self!.ingredientes.count {
                        self?.ingredientes[i].id = i
                    }
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
