//
//  ArcBlockABTNodeTableViewController.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/20.
//

import UIKit

class ArcBlockABTNodeTableViewController: UITableViewController {
    let viewModel = ArcBlockABTNodeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}
private extension ArcBlockABTNodeTableViewController {
    func setupViews() -> () {
        setupNavigationBar()
        setupTableView()
    }
    func setupNavigationBar() -> () {
        title = "ArcBlock ABT Node"
    }
    
    func setupTableView() -> () {
        tableView.setRefreshView(refreshBlock: {[weak self] in
            self?.refresh()
        }, loadMoreBlock: nil)
        tableView.refresh()
    }
}
private extension ArcBlockABTNodeTableViewController {
    func updateTableView() -> () {
        tableView.stopRefresh()
        tableView.reloadData()
    }
}
private extension ArcBlockABTNodeTableViewController {
    func getLargeImageCell() -> LargeImageTableViewCell {
        let identifier = "LargeImageTableViewCell"
        let result: LargeImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) { _ in
            let cell = LargeImageTableViewCell(style: .default, reuseIdentifier: identifier)
            return cell
        }
        return result
    }
    func getTextCell() -> UITableViewCell {
        let identifier = "UITableViewCellText"
        let result: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) { _ in
            let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            return cell
        }
        return result
    }
}
// MARK: - Table view data source
extension ArcBlockABTNodeTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = 0
        guard let data = viewModel.data else {
            return result
        }
        result = 1 + (data.imgUrls?.count ?? 0)
        return result
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        guard let data = viewModel.data else {
            return UITableViewCell()
        }
        if row == 0 {
            if let imgUrl = data.imgUrls?.first {
                let cell = getLargeImageCell()
                cell.mainImageView.setImage(imgUrl, placeholder: UIImage(imageLiteralResourceName: "default"))
                return cell
            }else {
                return UITableViewCell()
            }
        } else {
            let cell = getTextCell()
            cell.textLabel?.text = data.content
            return cell
        }

    }
}
private extension ArcBlockABTNodeTableViewController {
    func refresh() -> () {
        updateTableView()
    }
}
