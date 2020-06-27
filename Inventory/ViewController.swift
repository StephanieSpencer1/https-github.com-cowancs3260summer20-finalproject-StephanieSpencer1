//
//  ViewController.swift
//  Inventory
//
//  Created by Nicholas Spencer on 6/23/20.
//  Copyright © 2020 Stephanie Spencer. All rights reserved.
//

import UIKit

struct Item {
    var shortDescription: String = ""
    var longDescription: String = ""
}




var items: [Item] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddItemProtocol, EditItemProtocol {
 
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].shortDescription
        cell.detailTextLabel?.text = items[indexPath.row].longDescription
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          //edit row
          tableView.deselectRow(at: indexPath, animated: true)
          
      }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //delete row
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (action:UIContextualAction, sourceView: UIView, actionPerformed:(Bool) -> Void) in
            self.items.remove(at: indexPath.row)
            tableView.reloadData()
            actionPerformed(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
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
            editItem(items[itemIndex])
        }
        
    }
    
    func addItem(_ item: Item){
        items.append(item)
        tableView.reloadData()
    }
    
    func editItem(_ item: Item){
        items[itemIndex].shortDescription = item.shortDescription
        items[itemIndex].longDescription = item.longDescription
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Inventory"
        // Do any additional setup after loading the view.
       
    }
    



}

