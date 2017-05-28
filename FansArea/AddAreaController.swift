//
//  AddAreaController.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/5/29.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

import UIKit

class AddAreaController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageText: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
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
