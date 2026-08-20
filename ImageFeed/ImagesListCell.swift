import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"

    private let gradientLayer = CAGradientLayer()
    private let gradientOverlayView = UIView()

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var gradientView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        photoImageView.layer.cornerRadius = 16
        photoImageView.layer.masksToBounds = true
        photoImageView.clipsToBounds = true

        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor
        ]
        gradientLayer.locations = [0.65, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.cornerRadius = 16
        gradientLayer.masksToBounds = true


        gradientView.isHidden = true // старый storyboard gradientView остаётся скрытым.

        gradientOverlayView.backgroundColor = .clear
        gradientOverlayView.isUserInteractionEnabled = false
        gradientOverlayView.translatesAutoresizingMaskIntoConstraints = false
        gradientOverlayView.layer.addSublayer(gradientLayer)
        contentView.addSubview(gradientOverlayView)
        gradientOverlayView.isHidden = false
        gradientOverlayView.alpha = 1.0

        NSLayoutConstraint.activate([
            gradientOverlayView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            gradientOverlayView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor),
            gradientOverlayView.topAnchor.constraint(equalTo: photoImageView.topAnchor),
            gradientOverlayView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientOverlayView.layoutIfNeeded()
        gradientLayer.frame = gradientOverlayView.bounds
        gradientLayer.cornerRadius = photoImageView.layer.cornerRadius

        contentView.bringSubviewToFront(gradientOverlayView)
        contentView.bringSubviewToFront(dateLabel)
        contentView.bringSubviewToFront(likeButton)
    }

    func configure(image: UIImage?, date: String, isLiked: Bool) {
        photoImageView.image = image
        dateLabel.text = date

        let imageName = isLiked ? "Active" : "No Active"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
