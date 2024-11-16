import UIKit

class ViewController: UIViewController {
	let button: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("테스트", for: .normal)
		button.tintColor = .blue
		button.backgroundColor = .black
		return button
	}()
	
	let myClass = MyClass()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		myClass.viewController = self
		
		view.addSubview(button)
		NSLayoutConstraint.activate([
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			button.heightAnchor.constraint(equalToConstant: 30),
			button.widthAnchor.constraint(equalToConstant: 100)
		])
		
		button.addAction(UIAction { [weak self] _ in
			DispatchQueue.global().async { [weak self] in
				Task { @MainActor in
					print("Task MainActor is run on MainThread? \(Thread.isMainThread)")
					self?.myClass.viewController?.test()
				}
			}
		}, for: .touchUpInside)
	}

	func test() {
		print("is MainThread? \(Thread.isMainThread)")
	}
}


class MyClass {
	weak var viewController: ViewController?
}
