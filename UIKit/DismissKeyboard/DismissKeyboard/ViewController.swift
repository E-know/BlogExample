//
//  ViewController.swift
//  DismissKeyboard
//
//  Created by Inho Choi on 7/11/24.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
	let textFeild = UITextField()
	let topView = UIView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		view.addSubview(textFeild)
		textFeild.snp.makeConstraints {
			$0.centerY.equalToSuperview()
			$0.horizontalEdges.equalToSuperview().inset(8)
		}
		
		view.addSubview(topView)
		topView.snp.makeConstraints {
			$0.bottom.equalTo(textFeild.snp.top)
			$0.top.horizontalEdges.equalToSuperview()
		}
		topView.backgroundColor = .blue
		
		view.backgroundColor = .gray
		textFeild.backgroundColor = .white
		
		hideKeyboard()
	}
	
	// 2️⃣ touchesBegan 사용하기
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		view.endEditing(true)
	}
	
	
	// 1️⃣ UITapGestureReconginzer 사용하기
	func hideKeyboard() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tap)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}

