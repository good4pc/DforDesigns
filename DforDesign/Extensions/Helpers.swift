//
//  Helpers.swift
//  SmartBoy
//
//  Created by Prasanth pc on 2019-04-19.
//  Copyright © 2019 Prasanth pc. All rights reserved.
//

import UIKit

//MARK: CALayer

extension CALayer {
    func addBorder(with color: UIColor) {
        self.borderColor = color.cgColor
        self.borderWidth = 2.0
    }
}
//MARK: UIVIew

extension UIView {
    func addActivityIndicator() {
        DispatchQueue.main.async {
            let activityIndicatore = UIActivityIndicatorView(style: .whiteLarge)
            activityIndicatore.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            activityIndicatore.center = self.center
            activityIndicatore.tag = 563
            self.addSubview(activityIndicatore)
            activityIndicatore.startAnimating()
        }
    }
    
    func removeActivityIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.viewWithTag(563) {
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    func addUnderLine() {
        self.layoutIfNeeded()
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: self.bounds.height - 0.5, width: self.bounds.width, height: 0.5)
        layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(layer)
    }
    
    func addProgressIndicator () {
        self.backgroundColor = UIColor.darkGray
        for (index,subView) in subviews.enumerated() {
            if index == 0{
                subView.backgroundColor = UIColor.darkGray
            } else {
                subView.backgroundColor = UIColor.lightGray

            }
        }
    }
  
}
//MARK: String

extension String {
    func takeDataFromUrl() -> Data? {
        do {
            let url = URL(fileURLWithPath: self)
            let data = try Data(contentsOf: url, options: .dataReadingMapped)
            return data
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
        
    }
    /** METHOD TO FING OF THE HEIGHT OT THE LABEL IN REGARDS TO THE STRING INSIDE THE LABEL
     **/
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
}
//MARK: ImageView


extension UIImageView {
    //MARK: Download image from url and set
    
    func downloadImage(from url: String , completionHandler: @escaping (Data?) -> Void) {
        
        let queue = DispatchQueue.global(qos: .background)
        queue.async {
            guard let url = URL(string: url) else {
                DispatchQueue.main.async {
                    self.image = nil
                }
                completionHandler(nil)
                return
            }
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async(execute: {
                        self.image = image
                    })
                    completionHandler(data)
                } else {
                    DispatchQueue.main.async {
                        self.image = nil
                    }
                    completionHandler(nil)
                }
                }.resume()
        }
    }
}

