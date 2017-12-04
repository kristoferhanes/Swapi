//
//  Species.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-07.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.URLRequest
import struct Foundation.URL
import struct Prelude.Async

public protocol Species {
  init(
    name: String,
    classification: String,
    designation: String,
    averageHeight: String,
    averageLifespan: String,
    eyeColors: String,
    hairColors: String,
    skinColors: String,
    language: String,
    homeword: Id<Planet>,
    people: [Id<Person>],
    films: [Id<Film>],
    id: Id<Species>,
    created: Date,
    edited: Date
  )
}

public extension Species {
  
  static func loadFromNetwork(id: Id<Species>) -> Async<Self> {
    return SpeciesSchema.resource(for: id).map(Self.init).loadFromNetwork()
  }
  
  typealias Fetcher = Swapi.Fetcher<Self, SpeciesSchema>
  
  static var fetcher: Fetcher {
    return Fetcher(url: Self.urlForAll, elementFromSchema: { Self(schema: $0) })
  }
  
}

private extension Species {
  
  static var urlForAll: URL {
    return URL(string: "https://swapi.co/api/people/")!
  }
  
}
