//
//  Vehicle.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-07.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.URLRequest
import struct Foundation.URL
import struct Prelude.Async

public protocol Vehicle {
  init(
    name: String,
    model: String,
    vehicleClass: String,
    manufacturer: String,
    length: String,
    costInCredits: String,
    crew: String,
    passengers: String,
    maxAtmoshperingSpeed: String,
    cargoCapacity: String,
    consumables: String,
    films: [Id<Film>],
    pilots: [Id<Person>],
    id: Id<Vehicle>,
    created: Date,
    edited: Date
  )
}

public extension Vehicle {
  
  static func loadFromNetwork(id: Id<Vehicle>) -> Async<Self> {
    return VehicleSchema.resource(for: id).map(Self.init).loadFromNetwork()
  }
  
  typealias Fetcher = Swapi.Fetcher<Self, VehicleSchema>
  
  static var fetcher: Fetcher {
    return Fetcher(url: Self.urlForAll, elementFromSchema: { Self(schema: $0) })
  }
  
}

private extension Vehicle {
  
  static var urlForAll: URL {
    return URL(string: "https://swapi.co/api/people/")!
  }
  
}
