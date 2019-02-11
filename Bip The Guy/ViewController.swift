//
//  ViewController.swift
//  Bip The Guy
//
//  Created by Hiroki on 2019/02/09.
//  Copyright © 2019 Hiroki. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//Mark PROPERTIES
    @IBOutlet weak var imageToPunch: UIImageView!
    
    var audioPlayer = AVAudioPlayer ()
    var imagePicker = UIImagePickerController ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
//Mark FUNCTIONS
    func animateImage() {
        let bounds = self.imageToPunch.bounds
        let shrinkValue: CGFloat = 60
        
//shrink imageToPunch by 60 pixels
        self.imageToPunch.bounds = CGRect(x: self.imageToPunch.bounds.origin.x + shrinkValue,
                                          y: self.imageToPunch.bounds.origin.y + shrinkValue,
                                          width: self.imageToPunch.bounds.size.width - shrinkValue,
                                          height: self.imageToPunch.bounds.size.height - shrinkValue)
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: {self.imageToPunch.bounds = bounds}, completion: nil)
    }
    func playSound (soundName: String, audioPlayer: inout AVAudioPlayer) {
        if let sound = NSDataAsset(name: soundName) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: data in \(soundName) couldn't be played as a sound.")
            }
        } else {
            print("ERROR: file \(soundName) didn't load")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
//APPLE GIVES YOU A DICTIONARY "info" WHERE YOU COULD PULL OUT STUFF, IN THIS CASE, THE SELECTED PHOTOS
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageToPunch.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
//MARK ACTIONS
    @IBAction func libraryPressed(_ sender: UIButton) {
//SHOWS PHOTO LIBRARY WHEN PRESSED
        imagePicker.sourceType = .photoLibrary
//IMAGE CAN COMMUNICATE WITH VIEWCONTROLLER WHICH IS DEFINED AS "SELF" HERE
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func cameraPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
           showAlert(title: "Camera Not Available", message: "There is no camera available on this device.")
        }
        }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        animateImage()
        playSound(soundName: "punchSound", audioPlayer: &audioPlayer)
    }
    
}
