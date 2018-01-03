//
//  InformacionViewController.swift
//  Dame Veneno
//
//  Created by Jose Antonio Córdoba Gómez on 30/12/17.
//  Copyright © 2017 Jose Antonio Córdoba Gómez. All rights reserved.
//

import UIKit

class InformacionViewController: UIViewController {
    
    
    @IBOutlet weak var cerrarButton : UIButton!
    @IBOutlet weak var vistaWeb : UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureREcognizerText = UITapGestureRecognizer(target: self, action:#selector(buttonTapped(tapGestureRecognizer:)))
        cerrarButton.isUserInteractionEnabled = true
        cerrarButton.addGestureRecognizer(tapGestureREcognizerText)
        
        self.navigationController?.navigationBar.isHidden = true
    
        
        
        
        
//        if let miURL = URL(string: "https://stackoverflow.com"){
//            let request2 = URLRequest(url: miURL)
//            let session = URLSession.shared
//            let task = session.dataTask(with: miURL){
//
//            (data, response, error) in
//
//                if error == nil{
//                    self.vistaWeb.loadRequest(request2)
//                }else{
//                    print("Hubo un error en la sesion")
//                }
//
//
//            }
//        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonTapped(tapGestureRecognizer: UITapGestureRecognizer){
        print("DEBEMOS CERRAR")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func hacerPop(){
        print("DEBEMOS CERRAR")
        //self.navigationController?.popViewController(animated: true)
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
