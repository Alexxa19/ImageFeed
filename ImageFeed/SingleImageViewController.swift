import UIKit

final class SingleImageViewController: UIViewController {

    var image: UIImage? {
        didSet {
            guard isViewLoaded else { return }

            imageView.image = image

            if let image = image {
                imageView.frame.size = image.size
                imageView.frame.origin = .zero
                rescaleAndCenterImageInScrollView(image: image)
            }
        }
    }

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!

    @IBAction private func didTapShareButton(_ sender: UIButton) {
        guard let image = image else { return }

        let shareController = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )

        present(shareController, animated: true)
    }

    @IBAction private func didTapBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.25

        imageView.image = image

        if let image = image {
            imageView.frame.size = image.size
            imageView.frame.origin = .zero
            rescaleAndCenterImageInScrollView(image: image)
        }
    }

    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        view.layoutIfNeeded()

        let visibleSize = scrollView.bounds.size
        let imageSize = image.size

        guard visibleSize.width > 0,
              visibleSize.height > 0,
              imageSize.width > 0,
              imageSize.height > 0 else {
            return
        }

        let widthScale = visibleSize.width / imageSize.width
        let heightScale = visibleSize.height / imageSize.height

        let initialZoomScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = initialZoomScale
        scrollView.setZoomScale(initialZoomScale, animated: false)

        scrollView.layoutIfNeeded()

        centerImage()
    }

    private func centerImage() {
        let boundsSize = scrollView.bounds.size
        let contentSize = scrollView.contentSize

        let horizontalInset = max(
            0,
            (boundsSize.width - contentSize.width) / 2
        )

        let verticalInset = max(
            0,
            (boundsSize.height - contentSize.height) / 2
        )

        scrollView.contentInset = UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset
        )

        scrollView.contentOffset = CGPoint(
            x: -horizontalInset,
            y: -verticalInset
        )
    }

    private func updateImageInsets() {
        let boundsSize = scrollView.bounds.size
        let contentSize = scrollView.contentSize

        let horizontalInset = max(
            0,
            (boundsSize.width - contentSize.width) / 2
        )

        let verticalInset = max(
            0,
            (boundsSize.height - contentSize.height) / 2
        )

        scrollView.contentInset = UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset
        )
    }
}

extension SingleImageViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateImageInsets()
    }
}
