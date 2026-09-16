import UIKit

final class ProfileViewController: UIViewController {

    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let favoritesLabel = UILabel()
    private let noPhotoImageView = UIImageView()
    private let logoutButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        view.backgroundColor = UIColor(named: "YP Black")

        // Аватар
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(named: "avatar")
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 35
        view.addSubview(avatarImageView)

        // Имя
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Екатерина Новикова"
        nameLabel.font = .boldSystemFont(ofSize: 23)
        nameLabel.textColor = UIColor(named: "YP White")
        view.addSubview(nameLabel)

        // Username
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "@ekaterina_nov"
        usernameLabel.font = .systemFont(ofSize: 13)
        usernameLabel.textColor = UIColor(named: "YP Gray")
        view.addSubview(usernameLabel)

        // Описание
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Hello, world!"
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = UIColor(named: "YP White")
        view.addSubview(descriptionLabel)

        // Избранное
        favoritesLabel.translatesAutoresizingMaskIntoConstraints = false
        favoritesLabel.text = "Избранное"
        favoritesLabel.font = .boldSystemFont(ofSize: 23)
        favoritesLabel.textColor = UIColor(named: "YP White")
        view.addSubview(favoritesLabel)

        // No Photo
        noPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        noPhotoImageView.image = UIImage(named: "No Photo")
        noPhotoImageView.contentMode = .scaleAspectFit
        view.addSubview(noPhotoImageView)

        // Кнопка выхода
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        if let exitImage = UIImage(named: "Exit") {
            logoutButton.setImage(
                exitImage.withRenderingMode(.alwaysTemplate),
                for: .normal
            )
        }

        logoutButton.tintColor = UIColor(named: "YP Red")

        logoutButton.addTarget(
            self,
            action: #selector(logoutButtonTapped),
            for: .touchUpInside
        )

        view.addSubview(logoutButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            // Аватар
            avatarImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 24
            ),
            avatarImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),

            // Кнопка выхода
            logoutButton.topAnchor.constraint(
                equalTo: avatarImageView.topAnchor,
                constant: 20
            ),
            logoutButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
            logoutButton.widthAnchor.constraint(equalToConstant: 44),
            logoutButton.heightAnchor.constraint(equalToConstant: 44),

            // Имя
            nameLabel.topAnchor.constraint(
                equalTo: avatarImageView.bottomAnchor,
                constant: 8
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            nameLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: view.trailingAnchor,
                constant: -16
            ),

            // Username
            usernameLabel.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: 2
            ),
            usernameLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),
            usernameLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: view.trailingAnchor,
                constant: -16
            ),

            // Описание
            descriptionLabel.topAnchor.constraint(
                equalTo: usernameLabel.bottomAnchor,
                constant: 8
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),

            // Избранное
            favoritesLabel.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: 18
            ),
            favoritesLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),
            favoritesLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),

            // No Photo
            noPhotoImageView.topAnchor.constraint(
                equalTo: favoritesLabel.bottomAnchor,
                constant: 120
            ),
            noPhotoImageView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            noPhotoImageView.widthAnchor.constraint(equalToConstant: 101),
            noPhotoImageView.heightAnchor.constraint(equalToConstant: 115)
        ])
    }

    @objc private func logoutButtonTapped() {
        let alert = UIAlertController(
            title: "Пока, пока!",
            message: "Уверены, что хотите выйти?",
            preferredStyle: .alert
        )

        let yesAction = UIAlertAction(
            title: "Да",
            style: .cancel
        ) { _ in
            // Переход на экран авторизации добавим позже.
        }

        let noAction = UIAlertAction(
            title: "Нет",
            style: .default
        )

        alert.addAction(yesAction)
        alert.addAction(noAction)

        present(alert, animated: true)
    }
}
