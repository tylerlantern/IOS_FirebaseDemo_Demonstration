//
//  ViewController.swift
//  FirebaseIntroduction
//
//  Created by Nattapong Unaregul on 8/9/17.
//  Copyright © 2017 Nattapong Unaregul. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class ViewController: UIViewController {
    let identifer = "cellIdentifier"
    let viewModel = ViewModel()
    @IBOutlet weak var tb_input: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.initilization()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func action_add(_ sender: Any) {
        viewModel.addProduct(name: tb_input.text)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeProduct(indexPath: indexPath)
        }
    }
    deinit {
        print("deinit")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_editVc" {
            let indexPath = sender as! IndexPath
            let product = viewModel.products[indexPath.item]
            let editVc = segue.destination as! EditViewController
            editVc.product = product
            editVc.indexPath = indexPath
        }
    }
}
extension ViewController : ViewModelDelegate {
    func didFinishUpdate(indexPath: IndexPath, product: Product) {
        guard let visibleRows = self.tableView.indexPathsForVisibleRows else {
            return
        }
        for (_,value) in visibleRows.enumerated() {
            if value  == indexPath {
                guard let cell = tableView.cellForRow(at: value) else {
                    return
                }
                cell.textLabel?.text = viewModel.getTitleIndexPath(indexPath: value)
                break
            }
            
        }
    }
    
    func didAppendData(indexPath: IndexPath) {
        self.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    func didFinishLoadDataOnInitilization() {
        self.tableView.reloadData()
    }
    func didRemoveData(indexPath: IndexPath) {
        self.tableView.deleteRows(at: [indexPath], with: .left)
    }
}
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath)
        cell.textLabel?.text = viewModel.getTitleIndexPath(indexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue_editVc", sender: indexPath)
    }
}

