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
    
    var listaViagens: [PacoteViagem] = []
    var listaDePacotes: [PacoteViagem] = []
    var pacotesViagens: [PacoteViagem] = []
    var verificaFavorito: Bool = true

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        pesquisarViagens.delegate = self
        labelContadorPacotes.text = atualizaContadorLabel()
        getListaPacotes()
        
        colecaoPacotesViagens.keyboardDismissMode = .onDrag
    }
    
    override func viewDidAppear(_ animated: Bool) {
        labelContadorPacotes.text = atualizaContadorLabel()
    }
    
    // MARK: - Métodos
    func atualizaContadorLabel() -> String {
        return pacotesViagens.count == 1 ? "1 pacote encontrado" : "\(pacotesViagens.count) pacotes encontrados"
    }
    
    func getListaPacotes() {
        
        PacotesAPI().recuperaListaDePacotesAPI(completion: { (listaPacotes) in
            for item in listaPacotes {
                self.listaDePacotes.append(item)
            }
            self.listaViagens = self.listaDePacotes
            self.pacotesViagens = self.listaDePacotes

            self.colecaoPacotesViagens.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func verificaFavoritos (_ pacoteSelecionado: PacoteViagem ) -> Bool {
        
        let listaPacoteFavorito = PacoteViagemDao().recuperaPacotesFavoritos()
        
        for favorito in listaPacoteFavorito {
            let idFavorito = Int(favorito.id)
            if idFavorito == pacoteSelecionado.id {
                return true
            }
        }
        return false
        
    }
    
    func configCollectionView() {
        colecaoPacotesViagens.delegate = self
        colecaoPacotesViagens.dataSource = self
        colecaoPacotesViagens.reloadData()
    }
    
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            pacotesViagens = listaViagens
            colecaoPacotesViagens.reloadData()
            return
        }
        
        listaViagens = listaDePacotes
        if searchText != "" {
            pacotesViagens = pacotesViagens.filter({ $0.titulo.contains(searchText) })
        }
        labelContadorPacotes.text = atualizaContadorLabel()
        colecaoPacotesViagens.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pacotesViagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaPacote = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaPacote", for: indexPath) as! PacotesCollectionViewCell
        let pacoteAtual = pacotesViagens[indexPath.item]
        celulaPacote.configuraCelula(pacoteAtual)
        
        if pacoteAtual.favoritoStatus {
            celulaPacote.botaoFavorito.setImage(UIImage(systemName: "star.fill"), for: UIControlState.normal)
        }
        
        celulaPacote.callback = { [unowned self] in
            let indexPathSelecionado =  indexPath.row
            
            if self.verificaFavoritos(self.pacotesViagens[indexPathSelecionado]) {
                let id = self.pacotesViagens[indexPathSelecionado].id
                PacoteViagemDao().deletaPacoteViagem(id)
                celulaPacote.preencheImagem = false
            } else {
                PacoteViagemDao().salvarPacoteViagem(self.pacotesViagens[indexPathSelecionado])
                celulaPacote.preencheImagem = true
            }
        }
        
        return celulaPacote
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pacote = pacotesViagens[indexPath.item]
        print("\(pacote.titulo) clicado")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhes") as! DetalhesViagemViewController
        controller.pacoteSelecionado = pacote
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - UICollectionViewLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2-20, height: 160) : CGSize(width: collectionView.bounds.width/3-20, height: 250)
    }
    
    
    // MARK: - Action Button
    
//    @IBAction func pacoteViagemFavorito(_ sender: UIButton) -> Void {
//        
//
//        print("pressionado")
//
//    }
    
//    @IBAction func favoritarPacoteViagem(_ sender: UIButton) {
//
//        sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//
//
//
//
//    }
    
    
    
}
