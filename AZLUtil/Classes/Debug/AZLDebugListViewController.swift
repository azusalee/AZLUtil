//
//  KSDemoListViewController.swift
//  AZLUtil
//
//  Created by lizihong on 2021/3/2.
//

import UIKit

/**
debug列表页
 */
class AZLDebugListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /// debug用cellModel 数组，用于控制debug列表显示
    var cellModels: [AZLDebugListCellModel] = []

    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Debug List"
        self.tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        self.view.addSubview(self.tableView)
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "debugCell")

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Close", style: .plain, target: self, action: #selector(closeDebugList))
    }
    
    /// 关闭点击
    @objc
    func closeDebugList() {
        self.dismiss(animated: true, completion: nil)
    }

    /// 添加cell数据
    func addCell(cellModel: AZLDebugListCellModel) {
      
        cellModels.append(cellModel)
        self.tableView.reloadData()
    }

    // tableview回调
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "debugCell")
        cell?.separatorInset = .zero
        let cellModel = cellModels[indexPath.row]
        cell?.textLabel?.text = cellModel.title

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cellModel = cellModels[indexPath.row]
        if let actionBlock = cellModel.actionBlock {
            actionBlock()
        } else if let vcType = cellModel.vcType {
            let controller: UIViewController = vcType.init()
            controller.title = cellModel.title
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}

