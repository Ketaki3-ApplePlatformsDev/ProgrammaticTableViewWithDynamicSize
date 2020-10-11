//
//  AboutCanadaTableViewCell.swift
//  ProficiencyExecercise-Wipro
//
//  Created by Ketaki Mahaveer Kurade on 11/10/20.
//

import UIKit
import SDWebImage
import Alamofire

class AboutCanadaTableViewCell: UITableViewCell {
    var aboutCanada: AboutCanada? {
        
        didSet {
            guard let aboutCanada = aboutCanada else {
                return
            }
            if let title = aboutCanada.title {
                titleLabel.isHidden = false
                titleLabel.text = title
            }
            let hideTextLabel = (titleLabel.text?.count == 0)  ? true :false
            titleLabel.isHidden = hideTextLabel
            
            if let description = aboutCanada.description {
                descriptionLabel.text = description
            }
            let hideDescriptionLabel = (descriptionLabel.text?.count == 0)  ? true :false
            descriptionLabel.isHidden = hideDescriptionLabel

            if let imageURL = aboutCanada.imageURL {
                setImageWithImageURL(imageUrl: imageURL)
            } else {
                aboutImageView.image = UIImage(named: (ImageNames.placeholderImage.rawValue))
            }
        }
    }
    
    // MARK: - UI Components
    
    //  ImageView for Cell Image
    let aboutImageView:UIImageView = {
        
        let imgageView = UIImageView()
        // image will never be strecthed vertially or horizontally
        imgageView.contentMode = .scaleToFill
        imgageView.backgroundColor = .clear
        // enable autolayout
        imgageView.translatesAutoresizingMaskIntoConstraints = false
        imgageView.clipsToBounds = true
        return imgageView
    }()
    
    //  Label for Cell title
    let titleLabel: VerticalTopAlignLabel = {
        
        let label = VerticalTopAlignLabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor =  .black
        //  Setting number of lines to zero to support dynamic content.
        label.numberOfLines = 0
        // enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //  Label for Cell Description
    let descriptionLabel: VerticalTopAlignLabel = {
        
        let label = VerticalTopAlignLabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor =  .gray
        //  Setting number of lines to zero to support dynamic content.
        label.numberOfLines = 0
        // enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //  containerView for Labels
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // To make sure its title and description labels do not go out of the boundary
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Initialising and UI layout Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutConstraints()
        layoutIfNeeded()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        contentView.addSubview(containerView)
        contentView.addSubview(aboutImageView)
        layoutConstraints()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layoutIfNeeded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
        self.aboutImageView.image = nil
    }
    
    // Method for Adding Constraints for SubViews
    func layoutConstraints() {
        //Adding Constraints
        let marginGuide = contentView.layoutMarginsGuide
        
        //configure Container View
        containerView.leadingAnchor.constraint(equalTo:marginGuide.leadingAnchor, constant:0).isActive = true
        containerView.topAnchor.constraint(equalTo:marginGuide.topAnchor, constant:10).isActive = true
        containerView.bottomAnchor.constraint(equalTo:marginGuide.bottomAnchor, constant:-10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: aboutImageView.leadingAnchor).isActive = true
        contentView.addConstraint(NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 85))
        
        // configure title Label
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
    
        // Configure description Label
        descriptionLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor,constant:5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        // Configure about Image View
        aboutImageView.topAnchor.constraint(equalTo:titleLabel.topAnchor, constant:0).isActive = true
        aboutImageView.widthAnchor.constraint(equalToConstant:80).isActive = true
        aboutImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
        aboutImageView.trailingAnchor.constraint(equalTo:marginGuide.trailingAnchor, constant:0).isActive = true
    }
}


extension AboutCanadaTableViewCell {
    
    // Method to load image from url asynchrnously in background and using placeholder till image gets loaded.
    func setImageWithImageURL(imageUrl: String){
        
        aboutImageView.image = nil
        let url = URL(string: imageUrl)
        aboutImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        aboutImageView.sd_setImage(with: url, placeholderImage: UIImage(named: ImageNames.placeholderImage.rawValue), options: .refreshCached, progress: nil, completed: {[weak self] (image, error, nil, url) in
            
            DispatchQueue.main.async {
                if let weekSelf = self {
                    if let _ = error {
                        weekSelf.aboutImageView.image = UIImage(named: ImageNames.placeholderImage.rawValue)
                        weekSelf.aboutImageView.setNeedsLayout()
                        
                    }
                }
            }
        })
    }
}


// Class for creating labels having vertical top alignment for texts in labels.
class VerticalTopAlignLabel: UILabel {
    
    override func drawText(in rect:CGRect) {
        guard let labelText = text else {  return super.drawText(in: rect) }
        
        let attributedText = NSAttributedString(string: labelText, attributes: [NSAttributedString.Key.font: font])
        var newRect = rect
        newRect.size.height = attributedText.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil).size.height
        
        if numberOfLines != 0 {
            newRect.size.height = min(newRect.size.height, CGFloat(numberOfLines) * font.lineHeight)
        }
        
        super.drawText(in: newRect)
    }
}
