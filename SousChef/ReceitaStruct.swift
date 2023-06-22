//
//  ReceitaStruct.swift
//  SousChef
//
//  Created by Student on 09/05/23.
//

import Foundation

struct Receita : Decodable, Identifiable {
    var id : Int?
    var codigo : Int?
    var nome : String?
    var ingredientes : [Int]?
    var porcoes : Int?
    var descricaoIngredientes : [String]?
    var preparo : [String]?
    var tempoPreparo : Int?
    var imgUrl : String?
}


struct global {
    static var favoritas: [QResultadoReceita] = []
}
