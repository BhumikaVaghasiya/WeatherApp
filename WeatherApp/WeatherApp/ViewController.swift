
import UIKit

class ViewController: UIViewController {
    
    var Data = [Weather]()
    let SearchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter Place Name"
        return sb
    }()
    private let img: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    private let lbl2: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.numberOfLines = 5
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "arial", size: 20)
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(SearchBar)
         SearchBar.delegate = self
        view.addSubview(lbl2)
        view.addSubview(img)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        SearchBar.frame = CGRect(x: 20, y: 30, width: view.width-40, height: 50)
        img.frame = CGRect(x: (view.width - 90)/2, y: SearchBar.bottom + 100 , width: 90, height: 90)
        lbl2.frame = CGRect(x: 0, y: 100, width: view.width, height: 500)
    }
    func showData(name:String){
        Data = ApiHandler.shared.getCity(with: name)
        var pathstr = ""
        for i in Data {
            lbl2.text = "\(i.location.name) ,\(i.location.country) \n Tempreture: \(i.current.temp_c) \n Condition: \(i.current.condition.text)"
            pathstr = "https:\(i.current.condition.icon)"
            print(pathstr)
            if let url = URL(string: pathstr) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async { /// execute on main thread
                        self.img.image = UIImage(data: data)
                    }
                }
                
                task.resume()
            }
        }
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        showData(name: searchBar.text!)
    }
}

