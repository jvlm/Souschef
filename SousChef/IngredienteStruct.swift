//
//  IngredienteStruct.swift
//  SousChef
//
//  Created by Student on 09/05/23.
//

import Foundation

struct Ingrediente : Decodable, Identifiable {
    var id : Int?
    var codigo : Int?
    var nome : String?
}
