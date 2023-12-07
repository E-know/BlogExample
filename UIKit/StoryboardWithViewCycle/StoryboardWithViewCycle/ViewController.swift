import UIKit

class FirstViewController: UIViewController {
    private let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondViewController") as? SecondViewController
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("First VC init] textLabel is nil? \(secondVC?.textLabel == nil)")
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        guard let secondVC else { return }
        secondVC.text = "이제 될 꺼임"
        print("tappedButton] textLabel is nil? \(secondVC.textLabel == nil)")
        navigationController?.pushViewController(secondVC, animated: true)
    }
}



class SecondViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    var text: String?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        print("Second VC init] textLabel is nil? \(textLabel == nil)")
    }
    
    override func loadView() {
        print("SecondVC loadView-super.loadView() before] textLabel is nil? \(textLabel == nil)")
        super.loadView()
        print("SecondVC loadView-super.loadView() after] textLabel is nil? \(textLabel == nil)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = text
    }
}
