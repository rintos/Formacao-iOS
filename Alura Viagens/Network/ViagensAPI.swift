//
//  ViagensAPI.swift
//  Alura Viagens
//
//  Created by Victor Soares de Almeida on 27/02/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import Foundation
import Alamofire

class ViagensAPI {
    
    let url = "https://backend-formacao.herokuapp.com/viagens"
    
    func recuperaListaDeViagensAPI(completion:@escaping(_ listaViagens: [Viagem]) -> Void, completionError:@escaping(_ error: Error) -> Void) {
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            if response.error != nil {
                if let erro = response.error {
                    print(response.error?.localizedDescription as Any)
                    completionError(erro)
                }
            }
            
            if let jsonResult = response.result.value as? [Dictionary<String, Any>]{
                let listaViagens = Viagem().desserializaJson(viagemDict: jsonResult)
                completion(listaViagens)
            }

        }
    }
    
}
