//
//  KelimeDetayViewController.swift
//  udemy_alamofire_dictionary
//
//  Created by Cenk Bahadır Çark on 11.08.2022.
//

import UIKit

class KelimeDetayViewController: UIViewController {

    @IBOutlet weak var turkceLabel: UILabel!
    @IBOutlet weak var ingilizceLabel: UILabel!
    
    var kelime : Kelimeler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let k = kelime{
            ingilizceLabel.text = k.ingilizce
            turkceLabel.text = k.turkce
        }

        
    }
    


}
