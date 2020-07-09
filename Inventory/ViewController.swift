//
//  ViewController.swift
//  Inventory
//
//  Created by Nicholas Spencer on 6/23/20.
//  Copyright © 2020 Stephanie Spencer. All rights reserved.
//

import UIKit
import SQLite3


struct Item {
    var shortDescription: String = ""
    var longDescription: String = ""
}




var items: [Item] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddItemProtocol, EditItemProtocol {
    
    var db: OpaquePointer?
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].shortDescription
        cell.detailTextLabel?.text = items[indexPath.row].longDescription
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
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
            view.shortDescription = items[itemIndex].shortDescription
            view.longDescription = items[itemIndex].longDescription
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
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveToDatabase(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        let fileUrl = try!
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Inventory.sqlite")
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
            print("Error opening database")
            return
        }
        let createTableQuery = "CREATE TABLE IF NOT EXISTS Items (id INTEGER PRIMARY KEY AUTOINCREMENT, shortDescription VARCHAR, longDescription VARCHAR)"
        
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error creating table")
            return
        }
        //retrieve each item, initilize item object and append itme to items array
        items.removeAll()
        let selectQuery = "SELECT * FROM Items"
        var stmt:OpaquePointer?
        if sqlite3_prepare(db, selectQuery, -1, &stmt, nil) != SQLITE_OK {
            print("error preparing insert")
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let short = String(cString: sqlite3_column_text(stmt, 1))
            let long = String(cString: sqlite3_column_text(stmt, 2))
            items.append(Item.init(shortDescription: short, longDescription: long))
        }
                
    }
    @objc func saveToDatabase(_ notification:Notification){
        //open DB??
      
        //execute delete from items to clear db
        
        //for each itme in array intert into db
        for item in items{
            //call prepare
            let shortDescription = item.shortDescription
            let longDescription = item.longDescription
            var stmt: OpaquePointer?
            let insertQuery = "INSERT INTO Items (shortDescription, longDescription) Values (?,?)"
            if sqlite3_prepare(db, insertQuery, -1, &stmt, nil) != SQLITE_OK{
                print("Error binding query")
            }
            //call bind
            if sqlite3_bind_text(stmt, 1, (shortDescription as NSString).utf8String, -1, nil) != SQLITE_OK {
                print("error binding shortDescription")
            }
            if sqlite3_bind_text(stmt, 2, (longDescription as NSString).utf8String, -1, nil) != SQLITE_OK {
                           print("error binding shortDescription")
                       }
            //call step
            sqlite3_step(stmt)
        }
            
        //close db
        sqlite3_close(db)

    }



}

