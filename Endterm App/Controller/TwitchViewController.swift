//
//  TwitchViewController.swift
//  Endterm App
//
//  Created by Еркебулан on 29.05.2021.
//

import UIKit
import Alamofire
//import Twitch

class TwitchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
//    private let TopGameURL: String = "https://api.twitch.tv/helix/games/top"
    private let TopGameURL: String = "https://api.twitch.tv/kraken/games/top?client_id=sz0mdftocwxsnx1zka2opbfh5vuy47&api_version=5&limit=100"
    private var pageNumber: Int = 1
    private var games: [TopGames.GameInfo] = [TopGames.GameInfo]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TwitchCell.identifier, bundle: Bundle(for: TwitchCell.self)), forCellReuseIdentifier: TwitchCell.identifier)
        getTopGames()
    }
    
}

extension TwitchViewController {
    private func getTopGames(_ page: Int? = nil) {
        var params: [String: Any] = [:]

        if let page = page {
            params["page"] = page
        }
//        let headers: HTTPHeaders = ["Authorization": "Bearer iqhm5oya0n687wvu7kygfotnnd2v3w", "Client-Id": "sz0mdftocwxsnx1zka2opbfh5vuy47"]
        AF.request(TopGameURL, method: .get, parameters: params).responseJSON {
            (response) in
            switch response.result{
            case .success:
                if let data = response.data {
                    do{
                        let gamesJSON = try JSONDecoder().decode(TopGames.self, from: data)
                            self.games += gamesJSON.top
//                        for entity in gamesJSON.top {
//                            CoreDataManager.add(entity)
//                        }
                    } catch let errorJSON {
                        print(errorJSON)
                    }
                }
            case .failure:
                print("Failed")
            }
        }
    }
}

extension TwitchViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 10 && currentOffset > 200 {
            pageNumber += 1
            getTopGames(pageNumber)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
}

extension TwitchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TwitchCell.identifier, for: indexPath) as! TwitchCell
        cell.game = games[indexPath.row]
        return cell
    }
}
