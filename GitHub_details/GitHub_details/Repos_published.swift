//
//  Repo.swift
//  GitHub_details
//
//  Created by Alessandro Marconi on 07/10/2018.
//  Copyright © 2018 JaskierLTD. All rights reserved.
//

import Foundation

struct ReposValue : Codable {
    
    private enum CodingKeys : String, CodingKey {
        case repos = "public_repos"
        case login = "login"
    }
    var repos : Int16
    var login : String
}

