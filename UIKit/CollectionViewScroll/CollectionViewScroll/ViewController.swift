//
//  ViewController.swift
//  CollectionViewScroll
//
//  Created by Inho Choi on 11/16/24.
//

import UIKit

final class ViewController: UIViewController {
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let button: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Print CollectionView Info", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .blue
    return button
  }()
  
  let countButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("데이터 개수 50개 미만으로 바꾸기", for: .normal)
    button.setTitleColor(.brown, for: .normal)
    button.backgroundColor = .green
    return button
  }()
  
  lazy var dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell
    cell.label.text = itemIdentifier
    return cell
  }
  var collectionViewHeight: NSLayoutConstraint!
  
  var data = (0..<50).map({ _ in
    String(Int.random(in: 0...100_000))
  })
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .lightGray
    
    view.addSubview(collectionView)
    view.addSubview(countButton)
    view.addSubview(button)
    
    button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    countButton.addTarget(self, action: #selector(tapCountButton), for: .touchUpInside)
    collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cell")
    
    collectionViewHeight = collectionView.heightAnchor.constraint(equalToConstant: 0)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionViewHeight,
    ])
    
    NSLayoutConstraint.activate([
      countButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
      countButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      countButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      countButton.heightAnchor.constraint(equalToConstant: countButton.intrinsicContentSize.height)
    ])
    
    
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: countButton.bottomAnchor),
      button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      button.heightAnchor.constraint(equalToConstant: button.intrinsicContentSize.height)
    ])
    
    var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
    snapshot.appendSections([0])
    snapshot.appendItems(data, toSection: 0)
    dataSource.apply(snapshot, animatingDifferences: false)
    collectionView.layoutIfNeeded()
    print(#function, collectionView.contentSize)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print(#function, collectionView.contentSize)
  }
  
  override func viewIsAppearing(_ animated: Bool) {
    super.viewIsAppearing(animated)
    print(#function, collectionView.contentSize)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print(#function, collectionView.contentSize)
  }
  
  @objc func tapButton() {
    print("Collection View ContentSize: \(collectionView.contentSize)")

    print("Collection View Frame: \(collectionView.frame)\n")
  }
  
  func resizeHeigt() {
    collectionViewHeight.constant = collectionView.contentSize.height
  }
  
  @objc func tapCountButton() {
    let countRandom = Int.random(in: 20...50)
    data = (0..<countRandom).map( { _ in
      String(Int.random(in: 0...100_000_000))
    })
    
    var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
    snapshot.appendSections([0])
    snapshot.appendItems(data)
    dataSource.apply(snapshot, animatingDifferences: false)
    print("Collection View ContentSize: \(collectionView.contentSize)")
    collectionViewHeight.constant = collectionView.contentSize.height
  }
}

final class MyCell: UICollectionViewCell {
  let label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20)
    label.textColor = .black
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(label)
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
    ])
    
    self.backgroundColor = .lightGray
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
