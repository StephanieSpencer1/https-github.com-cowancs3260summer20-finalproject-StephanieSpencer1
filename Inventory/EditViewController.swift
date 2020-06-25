//
//  EditViewController.swift
//  Inventory
//
//  Created by Nicholas Spencer on 6/23/20.
//  Copyright © 2020 Stephanie Spencer. All rights reserved.
//

import UIKit


protocol EditItemProtocol{
    func editItem(_ item: Item)
}

class EditViewController: UIViewController {
  
    
    var delegate: EditItemProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveItem))
        self.navigationItem.rightBarButtonItem = save
        

        // Do any additional setup after loading the view.
    }
    //add links to text field and text box
    
    @IBOutlet weak var shortField: UITextField!
    
    @IBOutlet weak var longField: UITextView!
    
    @objc func saveItem(){
        //set up and call the function specified by the protocol
        let short: String = shortField.text!
        let long: String = longField.text
        var newItem = Item()
        newItem.longDescription = long
        newItem.shortDescription = short
        delegate.editItem(newItem)
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
