//
//  TrendinModel.swift
//  TestAPIAPP
//
//  Created by Simizu Yorinori Cintia Y. on 4/21/18.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import Foundation

struct  TrendingModel: Codable {
    let watchers: Int
    let movie: Movie?
    let show: Show?
    var image: URL?
    
    struct Movie: Codable{
        let title: String
        let year: Int
        let ids: ID
    }
    
    struct Show: Codable{
        let title: String
        let year: Int
        let ids: ID
    }
    
    enum CodingKeys: String, CodingKey {
        case watchers
        case movie
        case show
        case image
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        watchers = try container.decode(Int.self, forKey: CodingKeys.watchers)
        movie = try container.decodeIfPresent(Movie.self, forKey: CodingKeys.movie)
        show = try container.decodeIfPresent(Show.self, forKey: CodingKeys.show)
        image = try container.decodeIfPresent(URL.self, forKey: CodingKeys.image)
    }
}
public struct ID: Codable {
    public let trakt: Int
    public let slug: String
    public let tvdb: Int?
    public let imdb: String?
    public let tmdb: Int?
    public let tvRage: Int?
    
    enum CodingKeys: String, CodingKey {
        case trakt
        case slug
        case tvdb
        case imdb
        case tmdb
        case tvRage = "tvrage"
    }
    
}
