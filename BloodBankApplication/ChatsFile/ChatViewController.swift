//
//  ChatViewController.swift
//  BloodBankApplication
//
//  Created by Mohammad Arsalan on 04/03/2019.
//  Copyright © 2019 Mohammad Arsalan. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.navigationItem.title = "The title"
        // Do any additional setup after loading the view.
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
    }
    var message : [Message] = []

//    @IBAction func composeButton(_ sender: Any) {
//        
//       let storyboard: UIStoryboard = UIStoryboard(name: "Donor", bundle: nil)
//        
//        let vc = storyboard.instantiateViewController(withIdentifier: "toDonor") as! DonorsViewController
//        
//        self.present(vc, animated: true, completion: nil)
//        
//        let width = vc.view.frame.width
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 400, height: 44))
//        vc.view.addSubview(navBar)
//        
//        let navItem = UINavigationItem(title: "SomeTitle")
//        let button1 = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: nil)
//        navItem.leftBarButtonItem = button1
//        
//        navBar.setItems([navItem], animated: false)
//        
//        //vc.viewWillAppear(true)
//        
//       // let button1 = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: nil)
//        // action:#selector(Class.MethodName) for swift 3
//       // vc.navigationItem.leftBarButtonItem  = button1
//        
//    }
    @IBOutlet weak var chatTableView: UITableView!
    
    
}
extension ChatViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        
        let messageArray = ["abc","dfs","asd"]
        cell.nameLbl.text = messageArray[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toChatListVC", sender: self)
    }
    
    
    
    
}

