//
//  ViewColorViewController.swift
//  HW.2.6
//
//  Created by Сергей Долгих on 30.10.2020.
//

import UIKit

protocol ColorSettingViewControllerDelegate {
    func setBackgroung(color: UIColor)
}

class ViewColorViewController: UIViewController {
    // MARK: - IB Outlets
    
    
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = randomColor()
    }
//    @IBAction func unwind(segue: UIStoryboardSegue) {}

    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
       let colorSettingVC = segue.destination
        as! ColorSettingViewController
        colorSettingVC.viewBackgrounColor = view.backgroundColor
        colorSettingVC.delegate = self
    }
    // MARK: - Privat Methods
    private func randomColor() -> UIColor {
        UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1
        )
    }
}

extension ViewColorViewController:
    ColorSettingViewControllerDelegate {
    func setBackgroung(color: UIColor) {
        view.backgroundColor = color
    }
}
