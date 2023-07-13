//
//  SecondViewController.swift
//  MasaKadai16
//
//  Created by Mina on 2023/07/14.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet private weak var inputTextField: UITextField!

    var editText = ""

    func getInputText() -> String {
        inputTextField.text ?? ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextField.text = editText
    }
}
