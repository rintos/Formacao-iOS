//
//  MapViewController.swift
//  Alura Viagens
//
//  Created by Victor Soares de Almeida on 28/02/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    
    lazy var local = Localizacao()
    lazy var gerenciadorDoLocal = CLLocationManager()
    
    var viagemDados: Viagem?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = local
        gerenciadorDoLocal.delegate = self
        
      //  print("Local selecionado\(localizacao)")
        if let viagem = viagemDados {
            print("Local:\(viagem.localizacao)")
        }

        // Do any additional setup after loading the view.
        localizarAluno()
    }
    
    func localizarAluno() {
        if let viagem = viagemDados {
            Localizacao().converteEnderecoEmCoordenadas(endereco: viagem.localizacao) { (localEncontrado) in
                let pino = Localizacao().configutaPino(titulo: viagem.titulo, localizacao: localEncontrado, cor: nil, icone: nil)
                self.mapa.addAnnotation(pino)
                self.mapa.showAnnotations(self.mapa.annotations, animated: true)
            }
        }
    }
    

}
