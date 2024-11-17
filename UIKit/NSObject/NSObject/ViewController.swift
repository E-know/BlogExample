//
//  ViewController.swift
//  NSObject
//
//  Created by Inho Choi on 12/9/23.
//
import MapKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let delegate = mapViewDelegate()
        test(delegate)
    }
}

class mapViewDelegate: NSObject, MKMapViewDelegate {
    let id = UUID()
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        print("HI")
    }
}


func test<T: Hashable>(_ ele: T) {
    print("TEST")
}
