//
//  InterestCollectionViewCell.swift
//  Dame Veneno
//
//  Created by Jose Antonio Córdoba Gómez on 30/12/17.
//  Copyright © 2017 Jose Antonio Córdoba Gómez. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var interestTitleLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    
    var interest: ElementoVeneno? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI()
    {
        if let interest = interest {
            
            
            //featuredImageView.image = interest.featuredImage
            interestTitleLabel.text = interest.titulo
            backgroundColorView.backgroundColor = interest.color
        } else {
            featuredImageView.image = nil
            interestTitleLabel.text = nil
            backgroundColorView.backgroundColor = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        self.clipsToBounds = false
    }
}
