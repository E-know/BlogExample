//
//  CollectionViewCell.swift
//  InfinityScrollView
//
//  Created by Inho Choi on 7/9/24.
//
import SnapKit
import UIKit

final class CollectionViewCell: UICollectionViewCell {
	private let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		label.text = "-"
		label.font = .systemFont(ofSize: 25, weight: .heavy)
		label.textAlignment = .center
		
		self.addSubview(label)
		label.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.backgroundColor = nil
		label.text = "-"
	}
	
	func setCell(color: UIColor?, text: String?) {
		self.backgroundColor = color
		label.text = text
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
