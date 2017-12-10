//
//  Fetcher.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-12-01.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import struct   Foundation.URL
import struct   Foundation.URLRequest
import class    Foundation.DispatchQueue
import struct   Prelude.Async
import struct   Prelude.Resource
import protocol Prelude.Monoid

public final class Fetcher<Element, ElementSchema: Decodable> {
  
  private let accessQueue = DispatchQueue(label: "\(Fetcher.self)")
  private var schema: Schema
  private let elementFromSchema: (ElementSchema) -> Element
  
  init(url: URL, elementFromSchema: @escaping (ElementSchema) -> Element) {
    self.schema = Schema.identity
    self.schema.next = url
    self.elementFromSchema = elementFromSchema
  }
  
  public var count: Int {
    return accessQueue.sync { self.schema.count }
  }
  
  public func loadNext() -> Async<()> {
    let load = accessQueue.sync { schema.next }.map(Schema.resource)?
      .loadFromNetwork()
      .transferred(to: accessQueue)
      .map { newSchema in self.schema = Schema.combine(self.schema, newSchema) }
      .transferred(to: DispatchQueue.global())
    return load ?? .pure(())
  }
  
  public subscript (index: Int) -> Element {
    return accessQueue.sync { self.elementFromSchema(self.schema.results[index]) }
  }
  
}

extension Fetcher {
  
  struct Schema: Decodable {
    var next: URL?
    var count: Int
    var results: [ElementSchema]
  }
  
}

extension Fetcher.Schema: Monoid {
  
  static var identity: Fetcher.Schema {
    return Fetcher.Schema(next: nil, count: 0, results: [])
  }
  
  static func combine(_ lhs: Fetcher.Schema, _ rhs: Fetcher.Schema) -> Fetcher.Schema {
    return Fetcher.Schema(
      next: rhs.next,
      count: lhs.count + rhs.count,
      results: lhs.results + rhs.results
    )
  }
}

extension Fetcher.Schema {
  
  static func resource(url: URL) -> Resource<Fetcher.Schema> {
    return Resource(url: url)
  }
  
}

extension Fetcher {
  
  typealias Error = FetcherError
  
}

enum FetcherError: Error {
  case invalidIndex
}
