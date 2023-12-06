import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tappedButton(_ sender: Any) {
        if let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondViewController") as? SecondViewController {
            
            vc.textLabel.text = "이건 에러가 나야 정상"
            
//            vc.text = "이제 될 꺼임"
            
//            vc.completeHandler = {
//                vc.textLabel.text = "이제 될꺼임"
//            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


class SecondViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
//    var completeHandler: (() -> Void)?
//    var text: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        completeHandler?()
//        textLabel.text = text
    }
}
