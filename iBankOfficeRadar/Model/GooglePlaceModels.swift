// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let googlePlaceNearByResponse = try? newJSONDecoder().decode(GooglePlaceNearByResponse.self, from: jsonData)

import Foundation

// MARK: - GooglePlaceNearByResponse
public struct GooglePlaceNearByResponse: Codable {
    let results: [Place]
    let status: String
}

// MARK: - Result
struct Place: Codable {
    let geometry: Geometry
    let icon: String
    let id, name: String
    let openingHours: OpeningHours
    let placeID: String
    let rating: Double
    let scope: String
    let types: [String]
    let userRatingsTotal: Int
    let vicinity: String
    var ratingString: String {
        return String(rating)
    }

    enum CodingKeys: String, CodingKey {
        case geometry, icon, id, name
        case openingHours = "opening_hours"
        case placeID = "place_id"
        case rating, scope, types
        case userRatingsTotal = "user_ratings_total"
        case vicinity
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let lat, lng: Double
}

// MARK: - OpeningHours
struct OpeningHours: Codable {
    let openNow: Bool

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}

let testPlace = Place(geometry: Geometry(location: Location(lat: 0.0, lng: 0.0)),
                      icon: "icon", id: "id", name: "Place Teste",
                      openingHours: OpeningHours(openNow: false),
                      placeID: "Place ID", rating: 4.4, scope: "GOOGLE",
                      types: ["atm"], userRatingsTotal: 100, vicinity: "Test street 123")
