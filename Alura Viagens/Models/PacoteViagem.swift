//
//  PacoteViagem.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class PacoteViagem {
    

    let id: Int
    let titulo: String
    let quantidadeDeDias: Int
    let preco: String
    let imageUrl: String
    let localizacao: String
    let nomeDoHotel: String
    let descricao: String
    let dataViagem: String
    var favoritoStatus: Bool
    
    init(id: Int = 0,titulo: String = "", quantidadeDeDias: Int = 0, preco:String = "", imageUrl: String = "", localizacao:String = "",  nomeDoHotel: String, descricao: String, dataViagem: String, favoritoStatus: Bool = false) {
        self.id = id
        self.titulo = titulo
        self.quantidadeDeDias = quantidadeDeDias
        self.preco = preco
        self.imageUrl = imageUrl
        self.localizacao = localizacao
        self.nomeDoHotel = nomeDoHotel
        self.descricao = descricao
        self.dataViagem = dataViagem
        self.favoritoStatus = favoritoStatus
    }
    
    convenience init() {
        self.init(id: 0, titulo: "", quantidadeDeDias: 0, preco: "", imageUrl: "", localizacao: "", nomeDoHotel: "", descricao: "", dataViagem: "", favoritoStatus: false)
    }
    
    func desserializaPacoteViagem (pacoteDict: [Dictionary<String, Any>]) -> [PacoteViagem] {
        var listaPacoteViagem: [PacoteViagem] = []
        
        for itemDict in pacoteDict {
            let id = itemDict["id"] as? Int ?? 0
            let titulo = itemDict["titulo"] as? String ?? ""
            let quantidadeDeDias = itemDict["quantidadeDeDias"] as? Int ?? 0
            let preco = itemDict["preco"] as? String ?? ""
            let imageUrl = itemDict["imageUrl"] as? String ?? ""
            let localizacao = itemDict["localizacao"] as? String ?? ""
            let nomeDoHotel = itemDict["nomeDoHotel"] as? String ?? ""
            let servico = itemDict["servico"] as? String ?? ""
            let data = itemDict["data"] as? String ?? ""
            
            let pacote = PacoteViagem(id: id, titulo: titulo, quantidadeDeDias: quantidadeDeDias, preco: preco, imageUrl: imageUrl, localizacao: localizacao, nomeDoHotel: nomeDoHotel, descricao: servico, dataViagem: data)
            
            listaPacoteViagem.append(pacote)
        }
        
        return listaPacoteViagem
    }
    
    
//    "id": 1,
//    "titulo": "Porto de Galinhas",
//    "quantidadeDeDias": 7,
//    "preco": "2.490,99",
//    "imageUrl": "http://localhost:26795/imagens/porto-de-galinhas.jpg",
//    "localizacao": "Porto de galinhas",
//    "nomeDoHotel": "Resort Porto de Galinhas",
//    "servico": "Hotel + café da manhã",
//    "data": "8~15 de agosto"

}
