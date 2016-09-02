//
//  ViewController.swift
//  alamofirejson
//
//  Created by maisapride8 on 01/09/16.
//  Copyright © 2016 maisapride8. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MarkupKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet var tableView: UITableView!
    var arrRES = [[String: AnyObject]]()// Array of dictionary.
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "jsonCell")

        
       /*
        Alamofire.request(.GET, "http://api.androidhive.info/contacts/").response {(req, res,data, error) -> Void in
            print("res:  \(res)")
            
            let outputString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(outputString)
        }*/
        Alamofire.request(.GET, "http://api.androidhive.info/contacts/").responseJSON { (responseData) in
           // print(response.request)
            //print(response.response)
           //print(response.data)
             //print(response.result)
            if((responseData.result.value) != nil){
            let swiftyJSONvar = JSON(responseData.result.value!)
                print(swiftyJSONvar)
                if let resData = swiftyJSONvar["contacts"].arrayObject {
                    self.arrRES = resData as! [[String: AnyObject]]
                }
                if self.arrRES.count > 0 {
                    
                    self.tableView.reloadData()
                   // print("tbleJSON reloaded")
                }
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(arrRES.count)
        return arrRES.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("jsonCell")!
        print("HEllo")
        cell = UITableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier: "jsonCell")
        print("Hii")
        /*if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.textLabel, reuseIdentifier: <#T##String?#>)
        }*/
        var dict = arrRES[indexPath.row]
        cell.textLabel?.text = dict["name"] as? String
        cell.detailTextLabel?.text = dict["email"] as? String
        return cell
    }
}

