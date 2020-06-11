import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: Array<Weather>
    let base: String
    let visibility: Int?
    let wind: Wind
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
}
