//
//  ViewController.swift
//  MasaKadai16
//
//  Created by Mina on 2023/07/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var items = Fruits.defaultItems
    private let checkMark = UIImage(named: "check-mark")
    private var selectedIndexPath: IndexPath?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "addSegue" {
            guard let navigationController = segue.destination as? UINavigationController,
                  let secondViewController = navigationController.topViewController as? SecondViewController else {
                return
            }

            secondViewController.mode = .add(
                SecondViewController.Mode.AddParameter(
                    cancel: { [weak self] in
                        self?.dismiss(animated: true)
                    },
                    save: { [weak self] newName in
                        self?.items.append((newName, false))
                        self?.tableView.reloadData()

                        self?.dismiss(animated: true)
                    }
                )
            )
        } else if segue.identifier == "AccessorySegue" {
            guard let indexPath = selectedIndexPath else { return }

            guard let navigationController = segue.destination as? UINavigationController,
                  let secondViewController = navigationController.topViewController as? SecondViewController else {
                return
            }

            secondViewController.mode = .edit(
                SecondViewController.Mode.EditParameter(
                    name: items[indexPath.row].0,
                    cancel: { [weak self] in
                        self?.dismiss(animated: true)
                    },
                    save: { [weak self] newName in
                        guard let strongSelf = self else { return }

                        strongSelf.items[indexPath.row] = (newName, strongSelf.items[indexPath.row].1)
                        strongSelf.tableView.reloadData()

                        strongSelf.dismiss(animated: true)
                    }
                )
            )
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用しているので、表示していた以前の状態や内容が残っている
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let item = items[indexPath.row]
        cell.textLabel?.text = item.0
        cell.imageView?.image = item.1 ? checkMark : nil

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        items[indexPath.row].1.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "AccessorySegue", sender: nil)
    }
}
