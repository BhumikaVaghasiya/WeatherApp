import Foundation
class Weather: Decodable{
    var location: Weather1
    var current: Current

}
class Weather1:Decodable
{
    var name = ""
    var country = ""
    
}

class Current:Decodable{
    var temp_c:Float
    var condition: Condition
}

class Condition:Decodable
{
    var icon = ""
    var text = ""
}
