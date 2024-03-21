import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    var users = [UserData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        Task {
            let url = URL(string: "https://reqres.in/api/users")
            let (data, _) = try await URLSession.shared.data(from: url!)
            let res = try JSONDecoder().decode(Info.self, from: data)
            self.users = res.data
            self.table.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
        let user = users[indexPath.row]
        let url = URL(string: user.avatar)
        let imageData = try? Data(contentsOf: url!)
        cell.img.image = UIImage(data: imageData!)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let message = "\(user.first_name) \(user.last_name)\n\(user.email)"
        let alert = UIAlertController(title: "User Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
