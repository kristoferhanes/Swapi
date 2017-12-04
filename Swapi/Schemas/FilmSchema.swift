//
//  FilmSchema.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-11.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.URL
import struct Prelude.AnyResource

public struct FilmSchema: Decodable {
  var title: String
  var episode_id: Int
  var opening_crawl: String
  var director: String
  var producer: String
  var release_date: Date
  var species: [Id<Species>]
  var starships: [Id<Starship>]
  var vehicles: [Id<Vehicle>]
  var characters: [Id<Person>]
  var planets: [Id<Planet>]
  var url: Id<Film>
  var created: Date
  var edited: Date
}

extension FilmSchema {
  
  static func resource(for id: Id<Film>) -> AnyResource<FilmSchema> {
    return AnyResource(url: URL(string: "https://swapi.co/api/films/\(id.id)/")!)
  }
}

extension Film {
  init(schema: FilmSchema) {
    self.init(
      title: schema.title,
      episodeId: schema.episode_id,
      openingCrawl: schema.opening_crawl,
      director: schema.director,
      producer: schema.director,
      releaseDate: schema.release_date,
      species: schema.species,
      starships: schema.starships,
      vehicles: schema.vehicles,
      characters: schema.characters,
      planets: schema.planets,
      id: schema.url,
      created: schema.created,
      edited: schema.edited
    )
  }
}
