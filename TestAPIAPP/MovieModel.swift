//
//  MovieModel.swift
//  TestAPIAPP
//
//  Created by Srinivasan Rao Sadanand on 4/22/18.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//
import Foundation

public struct MoviesModel: Codable {
    //        // Extended: Min
    public let title: String
    public let year: Int?
    public let ids: ID
    
    // Extended: Full
    public let tagline: String?
    public let overview: String?
    public let released: Date?
    public let runtime: Int?
    public let country: String?
    public let trailer: URL?
    public let homepage: URL?
    public let rating: Double?
    public let votes: Int?
    public let updatedAt: Date?
    public let language: String?
    public let genres: [String]?
    public let certification: String?
    public let image: URL?
    
    enum CodingKeys: String, CodingKey {
        case title
        case year
        case ids
        
        case tagline
        case overview
        case released
        case runtime
        case trailer
        case homepage
        case rating
        case votes
        case updatedAt = "updated_at"
        case language
        case genres
        case certification
        case image
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: CodingKeys.title)
        year = try container.decodeIfPresent(Int.self, forKey: CodingKeys.year)
        ids = try container.decode(ID.self, forKey: CodingKeys.ids)
        
        tagline = try container.decodeIfPresent(String.self, forKey: CodingKeys.tagline)
        overview = try container.decodeIfPresent(String.self, forKey: CodingKeys.overview)
        country = try container.decodeIfPresent(String.self, forKey: CodingKeys.overview)
        released = try container.decodeIfPresent(Date.self, forKey: CodingKeys.released)
        runtime = try container.decodeIfPresent(Int.self, forKey: CodingKeys.runtime)
        certification = try container.decodeIfPresent(String.self, forKey: .certification)
        trailer = try? container.decode(URL.self, forKey: .trailer)
        homepage = try? container.decode(URL.self, forKey: .homepage)
        rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        votes = try container.decodeIfPresent(Int.self, forKey: .votes)
        updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
        language = try container.decodeIfPresent(String.self, forKey: .language)
        genres = try container.decodeIfPresent([String].self, forKey: .genres)
        image = try? container.decode(URL.self, forKey: .image)
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
    
}
