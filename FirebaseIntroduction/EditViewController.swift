//
//  EditViewController.swift
//  FirebaseIntroduction
//
//  Created by Nattapong Unaregul on 8/13/17.
//  Copyright © 2017 Nattapong Unaregul. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var lb_identifier: UILabel!
    @IBOutlet weak var tb_name: UITextField!
    var fbApi : FBApi!
    var product : Product!
    var indexPath : IndexPath!
    @IBAction func action_done(_ sender: Any) {
        product.name = tb_name.text
        fbApi.update(product: product)
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fbApi = FBApi()
        lb_identifier.text = product.id
        tb_name.text = product.name
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
