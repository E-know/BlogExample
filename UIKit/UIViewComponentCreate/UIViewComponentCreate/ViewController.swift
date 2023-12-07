import UIKit

class ViewController: UIViewController {
    private var myView = Bundle.main.loadNibNamed("MyView", owner: self)?.first as? MyView
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        print("VC init] myView.onLable is nil? \(myView?.onLabel == nil)")
    }
    
    
    override func loadView() {
        super.loadView()
        
        print("VC loadView] myView.onLable is nil? \(myView?.onLabel == nil)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VC viewDidLoad] myView.onLable is nil? \(myView?.onLabel == nil)")
        
        guard let myView else { return }
        myView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myView)
        NSLayoutConstraint.activate([
            myView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myView.heightAnchor.constraint(equalToConstant: 400),
            myView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        myView.onLabel.text = "바뀜"
    }
}


class MyView: UIView {
    @IBOutlet weak var onLabel: UILabel!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        print("VC myView init] myView.onLable is nil? \(onLabel == nil)")
    }
}
