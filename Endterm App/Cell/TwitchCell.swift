//
//  TwitchCell.swift
//  Endterm App
//
//  Created by Еркебулан on 29.05.2021.
//

import UIKit
import Kingfisher
class TwitchCell: UITableViewCell {
    public static let identifier: String = "TwitchCell"
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var nameOfGame: UILabel!
    @IBOutlet private weak var numberOfChannels: UILabel!
    @IBOutlet private weak var numberOfSpectators: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.layer.cornerRadius = 20
        coverImageView.layer.masksToBounds = true
        selectionStyle = .none
    }
    
    public var game: TopGames.GameInfo? {
        didSet {
            if let game = game {
                let imagee = URL(string: String(game.game.box?.large ?? "0" ))
                coverImageView.kf.setImage(with: imagee)
                nameOfGame.text = String(game.game.name ?? "0" )
                numberOfChannels.text = "channels: \(game.channels ?? 0 )"
                numberOfSpectators.text = "viewers: \(game.viewers ?? 0 )"
            }
        }
    }
}
