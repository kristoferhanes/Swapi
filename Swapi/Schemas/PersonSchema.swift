//
//  PersonSchema.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-10.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.URL
import struct Prelude.AnyResource

public struct PersonSchema: Decodable {
  var name: String
  var birth_year: String
  var eye_color: String
  var gender: String
  var hair_color: String
  var height: String
  var mass: String
  var skin_color: String
  var homeworld: Id<Planet>
  var films: [Id<Film>]
  var species: [Id<Species>]
  var starships: [Id<Starship>]
  var vehicles: [Id<Vehicle>]
  var url: Id<Person>
  var created: Date
  var edited: Date
}

extension PersonSchema {
  
  static func resource(for id: Id<Person>) -> AnyResource<PersonSchema> {
    return AnyResource(url: URL(string: "https://swapi.co/api/people/\(id.id)/")!)
  }
    
}

extension Person {
  init(schema: PersonSchema) {
    self.init(
      name: schema.name,
      birthYear: schema.birth_year,
      eyeColor: schema.eye_color,
      gender: schema.gender,
      hairColor: schema.hair_color,
      height: schema.height,
      mass: schema.mass,
      skinColor: schema.skin_color,
      homeworld: schema.homeworld,
      films: schema.films,
      species: schema.species,
      starships: schema.starships,
      vehicles: schema.vehicles,
      id: schema.url,
      created: schema.created,
      edited: schema.edited
    )
  }
}
