//
//  ViewController.swift
//  CollectionVIewSelect
//
//  Created by Inho Choi on 10/29/24.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private let bottomCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private let topCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private let topDataSource: UICollectionViewDiffableDataSource<Int, String>!
  private let bottomDataSource: UICollectionViewDiffableDataSource<Int, String>!
  
  init() {
    topCollectionView.register(TopCell.self, forCellWithReuseIdentifier: "cell")
    bottomCollectionView.register(BottomCell.self, forCellWithReuseIdentifier: "cell")
    
    topDataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: topCollectionView,cellProvider: { collectionView, indexPath, itemIdentifier in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TopCell
      cell.label.text = itemIdentifier
      return cell
    })
    bottomDataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: bottomCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BottomCell
      cell.label.text = itemIdentifier
      return cell
    })
    super.init(nibName: nil, bundle: nil)
    self.view.backgroundColor = .red
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(bottomCollectionView)
    bottomCollectionView.snp.makeConstraints {
      $0.height.equalTo(UIScreen.main.bounds.size.height / 3)
      $0.horizontalEdges.bottom.equalToSuperview()
    }
    
    view.addSubview(topCollectionView)
    topCollectionView.snp.makeConstraints {
      $0.height.equalTo(UIScreen.main.bounds.size.height / 3)
      $0.horizontalEdges.top.equalToSuperview()
    }
    
    topCollectionView.register(TopCell.self, forCellWithReuseIdentifier: "cell")
    bottomCollectionView.register(BottomCell.self, forCellWithReuseIdentifier: "cell")
    bottomCollectionView.delegate = self
    
    var snapshot = bottomDataSource.snapshot()
    snapshot.appendSections([0])
    snapshot.appendItems(["A", "B", "C", "D", "E", "G"])
    bottomDataSource.apply(snapshot)
    
    var snapshot2 = topDataSource.snapshot()
    snapshot2.appendSections([0])
    topDataSource.apply(snapshot2)
  }
}

extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    Task.detached { [weak self] in
      guard let self else { return }
      let item = await bottomDataSource.snapshot().itemIdentifiers
      
      var snapshot = await topDataSource.snapshot()
      snapshot.appendItems([item[indexPath.item]])
      Task { @MainActor in
        self.topDataSource.apply(snapshot)
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    Task.detached { [weak self] in
      guard let self else { return }
      let item = await bottomDataSource.snapshot().itemIdentifiers
      
      var snapshot = await topDataSource.snapshot()
      snapshot.deleteItems([item[indexPath.item]])
      Task { @MainActor in
        self.topDataSource.apply(snapshot)
      }
    }
  }
}

final class TopCell: UICollectionViewCell {
  let label = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    label.translatesAutoresizingMaskIntoConstraints = false
    addSubview(label)
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
    ])
    label.font = .systemFont(ofSize: 24, weight: .bold)
    backgroundColor = .cyan
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

final class BottomCell: UICollectionViewCell {
  let label = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    label.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(label)
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
    ])
    backgroundColor = .lightGray
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
