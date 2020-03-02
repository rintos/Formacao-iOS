//
//  FavoritosViewController.swift
//  Alura Viagens
//
//  Created by Victor Soares de Almeida on 28/02/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class FavoritosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var favoritosCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuraCollectionView()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoritosCollectionView.reloadData()
    }
    

    
    func configuraCollectionView() {
        favoritosCollectionView.delegate = self
        favoritosCollectionView.dataSource = self
        favoritosCollectionView.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let listaPacotes = PacoteViagemDao().recuperaPacotesFavoritos()
        return listaPacotes.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellFav", for: indexPath) as! FavoritosCollectionViewCell
        let listaPacotes = PacoteViagemDao().recuperaPacotesFavoritos()
        let pacote = listaPacotes[indexPath.item]
        celula.configuraCelula(pacote)
        
        return celula
    }
    

}
