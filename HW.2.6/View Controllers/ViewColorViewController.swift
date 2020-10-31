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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = randomColor()
//        setBackgroung(color: randomColor())

    }
//    @IBAction func unwind(segue: UIStoryboardSegue) {}

    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
       let colorSettingVC = segue.destination as! ColorSettingViewController
        colorSettingVC.viewBackgrounColor = view.backgroundColor
        colorSettingVC.delegate = self
            //принт
//        setRGBValue(color: view.backgroundColor!)
        
    }
    
//    private func setBackgroung(color: UIColor) {
//        view.backgroundColor = color
//    }
    private func randomColor() -> UIColor {
        UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1
        )
    }
    //удалить
//    private func setRGBValue(color:UIColor) {
//        var currentRedValue: CGFloat = 0
//        var currentGreenValue: CGFloat = 0
//        var currentBlueValue: CGFloat = 0
//
//        color.getRed(&currentRedValue,
//                     green: &currentGreenValue,
//                     blue: &currentBlueValue,
//                     alpha: nil)
//
//        print("view - red \(currentRedValue), green \(currentGreenValue), blue \(currentBlueValue) ")
//
//    }
    
}

extension ViewColorViewController:
    ColorSettingViewControllerDelegate {
    func setBackgroung(color: UIColor) {
        view.backgroundColor = color
    }
    
}
