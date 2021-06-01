//
//  CoreDataManager.swift
//  Endterm App
//
//  Created by Еркебулан on 30.05.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Endterm_App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private init() {}

    func save() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    func allGames() -> [TopGames.GameInfo] {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        let games = try? context.fetch(request)
        return games?.map({ TopGames.GameInfo(game: $0) }) ?? []
    }
    
    func add(_ game: TopGames.GameInfo) {
            let context = persistentContainer.viewContext
            context.perform {
                let newGame = GameEntity(context: context)
                newGame.id = Int64(game.game._id)
                newGame.name =  game.game.name
                newGame.channels = Int64(game.channels ?? 0)
                newGame.viewers = Int64(game.viewers ?? 0)
                newGame.large = game.game.box?.large
            }
            save()
        }

}
