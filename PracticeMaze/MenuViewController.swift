//
//  MenuViewController.swift
//  PracticeMaze
//
//  Created by Jiajun's Computer on 8/3/20.
//  Copyright © 2020 Jiajun Yan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var bg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bg.adjustsImageSizeForAccessibilityContentSizeCategory = false
        NSLayoutConstraint.activate([bg.topAnchor.constraint(equalTo: self.view.topAnchor, constant:self.view.frame.size.height - self.view.frame.size.width)])
        print(UIScreen.main.bounds.width)
    }
    
    @IBAction func play(_ sender: Any) {
        let levelVC = self.storyboard?.instantiateViewController(identifier: "levelVC") as! LevelSelectViewController
        
        self.navigationController?.pushViewController(levelVC, animated: true)
    }
    
    @IBAction func shop(_ sender: Any) {
        
    }
    
    
    @IBAction func about(_ sender: Any) {
        
    }
    
    
    @IBAction func settings(_ sender: Any) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
