//
//  AuxFunctions.swift
//  SousChef
//
//  Created by Student on 09/05/23.
//

import Foundation

func subsetIngredientes(ingList: [Ingrediente], codIngs: [Int]) -> [Ingrediente] {
    var filtrados : [Ingrediente] = []
    
    for ing in ingList {
        if codIngs.contains(ing.codigo!) {
            filtrados.append(ing)
        }
    }
    
    return filtrados
}

func filtrarReceitas(recList: [Receita], ingQDesjList: [QResultadoIngrediente], ingQRestList: [QResultadoIngrediente]) -> [QResultadoReceita] {
    var filtradas : [Receita] = []
    var query : [QResultadoReceita] = []
    var codIngDesj : [Int] = []
    var codIngRest : [Int] = []
    
    for idesj in ingQDesjList {
        codIngDesj.append(idesj.ingrediente.codigo!)
    }

    for irest in ingQRestList {
        codIngRest.append(irest.ingrediente.codigo!)
    }

    for r in recList {
        if Array(Set(r.ingredientes!).intersection(Set(codIngRest))).count == 0 {
            filtradas.append(r)
        }
    }

    filtradas.sort{
        let c0 = Array(Set($0.ingredientes!).intersection(Set(codIngDesj))).count
        let c1 = Array(Set($1.ingredientes!).intersection(Set(codIngDesj))).count
        return c0 > c1
    }

    for i in 0..<filtradas.count {
        let qtd = Array(Set(filtradas[i].ingredientes!).intersection(Set(codIngDesj))).count
        query.append(QResultadoReceita(id: i, receita: filtradas[i], qtd: qtd, total: ingQDesjList.count))
    }
    
    return query
}

func getIngredienteObjectFromName(ingList: [Ingrediente], ingNome: String) -> Ingrediente? {
    for i in ingList {
        if i.nome!.lowercased() == ingNome.lowercased() {
            return i
        }
    }
    return nil
}

func getIngredientesSuggestionsList(ingList: [Ingrediente], ingName: String) -> [QResultadoIngrediente] {
    let value = ingName.lowercased()

    if (value.count == 0) {
        return []
    }

    var filtrados : [QResultadoIngrediente] = []
    var filtradosReserva : [QResultadoIngrediente] = []
    
    for di in ingList {
        if (di.nome!.lowercased().prefix(value.count) == value) {
            filtrados.append(QResultadoIngrediente(id: -1, ingrediente: di))
        } else if (di.nome!.lowercased().contains(value)) {
            filtradosReserva.append(QResultadoIngrediente(id: -1, ingrediente: di))
        }
    }
    
    var resultados = filtrados + filtradosReserva
    for i in 0..<resultados.count {
        resultados[i].id = i
    }

    return resultados
}

func isNomeIngredienteValido(ingList: [Ingrediente], ingNome: String) -> Bool {
    var valido = false

    for i in ingList {
        if i.nome!.lowercased() == ingNome.lowercased() {
            valido = true
            break
        }
    }
    
    return valido
}

func isPresenteEmDesej(ingrDesej: [QResultadoIngrediente], ingNome: String) -> Bool {
    var presenteEmDesej = false

    for i in ingrDesej {
        if i.ingrediente.nome!.lowercased() == ingNome.lowercased() {
            presenteEmDesej = true
            break
        }
    }
    
    return presenteEmDesej
}

func isPresenteEmRestr(ingrRestr: [QResultadoIngrediente], ingNome: String) -> Bool {
    var presenteEmRestr = false

    for i in ingrRestr {
        if i.ingrediente.nome!.lowercased() == ingNome.lowercased() {
            presenteEmRestr = true
            break
        }
    }
    
    return presenteEmRestr
}

func updateListaFiltrosIngredientesDR(ingList: [Ingrediente], ingFilterList: [QResultadoIngrediente], ingNome: String) -> [QResultadoIngrediente] {
    var novaLista : [QResultadoIngrediente] = []

    novaLista.append(QResultadoIngrediente(id: -1, ingrediente: getIngredienteObjectFromName(ingList: ingList, ingNome: ingNome)!))
    novaLista += ingFilterList

    for i in 0..<novaLista.count {
        novaLista[i].id = i
    }

    return novaLista
}

func deleteListaFiltrosIngredientesDR(ingList: [Ingrediente], ingFilterList: [QResultadoIngrediente], ingNome: String) -> [QResultadoIngrediente] {
    var novaLista : [QResultadoIngrediente] = []

    novaLista = ingFilterList
    
    var index = -1
    
    for i in 0..<novaLista.count {
        if novaLista[i].ingrediente.nome! == ingNome {
            index = i
        }
    }
    
    novaLista.remove(at: index)

    for i in 0..<novaLista.count {
        novaLista[i].id = i
    }

    return novaLista
}

func addReceitaFavorita(rec: Receita) -> [QResultadoReceita] {
    
    global.favoritas.append(QResultadoReceita(id: global.favoritas.count, receita: rec, qtd: -1, total: -1))

    return global.favoritas
}

func removeReceitaFavorita(rec: Receita, listaFavoritas: [QResultadoReceita]) -> [QResultadoReceita] {
//    var novaLista : [QResultadoReceita] = []
//
//    novaLista = listaFavoritas
//
    var index = -1
//
    for i in 0..<global.favoritas.count {
        if global.favoritas[i].receita.nome! == rec.nome! {
            index = i
        }
    }
//
    global.favoritas.remove(at: index)
//
//    for i in 0..<novaLista.count {
//        novaLista[i].id = i
//    }

    
    return global.favoritas
}
