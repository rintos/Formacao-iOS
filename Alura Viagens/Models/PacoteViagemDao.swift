//
//  PacoteViagemDao.swift
//  Alura Viagens
//
//  Created by Alura on 21/06/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import CoreData

class PacoteViagemDao: NSObject {
    
    var pacoteViagemFavotiro:[PacotesDeViagens] = []
    
    var contexto: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    var gerenciadorDeResultados: NSFetchedResultsController<PacotesDeViagens>?
    
    
    func salvarPacoteViagem(_ pacoteViagem: PacoteViagem) {
        
        var pacoteViagemObject: NSManagedObject?
//        let uuid = UUID().uuidString
//        let idCoreData = NSUUID(uuidString: uuid)
        let entidade = NSEntityDescription.entity(forEntityName: "PacotesDeViagens", in: contexto)
     
        pacoteViagemObject = NSManagedObject(entity: entidade!, insertInto: contexto)
        
        let id = pacoteViagem.id
        let titulo = pacoteViagem.titulo
        let quantidadeDeDias = pacoteViagem.quantidadeDeDias
        let preco = pacoteViagem.preco
        let imageUrl = pacoteViagem.imageUrl
        let localizacao = pacoteViagem.localizacao
        let nomeDoHotel = pacoteViagem.nomeDoHotel
        let descricao = pacoteViagem.descricao
        let dataViagem = pacoteViagem.dataViagem
        
        
        pacoteViagemObject?.setValue(id, forKey: "id")
        pacoteViagemObject?.setValue(titulo, forKey: "titulo")
        pacoteViagemObject?.setValue(quantidadeDeDias, forKey: "quantidadeDeDias")
        pacoteViagemObject?.setValue(preco, forKey: "preco")
        pacoteViagemObject?.setValue(imageUrl, forKey: "imageUrl")
        pacoteViagemObject?.setValue(localizacao, forKey: "localizacao")
        pacoteViagemObject?.setValue(nomeDoHotel, forKey: "nomeDoHotel")
        pacoteViagemObject?.setValue(descricao, forKey: "descricao")
        pacoteViagemObject?.setValue(dataViagem, forKey: "dataViagem")
        
        atualizaContexto()
        print("Pacote foi salvo com sucesso")

    }
    
    func recuperaPacotesFavoritos() -> [PacotesDeViagens] {
        
        let procuraPacote:NSFetchRequest<PacotesDeViagens> = PacotesDeViagens.fetchRequest()
        let organizaPacote = NSSortDescriptor(key: "titulo", ascending: true)
        procuraPacote.sortDescriptors = [organizaPacote]
        
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: procuraPacote, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        
        gerenciadorDeResultados?.delegate = self as? NSFetchedResultsControllerDelegate
        
        do {
            try gerenciadorDeResultados?.performFetch()
        } catch {
            print("gerou erro\(error.localizedDescription)")
        }
        
        guard let listaPacotesViagens = gerenciadorDeResultados?.fetchedObjects else { return [] }
        
        return listaPacotesViagens
    }

    func atualizaContexto () {
        do {
            try contexto.save()
        } catch {
            print(error.localizedDescription)
            print("Erro na tentativa de salvar")
        }
    }
    
    func deletaPacoteViagem(_ id: Int) {
        
        let idCoreData = Int32(id)
        let listaFavoritos = recuperaPacotesFavoritos()
        
        for favorito in listaFavoritos {
            if favorito.id == idCoreData {
                contexto.delete(favorito)
            }
        }
        atualizaContexto()
        print("Pacote foi Deletado")

    }
    
}
