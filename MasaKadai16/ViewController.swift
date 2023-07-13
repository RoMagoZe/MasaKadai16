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
    private var isEditStatus = false
    private var isSelectedChecked: Bool? // check-markのステータス

    @IBAction func save(segue: UIStoryboardSegue) {

        let secondVC = segue.source as? SecondViewController
        guard let label = secondVC?.getInputText() else { return }

        if isEditStatus {
            guard let selectedRow = selectedIndexPath?.row, let isCheckd = isSelectedChecked else { return }
            items[selectedRow] = (label, isCheckd)
            isEditStatus = false
        } else {
            items.append((label, false))
        }
        tableView.reloadData()
    }

    @IBAction func cancel(segue: UIStoryboardSegue) {}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "addSegue" {
            isEditStatus = false // 新規で項目を追加するときにフラグをリセット
        } else if segue.identifier == "AccessorySegue" {
            guard let indexPath = selectedIndexPath else { return }
            let navVC = segue.destination as? UINavigationController
            let secondVC = navVC?.topViewController as? SecondViewController
            secondVC?.editText = items[indexPath.row].0
            isSelectedChecked = items[indexPath.row].1
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
        isEditStatus = true
        performSegue(withIdentifier: "AccessorySegue", sender: nil)
    }
}
