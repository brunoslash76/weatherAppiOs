import Foundation

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let minTemp: Double
    let maxTemp: Double
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    var maxTempString: String {
        return String(format: "%.0f", maxTemp)
    }
    
    var minTempString: String {
        return String(format: "%.0f", minTemp)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...504:
            return"cloud.sun.rain"
        case 511:
            return"cloud.sleet"
        case 520...531:
            return"cloud.heavyrain"
        case 600...622:
            return"cloud.snow"
        case 700...781:
            return"cloud.fog"
        case 800:
            return"sun.max"
        case 801:
            return"cloud.sun"
        case 802:
            return"cloud"
        case 803...804:
            return"smoke"
        default:
            return"exclamationmark.octagon"
        }
    }
}


