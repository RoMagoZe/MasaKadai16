//
//  SecondViewController.swift
//  MasaKadai16
//
//  Created by Mina on 2023/07/14.
//

import UIKit

class SecondViewController: UIViewController {

    enum Mode {
        struct AddParameter {
            let cancel: () -> Void
            let save: (String) -> Void
        }

        struct EditParameter {
            let name: String
            let cancel: () -> Void
            let save: (String) -> Void
        }

        case add(AddParameter)
        case edit(EditParameter)
    }

    @IBOutlet private weak var inputTextField: UITextField!

    var mode: Mode?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let mode = mode else { return }

        switch mode {
        case .add:
            inputTextField.text = ""
        case .edit(let parameter):
            inputTextField.text = parameter.name
        }
    }

    @IBAction func didTapCancel(_ sender: Any) {
        guard let mode = mode else { return }

        switch mode {
        case .add(let parameter):
            parameter.cancel()
        case .edit(let parameter):
            parameter.cancel()
        }
    }

    @IBAction func didTapSave(_ sender: Any) {
        guard let mode = mode else { return }

        switch mode {
        case .add(let parameter):
            parameter.save(inputTextField.text ?? "")
        case .edit(let parameter):
            parameter.save(inputTextField.text ?? "")
        }
    }
}
