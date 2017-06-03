//
//  AddAreaController.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/5/29.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

import UIKit
import CoreData

class AddAreaController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var area: AreaMO!
    var isvisited = false
    var isEdited = false
    
    @IBOutlet weak var imageText: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var provinceText: UITextField!
    @IBOutlet weak var partText: UITextField!

    @IBAction func isVisitedSwtich(_ sender: UIButton) {
        if sender.tag == 8001{
            isvisited = true
            visitedText.text = "我去过！"
        } else {
            isvisited = false
            visitedText.text = "我没去过。"
        }
    }
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
//        判断是否填写完毕
        if nameText.text == nil || partText.text == nil || provinceText.text == nil || coverImageView.image == nil{
            let errorAlert = UIAlertController(title: "抱歉", message: "您还未填完所有信息。", preferredStyle: .alert)
            let option1 = UIAlertAction(title: "继续填写", style: .default, handler: nil)
            let option2 = UIAlertAction(title: "退出", style: .cancel, handler: { (_) in
                self.performSegue(withIdentifier: "unwindToHomeList", sender: self)
            })
            errorAlert.addAction(option1)
            errorAlert.addAction(option2)
            self.present(errorAlert, animated: true, completion: nil)
        } else if !isEdited {
//            新建
            area = AreaMO(context: appDelegate.persistentContainer.viewContext)
            area.name = nameText.text
            area.part = partText.text
            area.province = provinceText.text
            area.isvisited = isvisited
            if let imageData = UIImageJPEGRepresentation(coverImageView.image!, 0.7){
                area.image = NSData(data: imageData)
            }
            area.addTime = Date() as NSDate?
            area.isTop = 1
            appDelegate.saveContext()
            saveToCloud(area: area)
            performSegue(withIdentifier: "unwindToHomeList", sender: self)
        } else if isEdited {
//            修改
            area = AreaMO(context: appDelegate.persistentContainer.viewContext)
            area.name = nameText.text
            area.part = partText.text
            area.province = provinceText.text
            area.isvisited = isvisited
            if let imageData = UIImageJPEGRepresentation(coverImageView.image!, 0.7){
                area.image = NSData(data: imageData)
            }
            area.addTime = Date() as NSDate?
            area.isTop = 1
            appDelegate.saveContext()
            performSegue(withIdentifier: "unwindToHomeList", sender: self)
        }
    }
    @IBOutlet weak var visitedText: UILabel!
    
    
//    云端保存
    func saveToCloud(area:AreaMO) {
        let cloudObject = AVObject(className: "Area")
        cloudObject["name"] = area.name!
        cloudObject["part"] = area.part!
        cloudObject["province"] = area.province!
        cloudObject["isVisited"] = area.isvisited
        cloudObject["isTop"] = area.isTop
        cloudObject["addTime"] = area.addTime!
        
//        图像缩放
        let originalImage = UIImage(data: area.image as! Data)!
        let factor = (originalImage.size.width > 1024) ? (1024 / originalImage.size.width) : 1
        let scaledImage = UIImage(data: area.image as! Data, scale: factor)!
        
        let imageFile = AVFile(name: "\(area.name!).jpg", data: UIImageJPEGRepresentation(scaledImage, 0.7)!)
        cloudObject["image"] = imageFile
        
        cloudObject.saveInBackground { (succeed, error) in
            if succeed {
                print("云端保存成功！")
            } else {
                print(error ?? "未知错误，云端保存失败！！！")
            }
        }
    }
    
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

    // MARK: - Table view data source
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        coverImageView.image = info[UIImagePickerControllerOriginalImage]as? UIImage
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        imageText.text = ""
        
//代码约束(NSLayoutConstraint)
        let widthCons = NSLayoutConstraint(item: coverImageView, attribute: .width, relatedBy: .equal, toItem: coverImageView.superview, attribute: .width, multiplier: 1, constant: 0)
        let heightCons = NSLayoutConstraint(item: coverImageView, attribute: .height, relatedBy: .equal, toItem: coverImageView.superview, attribute: .height, multiplier: 1, constant: 0)
        widthCons.isActive = true
        heightCons.isActive = true
        
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                let errormenu = UIAlertController(title: "错误", message: "系统禁止访问相册。", preferredStyle: .alert)
                self.present(errormenu, animated: true, completion: nil)
                return
            }
            
            let photomenu = UIAlertController(title: "请选择图片来源：", message: "", preferredStyle: .actionSheet)
            let option1 = UIAlertAction(title: "相册", style: .default, handler: { (_) in
                let photopicker = UIImagePickerController()
                photopicker.allowsEditing = false
                photopicker.sourceType = .photoLibrary
                photopicker.delegate = self
                self.present(photopicker, animated: true, completion: nil)
            })
            let option2 = UIAlertAction(title: "拍照", style: .default, handler: { (_) in
                let camerapicker = UIImagePickerController()
                camerapicker.allowsEditing = false
                camerapicker.sourceType = .camera
                self.present(camerapicker, animated: true, completion: nil)
            })
            let option3 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            photomenu.addAction(option1)
            photomenu.addAction(option2)
            photomenu.addAction(option3)
            self.present(photomenu, animated: true, completion: nil)
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func dataManagementStart() {
//        var dataArr = [AreaMO]()
//        
//        // 被管理对象上下文
//        let content = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
//        
//        // coreData 模型的路径
//        let path = Bundle.main.path(forResource: "Area", ofType: "momd") // 注意是"momd"
//        // 通过路径加载coreData模型(可以映射到数据库里)
//        let model = NSManagedObjectModel.init(contentsOf: URL.init(fileURLWithPath: path!))!
//        // 持久化存储协调器 (让模型 和 数据库发生关系)
//        let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: model)
//        // 数据库路径
//        let sqlPath = NSHomeDirectory() + "/Documents/FansArea.sqlite"
//        
//        // 通过协调器设置数据的存储方法
//        
//        try! coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: URL.init(fileURLWithPath: sqlPath), options: nil)
//        // 将协调器设置给上下文, 从此上下文就拥有了权利(增删改查)
//        content.persistentStoreCoordinator = coordinator
//        
//        // 构造查询请求, 需要设置在哪个表里查询, 如果不设置查询条件, 默认查询所有
//        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Area")
//        do{
//            // 执行查询请求, 并且错误处理
//            // 查询条件
//            let predicate = NSPredicate.init(format: "name like %@", "*\(area.name)*")
//            // 让请求带上条件
//            request.predicate = predicate
//            dataArr = try content.fetch(request) as! [AreaMO]
//        }catch{
//            print("查询所有, 失败了")
//        }
//
//    }
    
    

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
