//
//  StarshipSchema.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-11.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.URL
import struct Prelude.Resource

public struct StarshipSchema: Decodable {
  var name: String
  var model: String
  var starship_class: String
  var manufacturer: String
  var cost_in_credits: String
  var length: String
  var crew: String
  var passengers: String
  var max_atmosphering_speed: String
  var hyperdrive_rating: String
  var MGLT: String
  var cargo_capacity: String
  var consumables: String
  var films: [Id<Film>]
  var pilots: [Id<Person>]
  var url: Id<Starship>
  var created: Date
  var edited: Date
}

extension StarshipSchema {
  
  static func resource(for id: Id<Starship>) -> Resource<StarshipSchema> {
    return Resource(url: URL(string: "https://swapi.co/api/starships/\(id.id)/")!)
  }
  
}

extension Starship {
  init(schema: StarshipSchema) {
    self.init(
      name: schema.name,
      model: schema.model,
      starshipClass: schema.starship_class,
      manufacturer: schema.manufacturer,
      costInCredits: schema.cost_in_credits,
      length: schema.length,
      crew: schema.crew,
      passengers: schema.passengers,
      maxAtmospheringSpeed: schema.max_atmosphering_speed,
      hyperdriveRating: schema.hyperdrive_rating,
      MGLT: schema.MGLT,
      cargoCapacity: schema.consumables,
      consumables: schema.consumables,
      films: schema.films,
      pilots: schema.pilots,
      id: schema.url,
      created: schema.created,
      edited: schema.edited
    )
  }
}
