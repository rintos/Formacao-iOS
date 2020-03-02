//
//  FavoritosCollectionViewCell.swift
//  Alura Viagens
//
//  Created by Victor Soares de Almeida on 28/02/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class FavoritosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var favoritoImageView: UIImageView!
    @IBOutlet weak var favoritoTitulo: UILabel!
    @IBOutlet weak var favoritoQuantidadeDias: UILabel!
    @IBOutlet weak var favoritoPreco: UILabel!
    
    
    
    func configuraCelula(_ pacotes: PacotesDeViagens ) {
        favoritoTitulo.text = pacotes.titulo
        favoritoQuantidadeDias.text = "\(pacotes.quantidadeDeDias) dias"
        if let preco = pacotes.preco {
            favoritoPreco.text = "R$ \(preco)"
        }
        favoritoImageView.image = UIImage(named: "\(pacotes.id).jpg")
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        layer.cornerRadius = 8
    }
    
}
