//
//  ViewController.swift
//  NasaApod
//
//  Created by Squiretoss on 17.03.2020.
//  Copyright © 2020 Oguz Demirhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var apodImage: UIImageView!
    @IBOutlet weak var apodText: UITextView!
    @IBOutlet weak var apodDate: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    
    
    
    let mainUrl = "https://api.nasa.gov/planetary/apod?api_key=PZYRKP3OaOhIcOYonoYhsHILfiD2rMFBvpbLP7cl"
    
    var dateTextFinal = " "
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        dateTextField.delegate = self
        performTask(apodUrl: mainUrl)
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
         dateTextFinal = dateTextField.text!
        performTask(apodUrl: "\(self.mainUrl)&date=\(dateTextFinal)")
    }
    
    func performTask(apodUrl:String){
        
        let url = URL(string: apodUrl) ?? URL(string: mainUrl)!
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else{return }
            
            do{
                let APOD = try  JSONDecoder().decode(Apod.self, from: data)
                
                let apodExplanation = APOD.explanation
                let apodDates = APOD.date
                let apodImageUrl = APOD.hdurl
                let apodRealImage = self.getImage(from: apodImageUrl)
                
                DispatchQueue.main.async {
                    self.apodImage.image = apodRealImage
                    self.apodDate.text = apodDates
                    self.apodText.text = apodExplanation
                }
                
                
            }
            catch{
                print("There is an error")
                
            }
            
        }.resume()
        
        
        
    }
    
    func getImage(from string: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
        }

        var image: UIImage? = nil
        do {
            //3. Get valid data
            let data = try Data(contentsOf: url, options: [])

            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }

        return image
    }
    

}

