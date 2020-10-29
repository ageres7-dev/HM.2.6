//
//  ViewController.swift
//  HM.2.2
//
//  Created by Сергей Долгих on 16.10.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    private var currentRedValue = CGFloat.random(in: 0...1)
    private var currentGreenValue = CGFloat.random(in: 0...1)
    private var currentBlueValue = CGFloat.random(in: 0...1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        colorView.layer.cornerRadius = 15
        setColorToColorView()
        setValueToSliders()
        setValueToLabels()
    }

    @IBAction func redSliderAction() {
        currentRedValue = CGFloat(redSlider.value)
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        setColorToColorView()
    }
    @IBAction func greenSliderAction() {
        currentGreenValue = CGFloat(greenSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        setColorToColorView()
    }
    @IBAction func blueSliderAction() {
        currentBlueValue = CGFloat(blueSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
        setColorToColorView()
    }
    
    private func setColorToColorView() {
        let currentColor = UIColor(
            displayP3Red: currentRedValue,
            green: currentGreenValue,
            blue: currentBlueValue,
            alpha: 1
        )
        colorView.backgroundColor = currentColor
    }
    
    private func setValueToSliders() {
        redSlider.value = Float(currentRedValue)
        greenSlider.value = Float(currentGreenValue)
        blueSlider.value = Float(currentBlueValue)
    }
    
    private func setValueToLabels() {
        redValueLabel.text = String(format: "%.2f", currentRedValue)
        greenValueLabel.text = String(format: "%.2f", currentGreenValue)
        blueValueLabel.text = String(format: "%.2f", currentBlueValue)
    }

}

