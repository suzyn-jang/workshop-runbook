import UIKit
import PlaygroundSupport
import GrabUIKit

// MARK: - Grab Design System Playground
// 실시간으로 컴포넌트를 테스트하고 수정할 수 있습니다

class PlaygroundViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addComponents()
    }
    
    private func setupUI() {
        view.backgroundColor = DesignConstants.grayXS
        
        // Scroll View
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Content Stack
        scrollView.addSubview(contentStack)
        contentStack.axis = .vertical
        contentStack.spacing = 24
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }
    
    private func addComponents() {
        // Section: Colors
        addSection(title: "🎨 Colors")
        addColorPalette()
        
        // Section: Buttons
        addSection(title: "🔘 Buttons")
        addButtons()
        
        // Section: List Items
        addSection(title: "📋 List Items")
        addListItems()
        
        // Section: Thumbnails
        addSection(title: "🖼 Thumbnails")
        addThumbnails()
        
        // Section: Shortcuts
        addSection(title: "⚡️ Shortcuts")
        addShortcuts()
    }
    
    private func addSection(title: String) {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = DesignConstants.grayXXL
        contentStack.addArrangedSubview(label)
    }
    
    private func addColorPalette() {
        let colors: [(String, UIColor)] = [
            ("Green", DesignConstants.green),
            ("Blue", DesignConstants.blue),
            ("Red", DesignConstants.red),
            ("Yellow", DesignConstants.yellow),
        ]
        
        let colorStack = UIStackView()
        colorStack.axis = .horizontal
        colorStack.distribution = .fillEqually
        colorStack.spacing = 8
        
        colors.forEach { name, color in
            let colorView = createColorSwatch(name: name, color: color)
            colorStack.addArrangedSubview(colorView)
        }
        
        contentStack.addArrangedSubview(colorStack)
        colorStack.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func createColorSwatch(name: String, color: UIColor) -> UIView {
        let container = UIView()
        
        let colorBox = UIView()
        colorBox.backgroundColor = color
        colorBox.layer.cornerRadius = 8
        
        let label = UILabel()
        label.text = name
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = DesignConstants.grayL
        
        container.addSubview(colorBox)
        container.addSubview(label)
        
        colorBox.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorBox.topAnchor.constraint(equalTo: container.topAnchor),
            colorBox.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            colorBox.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            colorBox.heightAnchor.constraint(equalToConstant: 70),
            
            label.topAnchor.constraint(equalTo: colorBox.bottomAnchor, constant: 4),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])
        
        return container
    }
    
    private func addButtons() {
        let buttonStack = UIStackView()
        buttonStack.axis = .vertical
        buttonStack.spacing = 12
        
        // Primary Button
        let primaryButton = DuxtonPrimaryButton()
        primaryButton.setTitle("Primary Button", for: .normal)
        primaryButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        // Secondary Button
        let secondaryButton = DuxtonSecondaryButton()
        secondaryButton.setTitle("Secondary Button", for: .normal)
        secondaryButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        // Disabled Button
        let disabledButton = DuxtonPrimaryButton()
        disabledButton.setTitle("Disabled Button", for: .normal)
        disabledButton.isEnabled = false
        disabledButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        [primaryButton, secondaryButton, disabledButton].forEach {
            buttonStack.addArrangedSubview($0)
        }
        
        contentStack.addArrangedSubview(buttonStack)
    }
    
    private func addListItems() {
        // Basic List Item
        let basicConfig = DuxtonListItemV3Config(
            leading: .init(
                thumbnail: .init(
                    media: .icon(.systemName("star.fill")),
                    size: .medium,
                    style: .circle
                )
            ),
            primary: .init(
                title: .init(text: "Basic List Item", style: .heading3),
                subtitle: .init(text: "With subtitle", style: .body2)
            ),
            trailing: .init(
                accessory: .chevron
            )
        )
        let basicItem = DuxtonListItemV3(config: basicConfig)
        
        // List Item with Badge
        let badgeConfig = DuxtonListItemV3Config(
            leading: .init(
                thumbnail: .init(
                    media: .icon(.systemName("bell.fill")),
                    size: .medium,
                    style: .squircle
                )
            ),
            primary: .init(
                title: .init(text: "Notifications", style: .heading3),
                subtitle: .init(text: "3 new messages", style: .body2)
            ),
            trailing: .init(
                badge: .init(text: "3", backgroundColor: DesignConstants.red)
            )
        )
        let badgeItem = DuxtonListItemV3(config: badgeConfig)
        
        contentStack.addArrangedSubview(basicItem)
        contentStack.addArrangedSubview(badgeItem)
    }
    
    private func addThumbnails() {
        let thumbnailStack = UIStackView()
        thumbnailStack.axis = .horizontal
        thumbnailStack.distribution = .equalSpacing
        thumbnailStack.spacing = 16
        
        // Small Circle
        let smallThumbnail = GDSThumbnail(config: .init(size: .small, shape: .circle))
        smallThumbnail.setIcon(.systemName("person.fill"))
        
        // Medium Square
        let mediumThumbnail = GDSThumbnail(config: .init(size: .medium, shape: .square))
        mediumThumbnail.setIcon(.systemName("cart.fill"))
        
        // Large Squircle
        let largeThumbnail = GDSThumbnail(config: .init(size: .large, shape: .squircle))
        largeThumbnail.setIcon(.systemName("star.fill"))
        
        [smallThumbnail, mediumThumbnail, largeThumbnail].forEach {
            thumbnailStack.addArrangedSubview($0)
        }
        
        contentStack.addArrangedSubview(thumbnailStack)
    }
    
    private func addShortcuts() {
        let shortcutStack = UIStackView()
        shortcutStack.axis = .horizontal
        shortcutStack.distribution = .fillEqually
        shortcutStack.spacing = 12
        
        let shortcuts = [
            ("cart.fill", "Food"),
            ("car.fill", "Ride"),
            ("box.fill", "Express")
        ]
        
        shortcuts.forEach { icon, title in
            let config = DuxtonShortcutModelConfig(
                icon: .systemName(icon),
                title: title
            )
            let shortcut = DuxtonShortcut(config: config)
            shortcutStack.addArrangedSubview(shortcut)
        }
        
        contentStack.addArrangedSubview(shortcutStack)
        shortcutStack.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
}

// MARK: - Playground Setup

let vc = PlaygroundViewController()
vc.preferredContentSize = CGSize(width: 375, height: 812)
PlaygroundPage.current.liveView = vc
PlaygroundPage.current.needsIndefiniteExecution = true

/*
 💡 사용 방법:
 
 1. 이 파일을 Xcode Playground로 실행
 2. 실시간으로 컴포넌트 수정 가능
 3. 색상, 크기, 텍스트 등을 바꿔가며 실험
 
 🎨 커스터마이징 예제:
 
 // 색상 변경
 DesignConstants.green -> DesignConstants.blue
 
 // 크기 변경  
 size: .medium -> size: .large
 
 // 스타일 변경
 style: .circle -> style: .squircle
 
 🚀 즐거운 바이브코딩 되세요!
 */
