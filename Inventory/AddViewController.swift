//
//  AddViewController.swift
//  Inventory
//
//  Created by Nicholas Spencer on 6/23/20.
//  Copyright © 2020 Stephanie Spencer. All rights reserved.
//

import UIKit

protocol AddItemProtocol{
    func addItem(_ item: Item)
}

class AddViewController: UIViewController {
  
    var delegate: AddItemProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
        self.navigationItem.rightBarButtonItem = save
        self.navigationItem.title = "Add New Item"
        // Do any additional setup after loading the view.
        
    }
    
    @IBOutlet weak var shortDesField: UITextField!
    @IBOutlet weak var longDesField: UITextView!
    @objc func handleSave(){
        //set up and call the function specified by the protocol
        let short: String = shortDesField.text!
        let long: String = longDesField.text
        var addItem = Item()
        addItem.longDescription = long
        addItem.shortDescription = short
        delegate.addItem(addItem)
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
