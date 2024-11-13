//
//  ViewController.swift
//  KeyboardLayoutTest
//
//  Created by Inho Choi on 11/11/24.
//

import UIKit

class ViewController: UIViewController {
  let button = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .brown
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    button.setTitle("모달 업", for: .normal)
    
    button.addAction(UIAction { [weak self] _ in
      let vc = ModalViewController()
      vc.modalPresentationStyle = .overFullScreen
      self?.present(vc, animated: true)
    }, for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let vc = ModalViewController()
    vc.modalPresentationStyle = .overFullScreen
    present(vc, animated: true)
  }
}

class ModalViewController: UIViewController {
  let textField = UITextField()
  let button = UIButton()
  var keyboardLayouts = Set<NSLayoutConstraint>()
  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .cyan
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(textField)
    textField.placeholder = "여기에 입력하시지요"
    textField.backgroundColor = .white
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("디스미스", for: .normal)
    button.setTitleColor(.red, for: .normal)
    button.addAction(UIAction { _ in
      self.dismiss(animated: true)
    }, for: .touchUpInside)
    view.addSubview(button)
    
    let bottom = textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    bottom.priority = .init(900)
    let keyboardLayout = textField.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor)
    keyboardLayouts.insert(keyboardLayout)
    NSLayoutConstraint.activate([
      keyboardLayout,
      bottom,
      textField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    keyboardLayouts.forEach {
      $0.isActive = false
    }
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
