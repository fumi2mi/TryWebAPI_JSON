//
//  ViewController.swift
//  TryWebAPI_JSON
//
//  Created by Fumitaka Imamura on 2021/11/17.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak private var searchText: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.delegate = self
        searchText.placeholder = "お菓子の名前を入力してください"
    }
}

