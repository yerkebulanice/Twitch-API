//
//  TWUser.swift
//  Twitch
//
//  Created by Øyvind Hauge on 29/07/2020.
//  Copyright © 2020 Øyvind Hauge. All rights reserved.
//

import Foundation

public struct TWUser: Codable {
    
    /// User’s ID.
    public var id: String
    
    /// User’s login name.
    public var login: String
    
    /// User’s display name.
    public var displayName: String
    
    /// User’s type: "staff", "admin", "global_mod", or "".
    public var type: TWUserType
    
    /// User’s broadcaster type: "partner", "affiliate", or "".
    public var broadcasterType: TWBroadcasterType
    
    /// User’s channel description.
    public var description: String
    
    /// URL of the user’s profile image.
    public var profileImageUrl: String
    
    /// URL of the user’s offline image.
    public var offlineImageUrl: String
        
    /// Total number of views of the user’s channel.
    public var viewCount: Int64
    
    /// User’s email address. Returned if the request includes the user:read:email scope.
    public var email: String?
}

/// Type of user
public enum TWUserType: String, Codable {
    case staff = "straff", admin = "admin", globalMod = "global_mod", user = ""
}

/// Type of broadcaster
public enum TWBroadcasterType: String, Codable {
    case partner = "partner", affiliate = "affiliate", regular = ""
}
