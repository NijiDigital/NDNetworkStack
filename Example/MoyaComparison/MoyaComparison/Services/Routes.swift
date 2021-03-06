//
// Copyright 2017 niji
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import NetworkStack

public struct Route: Routable {
  public let path: String
  init(path: String) { self.path = path }
}

extension Route: CustomStringConvertible {
  public var description: String { return path }
}

extension Route {
  public static func authent() -> Route { return Route(path: "/authent") }
  public static func refreshToken() -> Route { return Route(path: "/refreshToken") }
  public static func videos() -> Route { return Route(path: "/videos") }
  public static func video(identifier: Int) -> Route { return Route(path: "/videos/\(identifier)") }
  public static func document(videoIdentifier: Int) -> Route { return Route(path: "/videos/\(videoIdentifier)/document") }
  public static func users() -> Route { return Route(path: "/users") }
  public static func user(identifier: Int) -> Route { return Route(path: "/users/\(identifier)") }
  public static func badAccess() -> Route { return Route(path: "/bad") }
}
