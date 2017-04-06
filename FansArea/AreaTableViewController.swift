//
//  AreaTableViewController.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/4/4.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

import UIKit

class AreaTableViewController: UITableViewController {
    
    var areas = [
        Area(name: "闵行区莘庄镇", province: "上海", part: "华东", image: "baiyun", isvisited: false),
        Area(name: "兰州七里河区", province: "甘肃", part: "西北", image: "chengxi", isvisited: false),
        Area(name: "三明市尤溪县", province: "福建", part: "东南", image: "furong", isvisited: false),
        Area(name: "西宁城西区", province: "青海", part: "西北", image: "jinping", isvisited: false),
        Area(name: "广州白云区", province: "广东", part: "华南", image: "nangang", isvisited: false),
        Area(name: "闽侯县上街镇", province: "福建", part: "东南", image: "qilihe", isvisited: false),
        Area(name: "哈尔滨市南岗区", province: "黑龙江", part: "东北", image: "shangjie", isvisited: false),
        Area(name: "临汾市尧都区", province: "山西", part: "华北", image: "wuhou", isvisited: false),
        Area(name: "成都武侯区", province: "四川", part: "西南", image: "xining", isvisited: false),
        Area(name: "汕头市金平区", province: "广东", part: "华南", image: "xinzhuang", isvisited: false),
        Area(name: "长沙市芙蓉区", province: "湖南", part: "华中", image: "yaodu", isvisited: false)
    ]
//    var areas = ["闵行区莘庄镇","兰州七里河区","三明市尤溪县","西宁城西区","广州白云区","闽侯县上街镇","哈尔滨市南岗区","临汾市尧都区","成都武侯区","汕头市金平区","长沙市芙蓉区"]
//    var provinces = ["上海","甘肃","福建","青海","广东","福建","黑龙江","山西","四川","广东","湖南"]
//    var parts = ["华东","西北","东南","西北","华南","东南","东北","华北","西南","华南","华中"]
//    var areaImages = ["baiyun","chengxi","furong","jinping","nangang","qilihe","shangjie","wuhou","xining","xinzhuang","yaodu","youxi"]
//    var visited = [Bool](repeatElement(false, count: 11))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view delegate
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let menu = UIAlertController(title: "同学你好", message: "您点击了第\(indexPath.row)行", preferredStyle: .actionSheet)
//        let option1 = UIAlertAction(title: "OK", style: .default, handler: nil)
//        let option2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        let option3 = UIAlertAction(title: "Delete", style: .destructive, handler: nil)
//        let option4 = UIAlertAction(title: "Visited", style: .destructive) { (_) in
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//            self.visited[indexPath.row] = true
//        }
//        menu.addAction(option1)
//        menu.addAction(option2)
//        menu.addAction(option3)
//        menu.addAction(option4)
//        self.present(menu, animated: true, completion: nil)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (_, indexPath) in
            
            let actionSheet = UIAlertController(title: "Share", message: nil, preferredStyle: .actionSheet)
            let option1 = UIAlertAction(title: "QQ", style: .default, handler: nil)
            let option2 = UIAlertAction(title: "WeChat", style: .default, handler: nil)
            let option3 = UIAlertAction(title: "Weibo", style: .default, handler: nil)
            let option4 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            actionSheet.addAction(option1)
            actionSheet.addAction(option2)
            actionSheet.addAction(option3)
            actionSheet.addAction(option4)
            
            self.present(actionSheet, animated: true, completion: nil)
        }
        shareAction.backgroundColor = UIColor.orange
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, indexPath) in

            self.areas.remove(at: indexPath.row)
//            self.areaImages.remove(at: indexPath.row)
//            self.areas.remove(at: indexPath.row)
//            self.parts.remove(at: indexPath.row)
//            self.provinces.remove(at: indexPath.row)
//            self.visited.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let topAction = UITableViewRowAction(style: .normal, title: "Top") { (_, indexPath) in

            self.areas.insert(self.areas[indexPath.row], at: 0)
            self.areas.remove(at: indexPath.row + 1)

//            self.areas.insert(self.areas[indexPath.row], at: 0)
//            self.areas.remove(at: indexPath.row + 1)
//            
//            self.areaImages.insert(self.areaImages[indexPath.row], at: 0)
//            self.areaImages.remove(at: indexPath.row + 1)
//            
//            self.provinces.insert(self.provinces[indexPath.row], at: 0)
//            self.provinces.remove(at: indexPath.row + 1)
//            
//            self.parts.insert(self.parts[indexPath.row], at: 0)
//            self.parts.remove(at: indexPath.row + 1)
//            
//            self.visited.insert(self.visited[indexPath.row], at: 0)
//            self.visited.remove(at: indexPath.row + 1)
            
            tableView.reloadData()
        }
        
        let visitedAction = UITableViewRowAction(style: .normal, title: "Visited") { (_, indexPath) in
            self.areas[indexPath.row].isvisited = true
            tableView.reloadData()
        }
        
        return [shareAction, deleteAction, topAction, visitedAction]
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return areas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
/*
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = areas[indexPath.row]
        cell.imageView?.image = UIImage(named: areaImage[indexPath.row])
*/
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.nameLabel.text = areas[indexPath.row].name
        cell.provinceLabel.text = areas[indexPath.row].province
        cell.partLable.text = areas[indexPath.row].part
        cell.thumbImageView.image = UIImage(named: areas[indexPath.row].image)
        cell.thumbImageView.layer.cornerRadius = cell.thumbImageView.frame.size.height / 2
        cell.thumbImageView.clipsToBounds = true
        
        if areas[indexPath.row].isvisited {
            cell.accessoryType = .checkmark
        }   else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.areaImages.remove(at: indexPath.row)
//            self.areas.remove(at: indexPath.row)
//            self.parts.remove(at: indexPath.row)
//            self.provinces.remove(at: indexPath.row)
//            self.visited.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
////            tableView.reloadData()
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
    

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showAreaDetail" {
//            let dest = segue.destination as! AreaDetailViewController
            let dest = segue.destination as! DetailTableViewController
            dest.area = areas[tableView.indexPathForSelectedRow!.row]
        }
    }
}
