import UIKit
import GrabUIKit

// MARK: - Grab Design System Demo
// 그랩 디자인 시스템 컴포넌트들을 사용한 바이브코딩 예제

class GrabUIKitDemoViewController: UIViewController {
    
    // MARK: - UI Components
    
    // 1. Duxton Button (그랩 표준 버튼)
    private lazy var primaryButton: DuxtonPrimaryButton = {
        let button = DuxtonPrimaryButton()
        button.setTitle("Primary Button", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondaryButton: DuxtonSecondaryButton = {
        let button = DuxtonSecondaryButton()
        button.setTitle("Secondary Button", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    // 2. List Item V3 (그랩 리스트 아이템)
    private lazy var listItemExample: DuxtonListItemV3 = {
        let config = DuxtonListItemV3Config(
            leading: .init(
                thumbnail: .init(
                    media: .icon(.systemName("star.fill")),
                    size: .medium,
                    style: .circle
                )
            ),
            primary: .init(
                title: .init(text: "List Item Title", style: .heading3),
                subtitle: .init(text: "Subtitle text goes here", style: .body2)
            ),
            trailing: .init(
                accessory: .chevron
            )
        )
        return DuxtonListItemV3(config: config)
    }()
    
    // 3. App Bar (그랩 상단 네비게이션 바)
    private lazy var appBar: DuxtonAppBar = {
        let config = DuxtonAppBarConfig(
            title: "Grab Design System Demo",
            leftButton: .back,
            rightButtons: [.icon(.systemName("ellipsis"))]
        )
        return DuxtonAppBar(config: config)
    }()
    
    // 4. Thumbnail (그랩 썸네일/아이콘)
    private lazy var thumbnailExample: GDSThumbnail = {
        let config = GDSThumbnailContainerConfig(
            size: .large,
            shape: .circle
        )
        let thumbnail = GDSThumbnail(config: config)
        thumbnail.setImage(UIImage(systemName: "person.fill"))
        return thumbnail
    }()
    
    // 5. Shortcut (그랩 숏컷 버튼)
    private lazy var shortcutExample: DuxtonShortcut = {
        let config = DuxtonShortcutModelConfig(
            icon: .systemName("cart.fill"),
            title: "Order Food",
            subtitle: "Fast delivery"
        )
        return DuxtonShortcut(config: config)
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add all components to view
        view.addSubview(appBar)
        view.addSubview(primaryButton)
        view.addSubview(secondaryButton)
        view.addSubview(listItemExample)
        view.addSubview(thumbnailExample)
        view.addSubview(shortcutExample)
    }
    
    private func setupLayout() {
        // Disable autoresizing mask
        [appBar, primaryButton, secondaryButton, listItemExample, 
         thumbnailExample, shortcutExample].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // App Bar
            appBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            appBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Thumbnail
            thumbnailExample.topAnchor.constraint(equalTo: appBar.bottomAnchor, constant: 24),
            thumbnailExample.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // List Item
            listItemExample.topAnchor.constraint(equalTo: thumbnailExample.bottomAnchor, constant: 24),
            listItemExample.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            listItemExample.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Shortcut
            shortcutExample.topAnchor.constraint(equalTo: listItemExample.bottomAnchor, constant: 24),
            shortcutExample.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Primary Button
            primaryButton.topAnchor.constraint(equalTo: shortcutExample.bottomAnchor, constant: 32),
            primaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            primaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            primaryButton.heightAnchor.constraint(equalToConstant: 48),
            
            // Secondary Button
            secondaryButton.topAnchor.constraint(equalTo: primaryButton.bottomAnchor, constant: 16),
            secondaryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondaryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            secondaryButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    // MARK: - Actions
    
    @objc private func buttonTapped() {
        print("Button tapped!")
        
        // Example: Show toast or alert
        let alert = UIAlertController(
            title: "Success",
            message: "Button action triggered!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Design Tokens Demo
// 그랩 디자인 토큰 (색상, 타이포그래피 등)

extension GrabUIKitDemoViewController {
    
    /// 그랩 디자인 시스템 색상 사용 예제
    func applyGrabColors() {
        // From DesignConstants.swift
        let greenColor = DesignConstants.green // Grab 브랜드 그린
        let grayColor = DesignConstants.grayM // 그레이 컬러
        let redColor = DesignConstants.red // 레드 컬러
        
        view.backgroundColor = DesignConstants.grayXS // 라이트 백그라운드
    }
    
    /// 그랩 타이포그래피 사용 예제  
    func applyGrabTypography() {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = DesignConstants.grayXXL
        
        let bodyLabel = UILabel()
        bodyLabel.font = .systemFont(ofSize: 16, weight: .regular)
        bodyLabel.textColor = DesignConstants.grayL
    }
}

// MARK: - SwiftUI Preview
// SwiftUI로 프리뷰 보기 (Xcode에서 실시간 미리보기)

#if DEBUG
import SwiftUI

struct GrabUIKitDemo_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerRepresenting {
            GrabUIKitDemoViewController()
        }
        .previewDisplayName("Grab Design System Demo")
    }
}

struct UIViewControllerRepresenting<ViewController: UIViewController>: UIViewControllerRepresentable {
    let makeUIViewController: () -> ViewController
    
    init(_ makeUIViewController: @escaping () -> ViewController) {
        self.makeUIViewController = makeUIViewController
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        makeUIViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // No update needed
    }
}
#endif
