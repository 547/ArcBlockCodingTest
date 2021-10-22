//
//  ArcBlockDevCon2020TableViewController.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/20.
//

import UIKit

class ArcBlockDevCon2020TableViewController: UITableViewController {
    let viewModel = ArcBlockDevCon2020ViewModel()
    private var rowHeights = [String:CGFloat]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}
private extension ArcBlockDevCon2020TableViewController {
    func setupViews() -> () {
        setupNavigationBar()
        setupTableView()
    }
    func setupNavigationBar() -> () {
        title = "ArcBlock DevCon 2020"
    }
    
    func setupTableView() -> () {
        tableView.setRefreshView(refreshBlock: {[weak self] in
            self?.refresh()
        }, loadMoreBlock: nil)
        tableView.refresh()
    }
}
private extension ArcBlockDevCon2020TableViewController {
    func updateTableView() -> () {
        tableView.stopRefresh()
        tableView.reloadData()
    }
}
private extension ArcBlockDevCon2020TableViewController {
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
extension ArcBlockDevCon2020TableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        var result = 0
        guard let _ = viewModel.data else {
            return result
        }
        result = 2
        return result

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = 0
        guard let data = viewModel.data else {
            return result
        }
        if section == 0 {
            result = 1
        } else {
            result = data.imgUrls?.count ?? 0
        }
        return result
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        guard let data = viewModel.data else {
            return UITableViewCell()
        }
        if section == 0 {
            let cell = getTextCell()
            cell.textLabel?.text = data.content
            return cell
        } else {
            if let imgUrls = data.imgUrls, imgUrls.count > row {
                let imgUrl = imgUrls[row]
                let cell = getLargeImageCell()
                cell.mainImageView.setImage(imgUrl, placeholder: UIImage(imageLiteralResourceName: "default"))
                return cell
            }else {
                return UITableViewCell()
            }
        }
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        let key = "\(section)\(row)"
        let height = cell.frame.height
        rowHeights[key] = height
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let key = "\(indexPath.section)\(indexPath.row)"
        guard let height = rowHeights[key] else { return UITableView.automaticDimension }
        return height
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
private extension ArcBlockDevCon2020TableViewController {
    func refresh() -> () {
        updateTableView()
    }
}
