//
//  DetailTableViewController.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/4/5.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var DetailImage: UIImageView!

    
    var area: AreaMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailImage.image = UIImage(data: area.image as! Data)
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)
        
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.title = area.name
        
        if let rating = area.rating{
            self.area.rating = rating
            self.ratingButton.setImage(UIImage(named: rating), for: .normal)
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
        
        cell.backgroundColor = UIColor.clear
        // Configure the cell...
        
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = area.name
        case 1:
            cell.fieldLabel.text = "Province"
            cell.valueLabel.text = area.province
        case 2:
            cell.fieldLabel.text = "Part"
            cell.valueLabel.text = area.part
        case 3:
            cell.fieldLabel.text = "isVisited?"
            cell.valueLabel.text = area.isvisited ? "Yes" : "No"
        default:
            break
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReview" {
            let dest = segue.destination as! ReviewViewController
            dest.area = self.area
        }
        if segue.identifier == "showMap" {
            let dest = segue.destination as! MapViewController
            dest.area = self.area
        }
//        if segue.identifier == "editSegue"{
//            let dest = segue.destination as! AddAreaController
//            dest.area = self.area
//            dest.imageText.text = ""
//            dest.coverImageView.image = UIImage(data: self.area.image as! Data)
//            dest.coverImageView.contentMode = .scaleAspectFill
//            dest.coverImageView.clipsToBounds = true
//            dest.nameText.text = self.area.name
//            dest.partText.text = self.area.part
//            dest.provinceText.text = self.area.province
//            dest.isvisited = self.area.isvisited
//            dest.visitedText.text = self.area.isvisited ? "我去过！" : "我没去过。"
//            dest.isEdited = true
//            dest.dataManagementStart()
//        }
    }

    
    @IBAction func close(segue: UIStoryboardSegue){
        let reviewVC = segue.source as! ReviewViewController
        
        if let rating = reviewVC.rating{
            self.area.rating = rating
            self.ratingButton.setImage(UIImage(named: rating), for: .normal)
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        
    }

}
