import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    let URLString = "https://api.openweathermap.org/data/2.5/weather?appid=3a400aff97451ba1cc2f88637e72f39b&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(URLString)&q=\(cityName)"
        performRequest(to: urlString)
    }
    
    func fetchWeather(latitude lat: CLLocationDegrees, longitude lon: CLLocationDegrees) {
        let urlString = "\(URLString)&lat=\(lat)&lon=\(lon)"
        print(urlString)
        performRequest(to: urlString)
    }
    
    func performRequest(to urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            let minTemp = decodedData.main.temp_min
            let maxTemp = decodedData.main.temp_max
            
            return WeatherModel(
                conditionId: id,
                cityName: cityName,
                temperature: temp,
                minTemp: minTemp,
                maxTemp: maxTemp
            )
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
