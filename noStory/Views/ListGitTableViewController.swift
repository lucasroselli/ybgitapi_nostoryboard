import UIKit

class ListGitTableViewController: UITableViewController {
    
    var users : [UserGit] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Buscando..."
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        //chamada http
        let urlString = "https://api.github.com/search/users?q=followers:%3E10000"
        
        HttpHandler.Call(urlString: urlString) { (res : GitRS?) in
            self.users = res!.items            
            DispatchQueue.main.async {
                self.title = "Maiores do Git"
                self.tableView?.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        
        let user = self.users[indexPath.row]
        
        cell.detailTextLabel?.text = user.url
        cell.textLabel?.text = user.login
        cell.imageView?.image = UIImage(named: "empty")
        cell.imageView?.download(from: user.avatar_url)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userSelected  = self.users[indexPath.row]
        
        let detailGitView = DetailGitViw()
        
        detailGitView.title = userSelected.login
        detailGitView.ProfileImage.download(from: userSelected.avatar_url)
        detailGitView.ProfileDetailText.text = userSelected.url
        detailGitView.Login = userSelected.login
        
        self.present(UINavigationController(rootViewController: detailGitView), animated: true, completion: nil)
    }
}



