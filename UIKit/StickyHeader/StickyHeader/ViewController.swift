//
//  ViewController.swift
//  StickyHeader
//
//  Created by Inho Choi on 7/5/24.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
	let layout = UICollectionViewFlowLayout()
	lazy var collectionView: UICollectionView = {
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.delegate = self
		view.dataSource = self
		view.register(Cell.self, forCellWithReuseIdentifier: "cell")
		view.register(Cell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
		view.register(Cell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		layout.minimumInteritemSpacing = 10
		layout.sectionHeadersPinToVisibleBounds = true
		layout.sectionFootersPinToVisibleBounds = true
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints {
			$0.top.bottom.equalTo(view.safeAreaLayoutGuide)
			$0.trailing.leading.equalToSuperview()
		}
	}
}


extension ViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		4
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		20
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
		cell.backgroundColor = .cyan
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! Cell
			cell.label.text = "헤더는 상단에 고정 헤더는 상단에 고정 헤더는 상단에 고정 헤더는 상단에 고정 헤더는 상단에 고정 헤더는 상단에 고정 헤더는 상단에 고정 헤더는 상단에 고정"
			cell.label.textColor = .white
			cell.backgroundColor = .black
			return cell
		} else {
			let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! Cell
			cell.label.text = "푸터는 하단에 고정 푸터는 하단에 고정 푸터는 하단에 고정 푸터는 하단에 고정 푸터는 하단에 고정 푸터는 하단에 고정 푸터는 하단에 고정 "
			cell.label.textColor = .cyan
			cell.backgroundColor = .black
			return cell
		}
	}
}

extension ViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: self.view.frame.width, height: 40)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		CGSize(width: view.frame.width, height: 40)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		CGSize(width: view.frame.width, height: 40)
	}
}

class Cell: UICollectionViewCell {
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(label)
		label.snp.makeConstraints {
			$0.leading.centerY.equalToSuperview()
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let label = UILabel()
}
