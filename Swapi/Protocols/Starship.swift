//
//  Starship.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-07.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.URLRequest
import struct Foundation.URL
import struct Prelude.Async

public protocol Starship {
  init(
    name: String,
    model: String,
    starshipClass: String,
    manufacturer: String,
    costInCredits: String,
    length: String,
    crew: String,
    passengers: String,
    maxAtmospheringSpeed: String,
    hyperdriveRating: String,
    MGLT: String,
    cargoCapacity: String,
    consumables: String,
    films: [Id<Film>],
    pilots: [Id<Person>],
    id: Id<Starship>,
    created: Date,
    edited: Date
  )
}

public extension Starship {
  
  static func loadFromNetwork(id: Id<Starship>) -> Async<Self> {
    return StarshipSchema.resource(for: id).map(Self.init).loadFromNetwork()
  }
  
  typealias Fetcher = Swapi.Fetcher<Self, StarshipSchema>
  
  static var fetcher: Fetcher {
    return Fetcher(url: Self.urlForAll, elementFromSchema: { Self(schema: $0) })
  }
  
}

private extension Starship {
  
  static var urlForAll: URL {
    return URL(string: "https://swapi.co/api/people/")!
  }
  
}
