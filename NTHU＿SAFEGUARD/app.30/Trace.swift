//
//  Trace.swift
//  app.30
//
//  Created by 蕭亦程 on 2019/1/18.
//  Copyright © 2019年 cs nthu. All rights reserved.
//

import UIKit

class Trace: UIViewController,UITextViewDelegate{
    @IBOutlet weak var myTextView: UITextView!
    
    override func viewDidLoad() {
        
     super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        NSLog("textViewDidBeginEditing")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        NSLog("textViewDidBeginEditing")
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView)->Bool {
        NSLog("textViewDidBeginEditing")
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView)->Bool {
        NSLog("textViewDidBeginEditing")
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: _NSRange, replacementText text: String) -> Bool {
        if(text.isEqual("\n")){
            self.myTextView.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func returnclick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
