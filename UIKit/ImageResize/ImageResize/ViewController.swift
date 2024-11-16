//
//  ViewController.swift
//  ImageResize
//
//  Created by Inho Choi on 7/4/24.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    private let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = .test.resize(targetSize: CGSize(width: 300, height: 200))
        imageView.contentMode = .scaleAspectFit
        
        imageView.backgroundColor = .cyan
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}


extension UIImage {
    func resize(targetSize: CGSize) -> UIImage? {
        let originalSize = self.size
        let ratio = targetSize.height / originalSize.height
        let newWidth = originalSize.width * ratio
        let newTargetSize = CGSize(width: newWidth, height: targetSize.height)
        
        let obj = UIGraphicsImageRenderer(size: newTargetSize)
        
        return obj.image { a in
            self.draw(in: CGRect(origin: .zero, size: newTargetSize))
        }
    }
}
