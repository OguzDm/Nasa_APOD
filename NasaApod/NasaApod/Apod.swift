//
//  Apod.swift
//  NasaApod
//
//  Created by Squiretoss on 17.03.2020.
//  Copyright © 2020 Oguz Demirhan. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let apod = try? newJSONDecoder().decode(Apod.self, from: jsonData)

import Foundation

// MARK: - Apod
struct Apod: Codable {
    let date, explanation: String
    let hdurl: String
    let mediaType, serviceVersion, title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
