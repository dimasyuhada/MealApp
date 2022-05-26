//
//  MealTableViewCell.swift
//  MealApp
//
//  Created by Dimas Syuhada on 26/05/22.
//

import Foundation
import UIKit

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    static let identifier = "MealTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MealTableViewCell", bundle: nil)
    }
    
    func configure(with model: MealData){
        self.title.text = model.strMeal
        self.img.downloadedFrom(link: model.strMealThumb)
    }
}


