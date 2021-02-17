//
//  ViewController.swift
//  app.30
//
//  Created by cs nthu on 2019/1/12.
//  Copyright © 2019年 cs nthu. All rights reserved.
//

import UIKit

class ViewController:
UIViewController,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var click: UIButton!
    @IBAction func click(_ sender: UIButton) {
      let actionSheet = UIAlertController(title:"選擇照片開啟方式",
            message:nil,
            preferredStyle: .actionSheet)
            //cancelButtonTitle:"取消",
            //destructiveButtonTitle:nil,
            //otherButtonTitles:"照相","相片","膠卷")
        let myPickerController = UIImagePickerController()
        myPickerController.delegate=self
        
        let Camera = UIAlertAction(title:"相機", style: UIAlertActionStyle.default)
        {action in
            myPickerController.sourceType=UIImagePickerControllerSourceType.camera
            self.present(myPickerController,animated: true,completion: nil)
        }
        
        let Picture = UIAlertAction(title:"照片", style: UIAlertActionStyle.default)
        {action in
            myPickerController.sourceType=UIImagePickerControllerSourceType.photoLibrary
            self.present(myPickerController,animated: true,completion: nil)
        }
        
        let Pics = UIAlertAction(title:"膠卷", style: UIAlertActionStyle.default)
        {action in
            myPickerController.sourceType=UIImagePickerControllerSourceType.savedPhotosAlbum
            self.present(myPickerController,animated: true,completion: nil)
        }
        
        let Cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel)
        {action in
            self.dismiss(animated: true)
        }
        actionSheet.addAction(Camera)
        actionSheet.addAction(Picture)
        actionSheet.addAction(Pics)
        actionSheet.addAction(Cancel)
        //actionSheet.actionSheetStyle=UIActionSheetStyle.blackOpaque
        
        present (actionSheet, animated: true)
    }
    
    /*func actionSheet(_ actionSheet: UIActionSheet,clickedButtonAt  buttonIndex: Int){
    let myPickerController = UIImagePickerController()
        myPickerController.delegate=self
        switch buttonIndex{
        case 1://呼叫相機
                myPickerController.sourceType=UIImagePickerControllerSourceType.camera
                self.present(myPickerController,animated: true,completion: nil)
        case 2://呼叫相片
            myPickerController.sourceType=UIImagePickerControllerSourceType.photoLibrary
                self.present(myPickerController,animated: true,completion: nil)
        case 3://呼叫膠卷
            myPickerController.sourceType=UIImagePickerControllerSourceType.savedPhotosAlbum
            
                self.present(myPickerController,animated: true,completion: nil)
        default:
            break
        }
    
    }*/
    
    
    func imagePickerController(_ picker:UIImagePickerController,didFinishPickingMediaWithInfo info:[String :Any]){
        self.dismiss(animated: true,completion: nil)
        let selectImg=info[UIImagePickerControllerOriginalImage] as? UIImage!
        image.image=selectImg
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

