//
//  Film.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-07.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.URLRequest
import struct Foundation.URL
import struct Prelude.Async

public protocol Film {
  init(
    title: String,
    episodeId: Int,
    openingCrawl: String,
    director: String,
    producer: String,
    releaseDate: Date,
    species: [Id<Species>],
    starships: [Id<Starship>],
    vehicles: [Id<Vehicle>],
    characters: [Id<Person>],
    planets: [Id<Planet>],
    id: Id<Film>,
    created: Date,
    edited: Date
  )
}

public extension Film {
  
  static func loadFromNetwork(id: Id<Film>) -> Async<Self> {
    return FilmSchema.resource(for: id).map(Self.init).loadFromNetwork()
  }
  
  typealias Fetcher = Swapi.Fetcher<Self, FilmSchema>
  
  static var fetcher: Fetcher {
    return Fetcher(url: Self.urlForAll, elementFromSchema: { Self(schema: $0) })
  }
}

private extension Film {
  
  static var urlForAll: URL {
    return URL(string: "https://swapi.co/api/films/")!
  }
  
}
