//
//  StatusViewController.swift
//  Health Monitor
//
//  Created by Naveen George Thoppan on 22/08/18.
//  Copyright © 2018 Thoppan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StatusViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var ecgLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateBPM()
        updateECG()
        updateTemperature()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateBPM() {
        Alamofire.request("https://api.thingspeak.com/channels/560488/fields/2.json?api_key=SZET0EFDKVK8YHNH&results=2").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            let json = try! JSON(data: response.data!)
            print(json)
            if let pulse = json["feeds"][1]["field2"].string {
                self.bpmLabel.text = pulse
            } else if let pulse = json["feeds"][0]["field2"].string {
                self.bpmLabel.text = pulse
            }
            
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }

    }
    
    func updateTemperature() {
        Alamofire.request("https://api.thingspeak.com/channels/560488/fields/1.json?api_key=SZET0EFDKVK8YHNH&results=2").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            let json = try! JSON(data: response.data!)
            print(json)
            if let temperature = json["feeds"][1]["field1"].string {
                self.temperatureLabel.text = temperature
            } else if let temperature = json["feeds"][0]["field1"].string {
                self.temperatureLabel.text = temperature
            }
            
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
    }
    
    func updateECG() {
        Alamofire.request("https://api.thingspeak.com/channels/560488/fields/3.json?api_key=SZET0EFDKVK8YHNH&results=2").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            let json = try! JSON(data: response.data!)
            print(json)
            if let ecg = json["feeds"][1]["field3"].string {
                self.ecgLabel.text = ecg
            } else if let ecg = json["feeds"][0]["field3"].string {
                self.ecgLabel.text = ecg
            }
            
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        updateBPM()
        updateECG()
        updateTemperature()
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
