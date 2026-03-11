import UIKit
import PlaygroundSupport

// 🎨 간단한 Grab 디자인 시스템 데모
// 빌드 없이 바로 실행 가능!

class SimpleDemo: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        // 간단한 버튼 만들기
        let button = UIButton(type: .system)
        button.setTitle("Grab Style Button", for: .normal)
        button.backgroundColor = UIColor(red: 0, green: 0.69, blue: 0.25, alpha: 1) // Grab Green
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // 타이틀 추가
        let titleLabel = UILabel()
        titleLabel.text = "Grab Design System"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = UIColor(red: 0.21, green: 0.23, blue: 0.27, alpha: 1) // Grab Dark
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -32)
        ])
        
        // 서브타이틀 추가
        let subtitleLabel = UILabel()
        subtitleLabel.text = "빌드 없이 바로 실행! ✨"
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = UIColor(red: 0.54, green: 0.55, blue: 0.59, alpha: 1) // Grab Gray
        
        view.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16)
        ])
    }
}

// Playground 실행
let vc = SimpleDemo()
vc.preferredContentSize = CGSize(width: 375, height: 667)
PlaygroundPage.current.liveView = vc
