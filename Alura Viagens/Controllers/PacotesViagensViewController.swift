//
//  PacotesViagensViewController.swift
//  Alura Viagens
//
//  Created by Alura on 25/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class PacotesViagensViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UISearchBarDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var colecaoPacotesViagens: UICollectionView!
    @IBOutlet weak var pesquisarViagens: UISearchBar!
    @IBOutlet weak var labelContadorPacotes: UILabel!
    
    // MARK: - Atributos
    
    let listaComTodasViagens: [PacoteViagem] = PacoteViagemDao().retornaTodasAsViagens()
    var listaViagens: [PacoteViagem] = []
    var listaDePacotes: [PacoteViagem] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pesquisarViagens.delegate = self
        labelContadorPacotes.text = atualizaContadorLabel()
        getListaPacotes()
        configCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getListaPacotes()
    }
    
    // MARK: - Métodos
    
    func atualizaContadorLabel() -> String {
        return listaViagens.count == 1 ? "1 pacote encontrado" : "\(listaViagens.count) pacotes encontrados"
    }
    
    func getListaPacotes() {
        PacotesAPI().recuperaListaDePacotesAPI(completion: { (listaPacotes) in
            for item in listaPacotes {
                print("Pacote----> \(item.nomeDoHotel) quantidadeDias:\(item.quantidadeDeDias)")
                self.listaDePacotes.append(item)
            }
            self.listaViagens = self.listaDePacotes

            self.colecaoPacotesViagens.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func configCollectionView() {
        colecaoPacotesViagens.delegate = self
        colecaoPacotesViagens.dataSource = self
    }
    
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listaViagens = listaDePacotes
        if searchText != "" {
            listaViagens = listaViagens.filter({ $0.viagem.titulo.contains(searchText) })
        }
        labelContadorPacotes.text = atualizaContadorLabel()
        colecaoPacotesViagens.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaDePacotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaPacote = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaPacote", for: indexPath) as! PacotesCollectionViewCell
        let pacoteAtual = listaDePacotes[indexPath.item]
        celulaPacote.configuraCelula(pacoteAtual)
        
        return celulaPacote
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pacote = listaViagens[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhes") as! DetalhesViagemViewController
        controller.pacoteSelecionado = pacote
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - UICollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2-20, height: 160) : CGSize(width: collectionView.bounds.width/3-20, height: 250)
    }
}
