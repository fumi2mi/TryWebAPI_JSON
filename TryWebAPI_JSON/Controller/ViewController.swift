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
    var okashiList: [(name: String, maker: String, link: URL, image: URL)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.delegate = self
        searchText.placeholder = "お菓子の名前を入力してください"
        tableView.dataSource = self
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let searchWord = searchBar.text {
            searchOkashi(keyword: searchWord)
        }
    }

    private func searchOkashi(keyword: String) {
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else { return }
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r")
        else { return }

        let req = URLRequest(url: req_url)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: req) { data, response, error in
            session.finishTasksAndInvalidate()
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self, from: data!)
                if let items = json.item {
                    self.okashiList.removeAll()
                    for item in items {
                        if let name = item.name, let maker = item.maker, let link = item.url, let image = item.image {
                            let okashi = (name, maker, link, image)
                            self.okashiList.append(okashi)
                        }
                    }
                    self.tableView.reloadData()
                    if let okashidbg = self.okashiList.first {
                        print("---------")
                        print("okashiList[0] = \(okashidbg)")
                    }
                }
            } catch {
                print("エラー発生")
            }
        }
        task.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return okashiList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = okashiList[indexPath.row].name
        if let imageData = try? Data(contentsOf: okashiList[indexPath.row].image) {
            cell.imageView?.image = UIImage(data: imageData)
        }
        return cell
    }
}
