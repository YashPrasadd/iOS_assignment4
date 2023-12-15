//
//  MovieModel.swift
//  Movie Searcher
//
//  Created by user235625 on 12/13/23.
//

import Foundation

struct Movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String
    let Plot: String?  // Make Plot optional

    private enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, _Type = "Type", Poster, Plot
    }
}


struct MovieResult: Codable {
    let Search: [Movie]
}

class AppModel{
    var UserList:[User] = [User]()
}

class User {
    var name: String = ""
    var email: String = ""
    
    init(nameStr:String, emailStr:String) {
        self.name = nameStr
        self.email = emailStr
    }
}



