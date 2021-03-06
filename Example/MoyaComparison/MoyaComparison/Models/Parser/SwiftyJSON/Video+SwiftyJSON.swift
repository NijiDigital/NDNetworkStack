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
import SwiftyJSON

extension Video: Swifty {
  
  convenience init(json: JSON) {
    self.init()
    self.identifier = json[Attributes.identifier].intValue
    self.title = json[Attributes.title].stringValue
    self.creationDate = json[Attributes.creationDate].flatMap(SwiftyTransformer.dateTransform).first
    self.likeCounts  = json[Attributes.likeCounts].intValue
    self.hasSponsors.value = json[Attributes.hasSponsors].boolValue
    self.statusCode.value = json[Attributes.statusCode].intValue
    // RelationShips
    let relatedVideosSandbox: [Video] = json[Relationships.relatedVideos].arrayValue.map(SwiftyTransformer.arrayVideoTransform)
    self.relatedVideos.append(objectsIn: relatedVideosSandbox)
  }
    
  func toJSON() -> JSON {
    var json: JSON = JSON(dictionaryLiteral: [])
    json[Attributes.identifier].int = self.identifier
    json[Attributes.title].string = self.title
    json[Attributes.creationDate].string = self.creationDate.map(SwiftyTransformer.dateTransform)
    json[Attributes.likeCounts].int = self.likeCounts
    json[Attributes.hasSponsors].bool = self.hasSponsors.value
    json[Attributes.statusCode].int = self.statusCode.value
    // RelationShips
    json[Relationships.relatedVideos].arrayObject = self.relatedVideos.map(SwiftyTransformer.arrayVideoTransform)
    return json
  }
}

struct SwiftyTransformer {
  static func dateTransform(value: String, json: JSON) -> Date? {
    return DateFormatter.iso8601Formatter.date(from: value)
  }
  
  static func dateTransform(date: Date?) -> String {
    return DateFormatter.iso8601Formatter.string(from: date ?? Date())
  }
  
  static func arrayVideoTransform<T: Swifty>(json: JSON) -> T {
    return T.init(json: json)
  }
  
  static func arrayVideoTransform<T: Swifty>(object: T) -> JSON {
    return object.toJSON()
  }
}
