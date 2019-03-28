import UIKit

class ListGitTableViewController: UITableViewController {
    
    var users : [UserGit] = []
    var page = 1
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Buscando..."
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        //chamada http
        callApi()
    }
    
    var carregando = false
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if carregando == true{
            return
        }
        
        if indexPath.row > (self.users.count - 4){
            print("chegoue \(indexPath.row)")
            carregando = true
            page = page + 1
            
            callApi()
        }
    }
    
    func callApi(){
        let urlString = "https://api.github.com/search/users?q=followers:%3E1000&page=\(page)&per_page=40"
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        HttpHandler.Call(urlString: urlString) { (res : GitRS?) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.users.append(contentsOf: res!.items)
            DispatchQueue.main.async {
                self.carregando = false
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



