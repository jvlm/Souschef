//
//  QResultadoReceitaStruct.swift
//  SousChef
//
//  Created by Student on 09/05/23.
//

import Foundation

struct QResultadoReceita : Identifiable {
    var id : Int
    var receita : Receita
    var qtd : Int
    var total : Int
    // Inserir a lista de ingredientes contidos?
}
