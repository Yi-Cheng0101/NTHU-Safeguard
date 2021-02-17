//
//  GPS.swift
//  app.30
//
//  Created by cs nthu on 2019/1/12.
//  Copyright © 2019年 cs nthu. All rights reserved.
//

import UIKit
import MapKit
import UserNotifications



class GPS: UIViewController,UITextFieldDelegate {
    
    
   
    //////////////////////////////////////////////////
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var segmented: UISegmentedControl!
    @IBAction func showLocation(_ sender: AnyObject){
        self.mapView.showsUserLocation = true
    }
    @IBAction func changeMapType(_ sender:AnyObject){
        switch segmented.selectedSegmentIndex{
        case 0:
            mapView.mapType = MKMapType.standard
        case 1:
            mapView.mapType = MKMapType.satellite
        case 2:
            mapView.mapType = MKMapType.hybrid
        default:
            mapView.mapType = MKMapType.hybrid
        }
    }
    
    struct position: Decodable {
        let id: Int
        let macaddr: Int
        let data: String
        let lat: String
        let lng: String
        let created_at: String
        let updated_at: String
       
    }
    
    
    //var json = NSMutableArray()
    var positions = [position]()
    var DDate = DateComponents()
    let textField = UITextField(frame: CGRect(x:71,y:626,width:233,height:30))

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    override func viewDidLoad() {
        
        textField.keyboardType = UIKeyboardType.numberPad
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.returnKeyType = UIReturnKeyType.done
        textField.delegate = self
        self.view.addSubview(textField)
        
        
        super.viewDidLoad()
        fetchJSON()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(textField.text ?? "")
        return true
    }
    
    @IBAction func phone(_ sender: Any) {
        guard let number = URL(string: "tel://" + textField.text!)else{return}
        UIApplication.shared.open(number)
    }
    
    var BANNG = position(id: 0, macaddr: 1234567817, data: "00000", lat: "ass", lng: "Ass", created_at: "A", updated_at: "B")
    
    fileprivate func fetchJSON(){
        let urlstring = "https://iot.martinintw.com/api/v1/data/12345617"
        guard let url = URL(string: urlstring) else {return}
       
        URLSession.shared.dataTask(with: url){ (data, response, err) in
            guard let data = data else{ return }
            
            do {
                let decoder = JSONDecoder()
                let bang = try decoder.decode([position].self, from: data)
                var b = bang.count - 1
                while bang[b].lat == ""{
                    b = b-1}
                self.BANNG = bang[b]
                print(bang[b].lat,bang[b].lng)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter.timeZone = TimeZone(identifier: "UTC")
                var virbaltime = dateFormatter.date(from: bang[b].created_at)!
                virbaltime.addTimeInterval(-28740)
                //print(virbaltime)
                let Date = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: virbaltime)
                self.DDate = Date
                
                
                /*var date1 = DateComponents()
                date1.hour = 20
                date1.minute = 50
                
                
                
                self.DDate = date1*/
                print(Date)
                
                
                let location = CLLocationCoordinate2DMake(Double(bang[b].lat)!, Double(bang[b].lng)!)
                let   span     = MKCoordinateSpanMake(0.01,0.01)
                let   region    = MKCoordinateRegion(center:location,span:span)
                self.mapView.setRegion(region,animated: true)
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title="Current Location "
                self.mapView.addAnnotation(annotation)
            }
            catch let jsonErr{
                print("Error serialization:", jsonErr)
            }
        }.resume()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func returnclick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    let requestIdentifier = "NotificationRequest"
    
    /*override func viewDidLoad(){
        super.viewDidLoad()
    }*/
    @IBAction func sendNotification(_ sender: Any){
        let content = UNMutableNotificationContent()
        content.title = "緊告訊息"
        content.body = "劇烈晃動 小心跌倒！！"
        content.sound = UNNotificationSound.default()
        
       
        let trigger = UNCalendarNotificationTrigger(dateMatching: DDate, repeats: true)
        
        let request = UNNotificationRequest(identifier:"Ｓhake",content:content,trigger:trigger)
        UNUserNotificationCenter.current().add(request,withCompletionHandler:  nil)
    }
    
    @IBAction func DangerZoneNotifications(_ sender: Any){
        
        
         let content = UNMutableNotificationContent()
        content.title = "緊告訊息"
        content.body = "危險區域！！"
         content.sound = UNNotificationSound.default()
        //let center = CLLocationCoordinate2D(latitude: 24.7946, longitude: 120.9952)
       
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: DDate, repeats: true)
        
        
        
        let request = UNNotificationRequest(identifier:"DagerZone",content:content,trigger:trigger)
           if(Double(BANNG.lat)!>24.7945 && Double(BANNG.lat)!<24.7947 && Double(BANNG.lng)! > 120.9951 && Double(BANNG.lng)! < 120.9953)
           {
            UNUserNotificationCenter.current().add(request,withCompletionHandler:  nil)
            }
            else
           {
                return
            }
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   
}


