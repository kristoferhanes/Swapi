//
//  Person.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-07.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.URLRequest
import struct Foundation.URL
import struct Prelude.Async

public protocol Person {
  init(
    name: String,
    birthYear: String,
    eyeColor: String,
    gender: String,
    hairColor: String,
    height: String,
    mass: String,
    skinColor: String,
    homeworld: Id<Planet>,
    films: [Id<Film>],
    species: [Id<Species>],
    starships: [Id<Starship>],
    vehicles: [Id<Vehicle>],
    id: Id<Person>,
    created: Date,
    edited: Date
  )
}

public extension Person {
  
  static func loadFromNetwork(id: Id<Person>) -> Async<Self> {
    return PersonSchema.resource(for: id).map(Self.init).loadFromNetwork()
  }
    
  typealias Fetcher = Swapi.Fetcher<Self, PersonSchema>
  
  static var fetcher: Fetcher {
    return Fetcher(url: Self.urlForAll, elementFromSchema: { Self(schema: $0) })
  }
  
}

private extension Person {
  
  static var urlForAll: URL {
    return URL(string: "https://swapi.co/api/people/")!
  }
  
}
