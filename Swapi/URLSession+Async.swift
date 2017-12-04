//
//  URLSession+Async.swift
//  Swapi
//
//  Created by Kristofer Hanes on 2017-11-11.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import class Foundation.URLSession
import struct Foundation.URL
import struct Foundation.Data
import struct Prelude.Async

extension URLSession {
  func data(from url: URL) -> Async<Data> {
    return Async { yield in
      self.dataTask(with: url) { data, response, error in
        switch (data, error) {
        case let (data?, _):
          yield(.ok(data))
        case let (_, error?):
          yield(.error(error))
        default: fatalError("URLSession error")
        }
      }.resume()
    }
  }
}
