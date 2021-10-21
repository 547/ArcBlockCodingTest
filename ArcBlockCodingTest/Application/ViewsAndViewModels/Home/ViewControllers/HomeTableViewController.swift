//
//  HomeTableViewController.swift
//  ArcBlockCodingTest
//
//  Created by wangqi on 2021/10/20.
//

import UIKit
import SW_MJRefresh
import SWCommonExtensions
import SWLog
class HomeTableViewController: UITableViewController {
    let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
            setupViews()
        }
}
private extension HomeTableViewController {
    func setupViews() -> () {
        setupNavigationBar()
        setupTableView()
    }
    func setupNavigationBar() -> () {
        title = "ArcBlock"
    }
    
    func setupTableView() -> () {
        tableView.setRefreshView(refreshBlock: {[weak self] in
            self?.refresh()
        }, loadMoreBlock: nil)
        tableView.refresh()
    }
}
private extension HomeTableViewController {
    func updateTableView() -> () {
        tableView.stopRefresh()
        tableView.reloadData()
    }
}
private extension HomeTableViewController {
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
    func getTextImgCell() -> UITableViewCell {
        let identifier = "UITableViewCellTextImg"
        let result: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) { _ in
            let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            return cell
        }
        return result
    }

}
// MARK: - Table view data source
extension HomeTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        let result = viewModel.datas.count
        return result
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = 0
        guard viewModel.datas.count > section else {
            return result
        }
        let data = viewModel.datas[section]
        if data.type == .img {
            result = data.imgUrls?.count ?? 0
        } else {
            result = 1
        }
        return result
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        guard viewModel.datas.count > section else {
            return UITableViewCell()
        }
        let data = viewModel.datas[section]
        switch data.type {
        case .text:
            let cell = getTextCell()
            cell.textLabel?.text = data.content
            return cell
        case .img:
            if let imgUrls = data.imgUrls, imgUrls.count > row {
                let imgUrl = imgUrls[row]
                let cell = getLargeImageCell()
                cell.mainImageView.setImage(imgUrl, placeholder: UIImage(imageLiteralResourceName: "default"))
                return cell
            }else {
                return UITableViewCell()
            }
        case .textImg, .textLink:
            let cell = getTextImgCell()
            cell.textLabel?.text = data.title
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        guard viewModel.datas.count > section else {
            return
        }
        let data = viewModel.datas[section]
        switch data.type {
        case .textImg:
            if data.id == 3 {
                pushToArcBlockDevCon2020(data)
            }
            if data.id == 4 {
                pushToArcBlockABTNode(data)
            }
        case .textLink:
            pushToArcBlockABTWallet(data)
        default:
            break
        }
    }

}
private extension HomeTableViewController {
    func refresh() -> () {
        viewModel.refresh {[weak self] err in
            self?.updateTableView()
        }
    }
}
private extension HomeTableViewController {
    func pushToArcBlockDevCon2020(_ data: HomeData) -> () {
        guard let viewController = ViewControllerCenter.getArcBlockDevCon2020TableViewController() else { return }
        viewController.viewModel.data = data
        navigationController?.pushViewController(viewController, animated: true)
    }
    func pushToArcBlockABTNode(_ data: HomeData) -> () {
        guard let viewController = ViewControllerCenter.getArcBlockABTNodeTableViewController() else { return }
        viewController.viewModel.data = data
        navigationController?.pushViewController(viewController, animated: true)
    }
    func pushToArcBlockABTWallet(_ data: HomeData) -> () {
        guard let viewController = ViewControllerCenter.getCommonWebViewController() else { return }
        viewController.viewModel.urlString = data.link
        viewController.viewModel.navigationTitle = data.title
        navigationController?.pushViewController(viewController, animated: true)

    }
}
