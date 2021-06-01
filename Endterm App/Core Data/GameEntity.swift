//
//  GameEntity.swift
//  Endterm App
//
//  Created by Еркебулан on 30.05.2021.
//

import Foundation
import CoreData

class GameEntity: NSManagedObject {
    static func findGame(with id: Int, context: NSManagedObjectContext) -> GameEntity? {
        let requestResult: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        requestResult.predicate = NSPredicate(format: "id == %d", id)
        do {
            let games = try context.fetch(requestResult)
            if games.count > 0 {
                assert(games.count == 1, "Duplicate found!!!")
                return games[0]
            }
            
        } catch {
            print(error)
        }
        return nil
    }
}
