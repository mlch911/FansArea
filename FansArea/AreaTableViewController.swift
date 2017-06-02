//
//  AreaTableViewController.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/4/4.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

import UIKit
import CoreData

class AreaTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var areas :[AreaMO] = [

    ]
    
    var fc :NSFetchedResultsController<AreaMO>!
    
    var sc :UISearchController!
    var searchResult :[AreaMO]?
    func searchFilter(text :String) {
        searchResult = areas.filter({ (area) -> Bool in
            return (area.name!.localizedCaseInsensitiveContains(text))
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if var text = searchController.searchBar.text {
            text = text.trimmingCharacters(in: .whitespaces)
            searchFilter(text: text)
            tableView.reloadData()
        }
    }
    
//    var areas = ["闵行区莘庄镇","兰州七里河区","三明市尤溪县","西宁城西区","广州白云区","闽侯县上街镇","哈尔滨市南岗区","临汾市尧都区","成都武侯区","汕头市金平区","长沙市芙蓉区"]
//    var provinces = ["上海","甘肃","福建","青海","广东","福建","黑龙江","山西","四川","广东","湖南"]
//    var parts = ["华东","西北","东南","西北","华南","东南","东北","华北","西南","华南","华中"]
//    var areaImages = ["baiyun","chengxi","furong","jinping","nangang","qilihe","shangjie","wuhou","xining","xinzhuang","yaodu","youxi"]
//    var visited = [Bool](repeatElement(false, count: 11))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        tableView.tableHeaderView = sc.searchBar
        sc.dimsBackgroundDuringPresentation = false
//        sc.searchBar.barTintColor = UIColor(red: 242/255, green: 116/255, blue: 119/255, alpha: 1)
//        sc.searchBar.tintColor = UIColor.white
        sc.searchBar.searchBarStyle = .minimal
        sc.searchBar.placeholder = "输入地区名进行搜索"
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        fetchAllData2()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "GuideShow"){
            if let pageVC = storyboard?.instantiateViewController(withIdentifier: "GuideView") as? GuideViewController {
                present(pageVC, animated: true, completion: nil)
            }
        }
        
//        fetchAllData()
//        tableView.reloadData()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            tableView.reloadData()
        }
        if let object = controller.fetchedObjects{
            areas = object as! [AreaMO]
        }
    }
    
    func fetchAllData2() {
        let request:NSFetchRequest<AreaMO> = AreaMO.fetchRequest()
        let top = NSSortDescriptor(key: "isTop", ascending: true)
        let sd = NSSortDescriptor(key: "addTime", ascending: true)
        request.sortDescriptors = [top,sd]
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        fc = NSFetchedResultsController(fetchRequest: request , managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fc.delegate = self
        
        do {
            try fc.performFetch()
            if let object = fc.fetchedObjects{
                areas = object
            }
        } catch  {
            print(error)
        }
        
    }
    
    
//    func fetchAllData()  {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//        do {
//            areas = try appDelegate.persistentContainer.viewContext.fetch(AreaMO.fetchRequest())
//        } catch  {
//            print(error)
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view delegate
    
    func saveData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
    }
    
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

//            self.areas.remove(at: indexPath.row)
//            self.areaImages.remove(at: indexPath.row)
//            self.areas.remove(at: indexPath.row)
//            self.parts.remove(at: indexPath.row)
//            self.provinces.remove(at: indexPath.row)
//            self.visited.remove(at: indexPath.row)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(self.fc.object(at: indexPath))
            appDelegate.saveContext()
            
            
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let topAction = UITableViewRowAction(style: .normal, title: "Top") { (_, indexPath) in

//            self.areas.insert(self.areas[indexPath.row], at: 0)
//            self.areas.remove(at: indexPath.row + 1)
//
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
            
            
            self.areas[indexPath.row].isTop = 0
            self.saveData()
//            tableView.reloadData()
        }
        
        let nottopAction = UITableViewRowAction(style: .normal, title: "notTop") { (_, indexPath) in
            self.areas[indexPath.row].isTop = 1
            self.saveData()
//            tableView.reloadData()
        }
        
        let visitedAction = UITableViewRowAction(style: .normal, title: "Visited") { (_, indexPath) in
            self.areas[indexPath.row].isvisited = true
//            tableView.reloadData()
            self.saveData()
        }
        visitedAction.backgroundColor = UIColor.brown
        
        let notvisitedAction = UITableViewRowAction(style: .normal, title: "notVisited") { (_, indexPath) in
            self.areas[indexPath.row].isvisited = false
//            tableView.reloadData()
            self.saveData()
        }
        notvisitedAction.backgroundColor = UIColor.brown
        
        if self.areas[indexPath.row].isvisited && self.areas[indexPath.row].isTop == 0 {
            return [shareAction, deleteAction, nottopAction, notvisitedAction]
        }
        else if self.areas[indexPath.row].isvisited {
            return [shareAction, deleteAction, topAction, notvisitedAction]
        }
        else if self.areas[indexPath.row].isTop == 0 {
            return [shareAction, deleteAction, nottopAction, visitedAction]
        }
        else{
            return [shareAction, deleteAction, topAction, visitedAction]
        }
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sc.isActive ? (searchResult?.count)! : areas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
/*
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = areas[indexPath.row]
        cell.imageView?.image = UIImage(named: areaImage[indexPath.row])
*/
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let area = sc.isActive ? searchResult?[indexPath.row] : areas[indexPath.row]
        
        cell.nameLabel.text = area?.name
        cell.provinceLabel.text = area?.province
        cell.partLable.text = area?.part
        cell.thumbImageView.image = UIImage(data: area?.image as! Data)
        cell.thumbImageView.layer.cornerRadius = cell.thumbImageView.frame.size.height / 4
        cell.thumbImageView.clipsToBounds = true
        
        if (area?.isvisited)! {
            cell.accessoryType = .checkmark
        }   else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !sc.isActive
    }
    

    
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
    
    @IBAction func backToMain(segue: UIStoryboardSegue) {
    
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showAreaDetail" {
//            let dest = segue.destination as! AreaDetailViewController
            let dest = segue.destination as! DetailTableViewController
//            dest.hidesBottomBarWhenPushed = true
            dest.area = sc.isActive ? searchResult?[tableView.indexPathForSelectedRow!.row] : areas[tableView.indexPathForSelectedRow!.row]
        }
    }
    
}
