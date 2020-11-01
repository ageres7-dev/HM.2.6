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
    private var tempString: String?
    
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

        inicialSetColorView()
        setValueToSliders()
        setValueFor(redValueLabel, greenValueLabel, blueValueLabel)
        setTextFieldValue()
    }
    
    // MARK: - Hide keyboard to tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Action
    @IBAction func rgbSlidersAction(_ sender: UISlider) {
        setColorToColorView()
        
        switch sender.tag {
        case 0:
            redValueLabel.text = string(sender.value)
            redTextField.text = string(sender.value)
        case 1:
            greenValueLabel.text = string(sender.value)
            greenTextField.text = string(sender.value)
        case 2:
            blueValueLabel.text = string(sender.value)
            blueTextField.text = string(sender.value)
        default: break
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setBackgroung(color: colorView.backgroundColor!)
        dismiss(animated: true)
    }
    // MARK: - Public Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tempString = textField.text
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        replacementCommaOnDot(&textField.text)
        
        var colorValue: Float = 0
            
        if textField.text == "" {
            textField.text = tempString
            colorValue = Float(tempString ?? "0")!
        } else {
            colorValue = getFloat(from: textField)
            textField.text = string(colorValue)
        }
        setLabel(value: colorValue, accordingTo: textField)
        setSlider(value: colorValue, accordingTo: textField)
    }
    // MARK: - Privat Methods
    
    private func setTextFieldValue() {
        redTextField.text = string(redSlider.value)
        greenTextField.text = string(greenSlider.value)
        blueTextField.text = string(blueSlider.value)
    }

    private func setColorToColorView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    private func inicialSetColorView() {
        colorView.backgroundColor = viewBackgrounColor
    }
    
    private func setValueToSliders() {
        let ciColor = CIColor(color: viewBackgrounColor)
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func setValueFor(_ labels: UILabel...) {
        labels.forEach { label in
            switch label.tag {
            case 0: redValueLabel.text = string(from: redSlider)
            case 1: greenValueLabel.text = string(from: greenSlider)
            case 2: blueValueLabel.text = string(from: blueSlider)
            default: break
            }
        }
    }
}

// MARK: - Add "Done" button for keyboard
extension UITextField {
    func addDoneButtonOnKeyBoardWithControl() {
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneBarButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(endEditing(_:))
        )
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        inputAccessoryView = keyboardToolbar
    }
    
}


extension ColorSettingViewController {
    
    private func getFloat(from textField: UITextField) -> Float {

        let setValue = Float(textField.text ?? "0") ?? 0
        return setValue >= 0 && setValue <= 1 ? setValue : 1
    }
    
    private func setLabel(value: Float, accordingTo textField: UITextField) {
        switch textField.tag {
        case 0:
            redValueLabel.text = string(value)
            setValueFor(redValueLabel)
        case 1:
            greenValueLabel.text = string(value)
            setValueFor(greenValueLabel)
        case 2:
            blueValueLabel.text = string(value)
            setValueFor(blueValueLabel)
        default: break
        }
    }
    
    private func setSlider(value: Float, accordingTo textField: UITextField) {
        switch textField.tag {
        case 0:
            redSlider.value = value
            rgbSlidersAction(redSlider)
        case 1:
            greenSlider.value = value
            rgbSlidersAction(greenSlider)
        case 2:
            blueSlider.value = value
            rgbSlidersAction(blueSlider)
        default: break
        }
    }
    
    private func replacementCommaOnDot(_ string: inout String?)  {
        string = string?.replacingOccurrences(
                of: ",",
                with: "."
            )
    }
    
    // MARK: - Line shortening
    private func string(_ value: Float) -> String {
        String(format: "%.2f", value)
    }

    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}
