import UIKit
class DetailGitViw: UIViewController {
    let ProfileBox : UIView = {
        let v = UIView()
        v.backgroundColor = .white
        
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.lightGray.cgColor
        return v
    }()
    
    let ProfileImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "empty")
        
        return image
    }()
    
    let ProfileDetailText : UILabel = {
        let label = UILabel()
        label.text = "vazio"
        label.numberOfLines = 0
        return label
    }()
    
    let ProfileLocation : UILabel = {
        let label = UILabel()
        label.text = "carregando..."
        label.numberOfLines = 1
        return label
    }()
    
    let ProfileBio : UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    var Login : String = ""
    
    func SetProfileBoxPosition()
    {
        self.ProfileBox.translatesAutoresizingMaskIntoConstraints = false
        
        self.ProfileBox.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        self.ProfileBox.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        self.ProfileBox.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        self.ProfileBox.bottomAnchor.constraint(equalTo: self.ProfileBio.bottomAnchor, constant: 10).isActive = true
    }
    
    func SetProfileImagePosition()  {
        ProfileImage.translatesAutoresizingMaskIntoConstraints = false
        
        ProfileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        ProfileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        ProfileImage.topAnchor.constraint(equalTo: self.ProfileBox.topAnchor,constant: 10).isActive = true
        ProfileImage.leadingAnchor.constraint(equalTo: self.ProfileBox.leadingAnchor,constant: 10).isActive = true
    }
    
    func SetProfileDetailText()
    {
        ProfileDetailText.translatesAutoresizingMaskIntoConstraints = false
        ProfileDetailText.topAnchor.constraint(equalTo: self.ProfileImage.topAnchor).isActive = true
        ProfileDetailText.leadingAnchor.constraint(equalTo: self.ProfileImage.trailingAnchor, constant: 10).isActive = true
        ProfileDetailText.trailingAnchor.constraint(equalTo: self.ProfileBox.trailingAnchor, constant: -10).isActive = true
    }
    
    func SetProfileLocatioPosition()
    {
        ProfileLocation.translatesAutoresizingMaskIntoConstraints = false
        ProfileLocation.topAnchor.constraint(equalTo: ProfileImage.bottomAnchor, constant: 10).isActive = true
        ProfileLocation.leadingAnchor.constraint(equalTo: ProfileImage.leadingAnchor).isActive = true
        
    }
    
    func SetProfileBioPosition()
    {
        ProfileBio.translatesAutoresizingMaskIntoConstraints = false
        ProfileBio.topAnchor.constraint(equalTo: ProfileLocation.bottomAnchor, constant: 10).isActive = true
        ProfileBio.leadingAnchor.constraint(equalTo: ProfileImage.leadingAnchor).isActive = true
        ProfileBio.trailingAnchor.constraint(equalTo: self.ProfileBox.trailingAnchor, constant: -10).isActive = true
    }
    
    func CallDetailApiUser(){
        //chamada http
        let urlString = "https://api.github.com/users/" + self.Login
        
        HttpHandler.Call(urlString: urlString) { (res : UserDetailGit?) in
            DispatchQueue.main.async {
                
                self.ProfileLocation.text = res?.location
                self.ProfileBio.text = res?.bio
            }
        }        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(voltar))
        
        self.view.addSubview(ProfileBox)
        self.ProfileBox.addSubview(ProfileImage)
        self.ProfileBox.addSubview(ProfileDetailText)
        self.ProfileBox.addSubview(ProfileLocation)
        self.ProfileBox.addSubview(ProfileBio)
        
        SetProfileBoxPosition()
        SetProfileImagePosition()
        SetProfileDetailText()
        SetProfileLocatioPosition()
        SetProfileBioPosition()
        
        CallDetailApiUser()
        
    }
    
    @objc func voltar(){
        self.dismiss(animated: true, completion: nil)
    }
}
