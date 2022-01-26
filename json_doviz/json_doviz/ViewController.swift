//
//  ViewController.swift
//  json_doviz
//
//  Created by Doğukan Göncü on 30.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tryLabel: UILabel!
    
    
    @IBOutlet weak var cadLabel: UILabel!

    
    @IBOutlet weak var eurLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getButton(_ sender: Any) {
        
        let url = URL(string: "https://api.fastforex.io/fetch-all?api_key=6f1d6128df-afc83be90f-r1rc3r")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data,response,error) in
            if error != nil{
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert
                )
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
            } else {
                
                if data != nil {
                    do {
                        let jsonResponse = try  JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                          
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["results"] as? [String : Any] {
                               // print(rates)
                                
                                if let tr = rates["TRY"] as?  Double {
                                
                                    
                                    self.tryLabel.text = "TRY: \(tr) "
                                }
                                if let eur = rates["EUR"] as?  Double {
                                
                                    self.eurLabel.text = "EUR: \(eur) "
                                }
                                if let cad = rates["CAD"] as?  Double {
                                
                                    
                                    self.cadLabel.text = "CAD: \(cad) "
                                }
                                
                                
                            }
                            }                        
                        
                        
                    } catch {
                        print ("error")
                    }
                
                    
                }
            }
            
            
            
            
        }
        task.resume()
        
        
    }
}

