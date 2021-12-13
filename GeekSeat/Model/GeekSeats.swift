//
//  GeekSeats.swift
//  GeekSeat
//
//  Created by Anthony Olukitibi on 12/11/21.
//

import Foundation

struct GeekSeats: Decodable {
    let events: [GeekSeat]
}

struct GeekSeat: Decodable {
    let id: Int?
    let datetimeUTC: String?
    let title: String?
    let venue: Venue?
    let performers: [Performer]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case datetimeUTC = "datetime_utc"
        case title
        case venue
        case performers
    }
}

struct Venue: Decodable {
    let state: String?
    let city: String?
    let id: Int?
}

struct Performer: Decodable {
    let image: String?
}
