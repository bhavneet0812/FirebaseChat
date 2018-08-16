//
//  ImageViewWithPreview.swift
//  Jhaiho
//
//  Created by Bhavneet Singh on 05/01/18.
//  Copyright © 2018 Bhavneet Singh. All rights reserved.
//

import UIKit

class ImageViewWithPreview: UIImageView {

    @objc enum ImageType: Int {
        case Circle = 0, Rectangle = 1, Square = 2
    }
    
    private var imageType: ImageType = ImageType.init(rawValue: 2)!
    var originalImage: UIImage!
    
    private var imageTapGesture: UITapGestureRecognizer!
    private var backViewTapGesture: UITapGestureRecognizer!
    var previewViewController: UIViewController!
    var backDarkView: UIView!
    var previewImageView: UIImageView!
    var transitionImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initialSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialSetup()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        self.initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupFrames()
    }
    
    private func initialSetup() {
    
        self.isUserInteractionEnabled = true
        self.imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(ImageViewWithPreview.imageTapGestureAction(_:)))
        self.addGestureRecognizer(self.imageTapGesture)
        
    }
    
    private func setupFrames() {
        
        
    }
    
    private func replicate(image: UIImage) -> UIImageView {
        let replicateImage = UIImageView(image: self.originalImage ?? self.image)
        replicateImage.clipsToBounds = self.clipsToBounds
        replicateImage.frame = globalFrame ?? self.frame
        replicateImage.cornerRadius = self.cornerRadius
        replicateImage.contentMode = self.contentMode
        replicateImage.isUserInteractionEnabled = true
        return replicateImage
    }
}

extension ImageViewWithPreview {
    
    @objc private func imageTapGestureAction(_ tap: UITapGestureRecognizer) {
        
        guard let _ = self.image else { return }
        
        self.transitionImageView = self.replicate(image: self.originalImage ?? self.image!)
        self.backDarkView = UIView(frame: AppDelegate.shared.window!.bounds)
        self.backViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backViewTapGestureAction(_:)))
        AppDelegate.shared.window?.addSubview(self.backDarkView)
        AppDelegate.shared.window?.addSubview(self.transitionImageView)
        self.backDarkView.addGestureRecognizer(self.backViewTapGesture)
        self.backDarkView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.backDarkView.alpha = 0
        self.transitionImageView.alpha = 0
        let fullScreenWidth = UIDevice.width-50
        let fullScreenHeight = UIDevice.height-50
        let fullScreenSize: CGSize!
        
        switch self.imageType {
        case .Circle:
            fullScreenSize = CGSize(width: fullScreenWidth, height: fullScreenWidth)
            self.transitionImageView.cornerRadius = self.transitionImageView.frame.height/2
            break
        case .Rectangle:
            if let imgSize = self.image?.size {
                let ratio = imgSize.width/imgSize.height
                let height = (fullScreenWidth)/ratio
                
                if height > fullScreenHeight {
                    ////////////
                } else {
                    ////////////
                }
                fullScreenSize = CGSize(width: fullScreenWidth, height: height)
                
            } else {
                fullScreenSize = CGSize(width: fullScreenWidth, height: fullScreenWidth)
            }
            self.transitionImageView.cornerRadius = 10
            break
        case .Square:
            fullScreenSize = CGSize(width: fullScreenWidth, height: fullScreenWidth)
            self.transitionImageView.cornerRadius = 10
            break
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.transitionImageView.frame.size = fullScreenSize
            self.transitionImageView.center = AppDelegate.shared.window!.center
            self.transitionImageView.cornerRadius = self.imageType == .Circle ? fullScreenWidth/2 : 10
            self.backDarkView.alpha = 1
            self.transitionImageView.alpha = 1
        }) { (finished) in
            
        }
    }
    
    @objc private func backViewTapGestureAction(_ tap: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.2, animations: {
            if let gframe = self.globalFrame {
                self.transitionImageView.frame.size = gframe.size
                self.transitionImageView.frame.origin = CGPoint(x: gframe.origin.x, y: gframe.origin.y+20)
            } else {
                self.transitionImageView.frame.size = self.frame.size
                self.transitionImageView.frame.origin = CGPoint(x: self.frame.origin.x, y: self.frame.origin.y+20)
            }
            self.backDarkView.alpha = 0
        }) { (finished) in
            
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.transitionImageView.alpha = 0
        }, completion: { (finished) in
            self.backDarkView.removeFromSuperview()
            self.transitionImageView.removeFromSuperview()
            self.backDarkView = nil
            self.transitionImageView = nil
            self.backViewTapGesture = nil
        })

    }
}
