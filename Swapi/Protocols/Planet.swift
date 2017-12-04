//
//  Planet.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-07.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.URLRequest
import struct Foundation.URL
import struct Prelude.Async

public protocol Planet {
  init(
    name: String,
    diameter: String,
    rotationPeriod: String,
    orbitalPeriod: String,
    gravity: String,
    population: String,
    climate: String,
    terrain: String,
    surfaceWater: String,
    residents: [Id<Person>],
    films: [Id<Film>],
    id: Id<Planet>,
    created: Date,
    edited: Date
  )
}

public extension Planet {
  
  static func loadFromNetwork(id: Id<Planet>) -> Async<Self> {
    return PlanetSchema.resource(for: id).map(Self.init).loadFromNetwork()
  }
  
  typealias Fetcher = Swapi.Fetcher<Self, PlanetSchema>
  
  static var fetcher: Fetcher {
    return Fetcher(url: Self.urlForAll, elementFromSchema: { Self(schema: $0) })
  }
  
}

private extension Planet {
  
  static var urlForAll: URL {
    return URL(string: "https://swapi.co/api/people/")!
  }
  
}
