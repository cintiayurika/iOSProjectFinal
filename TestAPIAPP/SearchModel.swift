//
//  SearchModel.swift
//  TestAPIAPP
//
//  Created by Inderbir Ghuman on 2018-04-24.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import Foundation

struct SearchModel: Codable {

    //let type: String
    //let score: Double
    let movie: Movie?
    let show: Show?
    var image: URL?

    struct Movie: Codable{
        let title: String
        let year: Int
        let ids: searchID
    }

    struct Show: Codable{
        let title: String
        let year: Int
        let ids: searchID
    }

    enum CodingKeys: String, CodingKey {
        case movie
        case show
        case image
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //type = try container.decode(String.self, forKey: CodingKeys.type)
        //score = try container.decode(Double.self, forKey: CodingKeys.score)
        movie = try container.decodeIfPresent(Movie.self, forKey: CodingKeys.movie)
        show = try container.decodeIfPresent(Show.self, forKey: CodingKeys.show)
        image = try container.decodeIfPresent(URL.self, forKey: CodingKeys.image)
    }
}
public struct searchID: Codable {
    public let trakt: Int
    public let slug: String
    public let imdb: String?
    public let tmdb: Int?

    enum CodingKeys: String, CodingKey {
        case trakt
        case slug
        case imdb
        case tmdb
    }

}
