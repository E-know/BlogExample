import UIKit
import Combine

class ViewController: UIViewController {
    var vm = ViewModel()
    var cancel = Set<AnyCancellable>()
    
    var textField: UITextField = {
        var result = UITextField()
        result.translatesAutoresizingMaskIntoConstraints = false
        
        return result
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = PinterestLayout()
        var result = UICollectionView(frame: .zero, collectionViewLayout: layout)
        result.translatesAutoresizingMaskIntoConstraints = false
        result.contentInsetAdjustmentBehavior = .always
        
        return result
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        vm.$images.sink(receiveValue: { images in
            if images.count == 7 {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
        .store(in: &cancel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task { [weak self] in
//            for i in 0...10 {
//                Task {
//                    NSLog(String(i))
//                    await self?.vm.getImage()
//                }
//            }
            await self?.vm.getImage()
            
        }
    }
    
    func layout() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        collectionView.dataSource = self
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CollectionViewCell
        
        if indexPath.item < vm.images.count {
            myCell.imageView.image = vm.images[indexPath.row].image
        } else {
            myCell.backgroundColor = .gray
        }
        return myCell
    }
}




#Preview {
    return ViewController()
}

