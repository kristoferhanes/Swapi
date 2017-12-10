//
//  PlanetSchema.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-11.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.URL
import struct Prelude.Resource

public struct PlanetSchema: Decodable {
  var name: String
  var diameter: String
  var rotation_period: String
  var orbital_period: String
  var gravity: String
  var population: String
  var climate: String
  var terrain: String
  var surface_water: String
  var residents: [Id<Person>]
  var films: [Id<Film>]
  var url: Id<Planet>
  var created: Date
  var edited: Date
}

extension PlanetSchema {
  
  static func resource(for id: Id<Planet>) -> Resource<PlanetSchema> {
    return Resource(url: URL(string: "https://swapi.co/api/planets/\(id.id)/")!)
  }
  
}

extension Planet {
  init(schema: PlanetSchema) {
    self.init(
      name: schema.name,
      diameter: schema.diameter,
      rotationPeriod: schema.diameter,
      orbitalPeriod: schema.orbital_period,
      gravity: schema.gravity,
      population: schema.population,
      climate: schema.climate,
      terrain: schema.terrain,
      surfaceWater: schema.surface_water,
      residents: schema.residents,
      films: schema.films,
      id: schema.url,
      created: schema.created,
      edited: schema.edited
    )
  }
}
