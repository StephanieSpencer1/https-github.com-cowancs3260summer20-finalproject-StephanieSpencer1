//
//  ViewController.swift
//  Inventory
//
//  Created by Nicholas Spencer on 6/23/20.
//  Copyright © 2020 Stephanie Spencer. All rights reserved.
//

import UIKit

struct Item {
    var shortDerscription: String = ""
    var longDescription: String = ""
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddItemProtocol, EditItemProtocol {
    func modTitles(){
        
    }
    func getTitles() {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    var items: [Item]! = []
    var itemIndex: Int!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "addSegue" {
            let view = segue.destination as! AddViewController
            view.delegate = self
        } else if segue.identifier == "editSegue" {
            let view = segue.destination as! EditViewController
            view.delegate = self
            itemIndex = tableView.indexPathForSelectedRow?.row
            view.item.shortDescription = items[itemIndex].shortDescription
            view.item.longDescription = items[itemIndex].longDescription
        }
    }
    
    func addItem(_ item: Item){
        items.append(item)
        tableView.reloadData()
    }
    
    func editItem(_ item: Item){
        items[itemBeingEdited].shortDescription = item.shortDescription
        items[itemBeingEdited].longDescription = item.longDescription
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

