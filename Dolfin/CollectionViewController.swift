//
//  CollectionViewController.swift
//  Dolfin
//
//  Created by igor on 29.11.2020.
//

import Foundation
import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picturesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionViewCell
        cell?.picture.image = picturesArray[indexPath.item]
        return cell!
    }
    
    
    @IBOutlet weak var button: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    var picturesArray: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadPictureToCollection(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let picture = info[UIImagePickerController.InfoKey.originalImage]
        picturesArray.append(picture as! UIImage)
        collectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
