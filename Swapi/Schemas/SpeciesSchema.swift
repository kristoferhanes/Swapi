//
//  SpeciesSchema.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-11.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.URL
import struct Prelude.Resource

public struct SpeciesSchema: Decodable {
  var name: String
  var classification: String
  var designation: String
  var average_height: String
  var average_lifespan: String
  var eye_colors: String
  var hair_colors: String
  var skin_colors: String
  var language: String
  var homeworld: Id<Planet>
  var people: [Id<Person>]
  var films: [Id<Film>]
  var url: Id<Species>
  var created: Date
  var edited: Date
}

extension SpeciesSchema {
  
  static func resource(for id: Id<Species>) -> Resource<SpeciesSchema> {
    return Resource(url: URL(string: "https://swapi.co/api/species/\(id.id)/")!)
  }
  
}

extension Species {
  init(schema: SpeciesSchema) {
    self.init(
      name: schema.name,
      classification: schema.classification,
      designation: schema.designation,
      averageHeight: schema.average_height,
      averageLifespan: schema.average_lifespan,
      eyeColors: schema.eye_colors,
      hairColors: schema.hair_colors,
      skinColors: schema.skin_colors,
      language: schema.language,
      homeword: schema.homeworld,
      people: schema.people,
      films: schema.films,
      id: schema.url,
      created: schema.created,
      edited: schema.edited
    )
  }
}
