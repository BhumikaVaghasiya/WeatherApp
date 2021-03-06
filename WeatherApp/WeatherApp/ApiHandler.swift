import Foundation
class ApiHandler {
    static let shared = ApiHandler()
    
    private init() {}
    
    func getCity(with name:String) -> [Weather]{
        if let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=9ed7cfcb9dac424e929134511210707&q=\(name)&aqi=no"){
            do { let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                do{ let jsonWeather = try decoder.decode(Weather.self, from: data)
      
                    return  [jsonWeather]
                }catch {
                    print(error)
                }
                
            } catch {
                print("Error : Place name is incorrect !")
            }
        }
        return [Weather]()
    }
}
