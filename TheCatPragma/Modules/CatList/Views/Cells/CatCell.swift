//
//  CatCell.swift
//  TheCatPragma
//
//  Created by CarlosDz on 9/06/23.
//

import UIKit

struct CatCellModel {
    let name: String
    let image: String
    let intelligence: Int
    let origin: String
}

class CatCell: UICollectionViewCell {

    // MARK: - @IBOutlet -
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var originTitleLabel: UILabel!
    @IBOutlet weak var intelligenceTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    // MARK: - Public methods -
    private func configureView() {
        catName.font = .boldSystemFont(ofSize: 18)
        originTitleLabel .font = .boldSystemFont(ofSize: 13)
        originLabel.font = .systemFont(ofSize: 12)
        intelligenceTitleLabel .font = .boldSystemFont(ofSize: 13)
        intelligenceLabel.font = .systemFont(ofSize: 12)
        container.backgroundColor = UIColor(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1)
    }
    
    // MARK: - Public methods -
    func configure(with model: CatCellModel) {
        catName.text = model.name
        originLabel.text = model.origin
        intelligenceLabel.text = "\(model.intelligence)"
        
        // TODO: - Agregar carga de imagen con kingfisher
    }
}
