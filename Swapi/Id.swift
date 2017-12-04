//
//  Id.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-07.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

public struct Id<Kind>: Decodable {
  let id: String
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let url = try container.decode(String.self)
    guard let last = url.split(separator: "/").last else {
        throw DecodingError.dataCorruptedError(
          in: container,
          debugDescription: "Unable to parse URL: \(url)"
        )
    }
    id = String(last)
  }
}
