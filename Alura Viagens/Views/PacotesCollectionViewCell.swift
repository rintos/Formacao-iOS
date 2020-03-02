//
//  PacotesCollectionViewCell.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class PacotesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imagemViagem: UIImageView!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelQuantidadeDias: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    
    var callback: (() -> ())?
    
    
    override func awakeFromNib() {
        let botaoFavorito = UIButton(frame: CGRect(x: 92, y: 8, width: 40, height: 40))
        botaoFavorito.setImage(UIImage(systemName: "heart"), for: UIControlState.normal)
        botaoFavorito.addTarget(self, action: #selector(pacoteViagemFavorito), for: UIControlEvents.touchUpInside)
        addSubview(botaoFavorito)
    }
    
    // MARK: - Métodos
    
    func configuraCelula(_ pacoteViagem: PacoteViagem) {
        labelTitulo.text = pacoteViagem.titulo
        let quantidadeDias = String(pacoteViagem.quantidadeDeDias)
        labelQuantidadeDias.text = "\(quantidadeDias) dias"
        labelPreco.text = "R$ \(pacoteViagem.preco)"
        imagemViagem.image = UIImage(named: pacoteViagem.imageUrl)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        layer.cornerRadius = 8
    }
    
    
    @IBAction func pacoteViagemFavorito(_ sender: UIButton) -> Void {
        callback?()
        
    
    }
}

