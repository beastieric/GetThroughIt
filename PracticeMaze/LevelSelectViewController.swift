//
//  LevelSelectViewController.swift
//  PracticeMaze
//
//  Created by Jiajun's Computer on 8/3/20.
//  Copyright © 2020 Jiajun Yan. All rights reserved.
//

import UIKit

class LevelSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var buildingCollectionView: UICollectionView!
    var buildings = ["building1", "building2", "building3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildingCollectionView.dataSource = self
        buildingCollectionView.delegate = self
        buildingCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buildings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BuildingCell", for: indexPath) as! BuildingCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let buildingCell = cell as? BuildingCollectionViewCell
        
        let building = buildings[indexPath.row]
        
        buildingCell?.configure(building: building)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? BuildingCollectionViewCell
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        let building = cell?.building
        gameVC.building = Int(building![building!.index(building!.startIndex, offsetBy: 8)..<building!.endIndex])!
        if let level = UserDefaults.standard.object(forKey: building!){
            gameVC.level = level as! Int
        }
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if #available(iOS 11.0, *){
            let safeWidth = self.view.safeAreaLayoutGuide.layoutFrame.width
            return CGSize(width: safeWidth, height: UIScreen.main.bounds.height*2/3)
        }else{
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*2/3)
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "menuVC") as! MenuViewController
        self.navigationController?.pushViewController(menuVC, animated: true)
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
