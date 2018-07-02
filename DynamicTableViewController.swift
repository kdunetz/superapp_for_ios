//
//  DynamicTableViewController.swift
//  IoTstarter
//
//  Created by Kevin Dunetz on 6/8/18.
//  Copyright © 2018 Mike Robertson. All rights reserved.
//

import UIKit

class DynamicTableViewController: UITableViewController {

    var users:[NSDictionary] = []
    var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsersFromApi()
        
        
        navigationItem.title = "Users List"
        navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:
            #selector(showAddUserAlertController))
        
        self.setNavigationBar()
    
        // Do any additional setup after loading the view.
    }
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 22))
        let navItem = UINavigationItem(title: "Dynamic Table")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: "selector")
        navItem.rightBarButtonItem = doneItem
        let leftItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: nil, action: #selector(showAddUserAlertController));
        navItem.leftBarButtonItem = leftItem;
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadUsersFromApi() {
        users = [
            [
                "id": 1,
                "name" : "John Doe",
                ],
            [
                "id": 2,
                "name": "Jane Doe"
            ]
        ]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath)
        cell.textLabel?.text = users[indexPath.row]["name"] as! String?
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = users[sourceIndexPath.row]
        users.remove(at: sourceIndexPath.row)
        users.insert(movedObject, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.users.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row: \(indexPath.row)")
        
            let storyboard: UIStoryboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
            let vc = DynamicObjectViewController()
        
            //let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "cameraID") as UIViewController
            self.present(vc, animated: true, completion: nil)
       
    }

    public func showAddUserAlertController() {
        if #available(iOS 8.0, *) {
            let alertCtrl = UIAlertController(title: "Add User", message: "Add a user to the list", preferredStyle: .alert)
  
        
        // Add text field to alert controller
        alertCtrl.addTextField { (textField) in
            self.textField = textField
            self.textField.autocapitalizationType = .words
            self.textField.placeholder = "e.g John Doe"
        }
        
        // Add cancel button to alert controller
        alertCtrl.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // "Add" button with callback
        alertCtrl.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            if let name = self.textField.text, name != "" {
                self.users.append(["id": self.users.count, "name" :name])
                self.tableView.reloadData()
            }
        }))
        
        present(alertCtrl, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
}
