//
//  Webservice+EndPoints.swift
//  StarterProj
//
//  Created by Gurdeep on 06/03/17.
//  Copyright © 2017 Gurdeep. All rights reserved.
//

import Foundation

let BaseURL = "https://maan.ifoam.bio"        // Production URL
//let BaseURL =  "https://maanapp.ifoam.bio"      // Development URL

extension WebServices {

    enum EndPoint {
        
        static var signIn: String                   { return BaseURL+"/rest/mentions/1/network" } //SignIN
        static var allSpaces: String                { return BaseURL+"/rest/api/space/" }
        static var homePage: String                 { return BaseURL+"/rest/api/content/" }
        static var homeSearch: String               { return BaseURL+"/rest/api/content/search/" }
        static var likes: String                    { return BaseURL+"/rest/likes/1.0/content/" }
        static var homePageExpand: String           { return BaseURL+"/rest/api/content/expand?=history.lastUpdated,children.comment" }
        static var recentUpdate: String             { return BaseURL+"/expand?=history.lastUpdated" }
        static var childPageExpand: String          { return BaseURL+"/expand?=children.page.history.lastUpdated,children.page.children.comment,children.attachment.links.body.storage" }
        static var childAttachment: String          { return BaseURL+"/child/attachment/" }
        static var userData: String                 { return BaseURL+"/rest/communardo/upp/1.0/profileData/" }
        static var userProfile: String              { return BaseURL+"/rest/mobile/1.0/profile/" }
        static var userNotification: String         { return BaseURL+"/rest/mywork/1/notification/" }
        static var putUserFollow: String            { return BaseURL+"/rest/likes/1.0/user/" }
        static var watchPage: String                { return BaseURL+"/rest/prototype/1/content/" }
        static var followUser: String               { return BaseURL+"/rest/mentions/1/network" }
        static var pushNotification: String         { return "https://fcm.googleapis.com/fcm/send" }
    }
}
