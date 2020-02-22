import Foundation

public enum GooglePlaceDefinition {
    case searchPlaces(latitude: Double, longitude: Double)
}

extension GooglePlaceDefinition {
    public var path: String {
        switch self {
        case .searchPlaces(let latitude, let longitude):
            return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=2000&type=bank&keyword=Itau&sensor=true&key=COLOCAR_KEY_AQUI"
            //TODO:
                //- change key to your key
        }
    }
    public var method: HttpMethod {
        return HttpMethod.get
    }
}
