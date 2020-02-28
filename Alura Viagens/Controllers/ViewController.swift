//
//  ViewController.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tabelaViagens: UITableView!
    @IBOutlet weak var viewHoteis: UIView!
    @IBOutlet weak var viewPacotes: UIView!
    
    // MARK: - Atributos
    
    var listaDeViagens: [Viagem] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraViews()
        getListaViagens()
        configTableView()
    }
    
    // MARK: - Métodos
    
    func configuraViews() {
        viewPacotes.layer.cornerRadius = 10
        viewHoteis.layer.cornerRadius = 10
    }
    
    func configTableView () {
        tabelaViagens.delegate = self
        tabelaViagens.dataSource = self
    }
    
    func getListaViagens() {
        
        ViagensAPI().recuperaListaDeViagensAPI(completion: { (listaViagens) in
            for item in listaViagens {
                print("Titulo de Viagem: \(item.titulo) Localizacao: \(item.localizacao)")
                self.listaDeViagens.append(item)
            }
            self.tabelaViagens.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @objc func mostrarMapa(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let cell = gestureRecognizer.view as! UITableViewCell
            guard let indexPath = tabelaViagens.indexPath(for: cell) else { return }
            let viagem = listaDeViagens[indexPath.row]
            print("Viagem Selecionada no UILongPressRecognizer: \(viagem.titulo)")
            goToMap(viagem)
        }
    }
    
    func goToMap(_ viagemDados:Viagem) {
        let mapViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapViewController") as! MapViewController
        mapViewController.viagemDados = viagemDados
        navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeViagens.count
    }
    
    
//    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
//    celula.addGestureRecognizer(longPress)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let viagemAtual = listaDeViagens[indexPath.row]
        cell.configuraCelula(viagemAtual)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarMapa))
        cell.addGestureRecognizer(longPress)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 175 : 260
    }
}
