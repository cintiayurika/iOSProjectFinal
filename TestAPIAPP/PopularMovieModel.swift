//
//  PopularMovieModel.swift
//  TestAPIAPP
//
//  Created by Simizu Yorinori Cintia Y. on 4/22/18.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import Foundation

//typealias PopularMovieModel = [PopularMovieModelElement]

struct PopularMovieModel: Codable {
    let title: String
    let year: Int
    let ids: IDS
}

struct IDS: Codable {
    let trakt: Int
    let slug, imdb: String
    let tmdb: Int
}

