//
//  VehicleSchema.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-11.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct Foundation.Date
import struct Foundation.URL
import struct Prelude.AnyResource

public struct VehicleSchema: Decodable {
  var name: String
  var model: String
  var vehicle_class: String
  var manufacturer: String
  var length: String
  var cost_in_credits: String
  var crew: String
  var passengers: String
  var max_atmosphering_speed: String
  var cargo_capacity: String
  var consumables: String
  var films: [Id<Film>]
  var pilots: [Id<Person>]
  var url: Id<Vehicle>
  var created: Date
  var edited: Date
}

extension VehicleSchema {
  
  static func resource(for id: Id<Vehicle>) -> AnyResource<VehicleSchema> {
    return AnyResource(url: URL(string: "https://swapi.co/api/vehicles/\(id.id)/")!)
  }
  
}

extension Vehicle {
  init(schema: VehicleSchema) {
    self.init(
      name: schema.name,
      model: schema.model,
      vehicleClass: schema.vehicle_class,
      manufacturer: schema.manufacturer,
      length: schema.length,
      costInCredits: schema.cost_in_credits,
      crew: schema.crew,
      passengers: schema.passengers,
      maxAtmoshperingSpeed: schema.max_atmosphering_speed,
      cargoCapacity: schema.cargo_capacity,
      consumables: schema.consumables,
      films: schema.films,
      pilots: schema.pilots,
      id: schema.url,
      created: schema.created,
      edited: schema.edited
    )
  }
}
