//
//  Viagem.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class Viagem {
    
    let id: Int
    let titulo: String
    let quantidadeDeDias: Int
    let preco: String
    let caminhoDaImagem: String
    let localizacao: String
    
    init(id: Int = 0, titulo: String, quantidadeDeDias: Int, preco: String, caminhoDaImagem: String, localizacao: String = "") {
        self.id = id
        self.titulo = titulo
        self.quantidadeDeDias = quantidadeDeDias
        self.preco = preco
        self.caminhoDaImagem = caminhoDaImagem
        self.localizacao = localizacao
    }
    
    convenience init () {
        self.init(id: 0, titulo: "", quantidadeDeDias: 0, preco: "", caminhoDaImagem: "", localizacao: "")
    }
    
    
    func desserializaJson(viagemDict: [[String: Any]]) -> [Viagem] {
        var listaViagem: [Viagem] = []
        
        for itemDict in viagemDict {
            let id = itemDict["id"] as? Int ?? 00
            let titulo = itemDict["titulo"] as? String ?? ""
            let quantidadeDeDias = itemDict["quantidadeDeDias"] as? Int ?? 0
            let preco = itemDict["preco"] as? String ?? ""
            let caminhoDaImagem = itemDict["imageUrl"] as? String ?? ""
            let localizacao = itemDict["localizacao"] as? String ?? ""
            
            let viagem = Viagem(id: id, titulo: titulo, quantidadeDeDias: quantidadeDeDias, preco: preco, caminhoDaImagem: caminhoDaImagem, localizacao: localizacao)
            
            listaViagem.append(viagem)
        }

        return listaViagem
    }

}
