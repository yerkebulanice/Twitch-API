//
//  TopGames.swift
//  Endterm App
//
//  Created by Еркебулан on 30.05.2021.
//

import Foundation

struct TopGames: Decodable {
    let top: [GameInfo]
    
    struct GameInfo: Decodable {
        let game: GameDesc
        let viewers: Int?
        let channels: Int?
        
        init(game: GameEntity) {
            self.channels = Int(game.channels)
            self.viewers = Int(game.viewers)
            self.game = GameDesc(name: game.name ?? "0", _id: Int(game.id), box: GameDesc.BoxImg(large: game.large ?? "0"))
        }

        
        struct GameDesc: Decodable {
            let name: String?
            let _id: Int
            let box: BoxImg?
            
//            enum CodingKeys: String, CodingKey {
//                case id = "_id"
//            }
            
            struct BoxImg: Decodable {
                let large: String
            }
            
        }
    }
}
