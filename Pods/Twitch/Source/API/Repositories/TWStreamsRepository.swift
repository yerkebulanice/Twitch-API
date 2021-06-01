//
//  TWStreamsRepository.swift
//  Twitch
//
//  Created by Øyvind Hauge on 30/07/2020.
//  Copyright © 2020 Øyvind Hauge. All rights reserved.
//

import Foundation

final class TWStreamsRepository: TWStreamsAPI {
    let session: URLSession = URLSession.shared

    func getStreamKey(broadcasterId: String, result: @escaping TWContainerBlock<[TWStreamKey]>) {
        let request = URLRequestBuilder.buildSecureAPIRequest(for: TWStreamKeyRequest(broadcasterId))
        session.dataTask(with: request, decodable: [TWStreamKey].self, result: result).resume()
    }
    
    func getStreams(after: String?, before: String?, first: Int?,
                    gameId: String?, language: String?, userId: String?,
                    userLogin: String?, result: @escaping TWContainerBlock<[TWStream]>) {
        let request = URLRequestBuilder.buildSecureAPIRequest(for: TWStreamsRequest(after, before,
                                                                  first, gameId,
                                                                  language, userId,
                                                                  userLogin))
        session.dataTask(with: request, decodable: [TWStream].self, result: result).resume()
    }
    
    func getStreamTags(broadcasterId: String, result: @escaping TWContainerBlock<[TWStreamTag]>) {
        let request = URLRequestBuilder.buildSecureAPIRequest(for: TWStreamTagsRequest(broadcasterId))
        session.dataTask(with: request, decodable: [TWStreamTag].self, result: result).resume()
    }
    
    func replaceStreamTags(broadcasterId: String, tagIds: [String]?, result: @escaping TWNoContentBlock) {
        let request = URLRequestBuilder.buildSecureAPIRequest(for: TWReplaceStreamTagsRequest(broadcasterId, tagIds))
        session.dataTask(with: request, result: result).resume()
    }
    
    func createStreamMarker(userId: String, description: String?, result: @escaping TWContainerBlock<TWStreamMarker>) {
        let request = URLRequestBuilder.buildSecureAPIRequest(for: TWCreateStreamMarker(userId, description))
        session.dataTask(with: request, decodable: TWStreamMarker.self, result: result).resume()
    }
    
    func getChannelInfo(broadcatserId: String, result: @escaping TWContainerBlock<[TWChannelInfo]>) {
        let request = URLRequestBuilder.buildSecureAPIRequest(for: TWChannelInfoRequest(broadcatserId))
        session.dataTask(with: request, decodable: [TWChannelInfo].self, result: result).resume()
    }
    
    func modifyChannelInfo(broadcasterId: String, gameId: String?, broadcasterLanguage: String?, title: String?, result: @escaping TWNoContentBlock) {
        let request = URLRequestBuilder.buildSecureAPIRequest(for: TWModifyChannelInfoRequest(broadcasterId,
                                                                                              gameId,
                                                                                              broadcasterLanguage,
                                                                                              title))
        session.dataTask(with: request, result: result).resume()
    }
    
    func getStreamMarkers(userId: String?, videoId: String?, after: String?, before: String?, first: String?, result: @escaping TWContainerBlock<[TWStreamMarkerContainer]>) {
        // TODO:
    }
}
