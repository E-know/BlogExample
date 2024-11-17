//
//  ViewController.swift
//  ViewIsAppearing
//
//  Created by Inho Choi on 12/7/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var innerView: UIView!
    
    override func loadView() {
        super.loadView()
        print("loadView")
        print("TopView Frame: \(topView.frame)")
        print("CenterView Frame: \(centerView.frame)")
        print("BottomView Frame: \(bottomView.frame)")
        print("InnerView Frame: \(innerView.frame)")
        print()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        print("TopView Frame: \(topView.frame)")
        print("CenterView Frame: \(centerView.frame)")
        print("BottomView Frame: \(bottomView.frame)")
        print("InnerView Frame: \(innerView.frame)")
        print()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print("viewDidLoad")
        print("TopView Frame: \(topView.frame)")
        print("CenterView Frame: \(centerView.frame)")
        print("BottomView Frame: \(bottomView.frame)")
        print("InnerView Frame: \(innerView.frame)")
    }
}

