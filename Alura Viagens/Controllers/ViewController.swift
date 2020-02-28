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
    
    let listaViagens:[Viagem] = ViagemDao().retornaTodasAsViagens()
    var listaDeViagens: [Viagem] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraViews()
        getListaViagens()
        configTableView()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getListaViagens()
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
                print("Titulo de Viagem: \(item.titulo)")
                self.listaDeViagens.append(item)
            }
            self.tabelaViagens.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeViagens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let viagemAtual = listaDeViagens[indexPath.row]
        cell.configuraCelula(viagemAtual)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 175 : 260
    }
}
