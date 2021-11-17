//
//  ViewController.swift
//  TryWebAPI_JSON
//
//  Created by Fumitaka Imamura on 2021/11/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var searchText: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.delegate = self
        searchText.placeholder = "お菓子の名前を入力してください"
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let searchWord = searchBar.text {
            print(searchWord)
            searchOkashi(keyword: searchWord)
        }
    }

    private func searchOkashi(keyword: String) {
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else { return }
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r")
        else { return }
        print(req_url)
    }

}

