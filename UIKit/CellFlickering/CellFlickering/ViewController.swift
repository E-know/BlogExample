//
//  ViewController.swift
//  CellFlickering
//
//  Created by Inho Choi on 7/29/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
	var dataSource = (1...30).map{ String($0) }
	
	let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let button: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("테스트", for: .normal)
		button.backgroundColor = .blue
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		collectionView.dataSource = self
		collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cell")
		
		view.addSubview(collectionView)
		view.addSubview(button)
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: button.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			button.heightAnchor.constraint(equalToConstant: 50)
		])
		
		button.addAction(UIAction { [weak self] _ in
			self?.dataSource[9] = String(Int.random(in: 100..<1000))
			UIView.performWithoutAnimation {
				self?.collectionView.reloadItems(at: [IndexPath(item: 9, section: 0)])
			}
		}, for: .touchUpInside)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell
		cell.label.text = dataSource[indexPath.item]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		dataSource.count
	}
}

class MyCell: UICollectionViewCell {
	let label: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .cyan
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		print("Cell Init")
		self.backgroundColor = .gray
		addSubview(label)
		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
