import UIKit

class CollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView = {
        var result = UIImageView()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.contentMode = .scaleAspectFit
        return result
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




class ViewModel {
    @Published var images = [ImageData]()
    var randomSize: Int {
        (100...200).randomElement()!
    }
    
    func getImage() async {
        for i in 1...7 {
            guard let image = UIImage(named: "\(i)") else { continue }
            self.images.append(ImageData(image: image, width: Float(image.size.width), height: Float(image.size.height)))
        }
    }
    
    func getImage2() async {
        let width = randomSize
        let height = randomSize
        let urlString = "https://random.imagecdn.app/\(width)/\(height)"
        NSLog(urlString)
        guard let url = URL(string: urlString) else { return }
        
        let imageData = try? Data(contentsOf: url)
        guard let imageData, let image = UIImage(data: imageData) else { return }
        
        self.images.append(ImageData(image: image, width: Float(width), height: Float(height)))
    }
}

struct ImageData {
    let image: UIImage
    let width: Float
    let height: Float
    
    func trueHeight(_ cellWidth: Float) -> Float {
        let ratio = cellWidth / width
        return height * ratio
    }
}
