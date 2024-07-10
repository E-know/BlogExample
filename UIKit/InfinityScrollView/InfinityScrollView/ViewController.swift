//
//  ViewController.swift
//  InfinityScrollView
//
//  Created by Inho Choi on 7/9/24.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
	private let layout = UICollectionViewFlowLayout()
	private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
	
	private var items: [(String, UIColor)] = [("1", .yellow), ("2", .purple), ("3", .brown)]

	override func viewDidLoad() {
		super.viewDidLoad()
		items = [items.last!] + items + [items.first!]
		
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		collectionView.backgroundColor = .brown
		collectionView.isScrollEnabled = true
		collectionView.isPagingEnabled = true
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		
		view.addSubview(collectionView)
		collectionView.backgroundColor = .gray
		collectionView.snp.makeConstraints {
			$0.horizontalEdges.centerY.equalToSuperview()
			$0.height.equalTo(200)
		}
	}
	
	// 변화 부분 왜 layout 순서가 더 빠르다.
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.collectionView.setContentOffset(CGPoint(x: view.frame.width, y: 0), animated: false)
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
		let item = items[indexPath.item]
		cell.setCell(color: item.1, text: item.0)
		return cell
	}
}

extension ViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return collectionView.frame.size
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let count = items.count
		
		if scrollView.contentOffset.x == 0 {
			let endX = scrollView.frame.width * CGFloat(count - 2)
			scrollView.setContentOffset(CGPoint(x: endX, y: scrollView.contentOffset.y), animated: false)
		}
		if scrollView.contentSize.width - scrollView.frame.width == scrollView.contentOffset.x {
			scrollView.setContentOffset(CGPoint(x: scrollView.frame.width, y: scrollView.contentOffset.y), animated: false)
		}
	}
}
