//
//  PacotesAPI.swift
//  Alura Viagens
//
//  Created by Victor Soares de Almeida on 27/02/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import Alamofire

class PacotesAPI {

    let url = "https://backend-formacao.herokuapp.com/pacotes"
    
    func recuperaListaDePacotesAPI(completion:@escaping(_ listaPacotes: [PacoteViagem]) -> Void, completionError:@escaping(_ erro: Error) -> Void) {
        
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            if response.error != nil {
                if let erro = response.error {
                    completionError(erro)
                }
            }
            
            if let jsonResult = response.result.value as? [Dictionary<String, Any>] {
              let listaDePacotes = PacoteViagem().desserializaPacoteViagem(pacoteDict: jsonResult)
                completion(listaDePacotes)
            }
        }
    }
}
