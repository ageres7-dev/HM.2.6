//
//  ColorSettingViewController.swift
//  HM.2.2
//
//  Created by Сергей Долгих on 16.10.2020.
//

import UIKit

class ColorSettingViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: - Public Properties
    var viewBackgrounColor: UIColor!
    var delegate: ColorSettingViewControllerDelegate!
    
    // MARK: - Private Properties
    private var currentRedValue: CGFloat = 0
    private var currentGreenValue: CGFloat = 0
    private var currentBlueValue: CGFloat = 0
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
   
        redTextField.addDoneButtonOnKeyBoardWithControl()
        greenTextField.addDoneButtonOnKeyBoardWithControl()
        blueTextField.addDoneButtonOnKeyBoardWithControl()
        
        colorView.layer.cornerRadius = 15
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        setRGBValue(color: viewBackgrounColor)

        updateUI()
    }
    
    // MARK: - Hide keyboard to tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
        
//        setTextFieldValue()
    }
    
    
    // MARK: - IB Action
    @IBAction func rgbSlidersAction(_ sender: UISlider) {
        switch sender.tag {
        case 0: currentRedValue = CGFloat(sender.value)
        case 1: currentGreenValue = CGFloat(sender.value)
        case 2: currentBlueValue = CGFloat(sender.value)
        default: break
        }
        updateUI()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setBackgroung(
            color: colorView.backgroundColor!
        )
        dismiss(animated: true)
    }
    // MARK: - Public Methods
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        textFieldDidEndEditing(textField)
//        updateUI()
//        view.endEditing(true)
//
//        return false
//    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = nil
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var colorValue: CGFloat = 0
        
        if let setValue = (Float(textField.text!)),
           setValue <= 1,
           setValue >= 0 {
            colorValue = CGFloat(setValue)
            textField.text = string(setValue) //String(format: "%.2f", setValue)
        } else {
            showAlert(with: "Wrong number", and: "😱😱😱")
            textField.text = "0.00"
//            setValue >= 1 ? "1" : "0"
        }
        
        
//        let colorValue = CGFloat(Float((textField.text)!) ?? 0)
        
        switch textField.tag {
        case 0:
            currentRedValue = colorValue
        case 1:
            currentGreenValue = colorValue
        case 2:
            currentBlueValue = colorValue
        default: break
        }
       
        setColorToColorView()
        setValueToSliders()
        setValueToLabels()
        
    }
    // MARK: - Privat Methods
    private func updateUI() {
        setColorToColorView()
        setValueToSliders()
        setValueToLabels()
        setTextFieldValue()
    }
    
    private func setTextFieldValue() {
        redTextField.text = string(currentRedValue) // String(
//            format: "%.2f", currentRedValue
//        )
        greenTextField.text = string(currentGreenValue)
//            String(
//            format: "%.2f", currentGreenValue
//        )
        blueTextField.text = string(currentBlueValue)
//            String(
//            format: "%.2f", currentBlueValue
//        )
    }
    
    private func setRGBValue(color:UIColor) {
        color.getRed(&currentRedValue,
                     green: &currentGreenValue,
                     blue: &currentBlueValue,
                     alpha: nil)
    }
    
    private func setColorToColorView() {
        let currentColor = UIColor(
            red: currentRedValue,
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
    
    //переделать
    private func setValueToLabels() {
        redValueLabel.text = string(currentRedValue)
            
//            = String(
//            format: "%.2f", currentRedValue
//        )
        greenValueLabel.text = string(currentGreenValue)
//            String(
//            format: "%.2f", currentGreenValue
//        )
        blueValueLabel.text = string(currentBlueValue)
//            String(
//            format: "%.2f", currentBlueValue
//        )
    }
}


extension UITextField {
    //нагуглил https://gist.github.com/jplazcano87/8b5d3bc89c3578e45c3e
    
    func addDoneButtonOnKeyBoardWithControl() {
        let keyboardToolbar = UIToolbar(frame: CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: 44
            )
        )
        keyboardToolbar.sizeToFit()
        keyboardToolbar.barStyle = .default
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneBarButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(endEditing(_:))
//            action: #selector(resignFirstResponder)
        )
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        inputAccessoryView = keyboardToolbar
        
    
    }
    
}


extension ColorSettingViewController {
    // MARK: - Alert Controller
    private func showAlert(with title: String,
                           and message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func string(_ value: CGFloat) -> String {
        String(format: "%.2f", value)
    }
    // MARK: - Line shortening
    private func string(_ value: Float) -> String {
        String(format: "%.2f", value)
    }
}
