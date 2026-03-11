# Grab Design System - 바이브코딩 치트시트

그랩 iOS 앱의 디자인 시스템 컴포넌트 사용 가이드

## 📚 목차
1. [색상 (Colors)](#색상-colors)
2. [버튼 (Buttons)](#버튼-buttons)
3. [리스트 아이템 (List Items)](#리스트-아이템-list-items)
4. [썸네일 (Thumbnails)](#썸네일-thumbnails)
5. [앱 바 (App Bar)](#앱-바-app-bar)
6. [숏컷 (Shortcuts)](#숏컷-shortcuts)
7. [드롭다운 (Dropdown)](#드롭다운-dropdown)

---

## 색상 (Colors)

### 위치
- 파일: `src/Platform/Shared/Theme/DesignConstants.swift`
- Pod: `Pods/GrabUIKit/`

### 주요 색상

```swift
// 브랜드 색상
DesignConstants.green           // #00B140 - 그랩 메인 그린
DesignConstants.lightGreen      // #38c564 - 라이트 그린

// 기능 색상
DesignConstants.blue            // #488be4 - 블루 (정보)
DesignConstants.red             // #d64425 - 레드 (경고/에러)
DesignConstants.yellow          // #f7c942 - 옐로우 (주의)

// 그레이 스케일
DesignConstants.grayXXL         // #363a45 - 진한 차콜
DesignConstants.grayXL          // #565D6B - 다크 그레이
DesignConstants.grayL           // #898d97 - 미디엄 그레이
DesignConstants.grayM           // #ccd6dd - 라이트 그레이
DesignConstants.grayS           // #eaeff2 - 매우 밝은 그레이
DesignConstants.grayXS          // #f7f9fb - 백그라운드 그레이
```

### 사용 예제

```swift
view.backgroundColor = DesignConstants.grayXS
titleLabel.textColor = DesignConstants.grayXXL
button.backgroundColor = DesignConstants.green
```

---

## 버튼 (Buttons)

### DuxtonPrimaryButton (메인 버튼)

```swift
let button = DuxtonPrimaryButton()
button.setTitle("Book Now", for: .normal)
button.addTarget(self, action: #selector(bookTapped), for: .touchUpInside)

// 레이아웃
button.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    button.heightAnchor.constraint(equalToConstant: 48),
    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
])
```

### DuxtonSecondaryButton (보조 버튼)

```swift
let button = DuxtonSecondaryButton()
button.setTitle("Cancel", for: .normal)
// 사용법은 Primary Button과 동일
```

### 버튼 상태

```swift
button.isEnabled = false  // 비활성화
button.isLoading = true   // 로딩 상태 (있는 경우)
```

---

## 리스트 아이템 (List Items)

### DuxtonListItemV3 (최신 버전)

```swift
// 기본 리스트 아이템
let config = DuxtonListItemV3Config(
    leading: .init(
        thumbnail: .init(
            media: .icon(.systemName("star.fill")),
            size: .medium,
            style: .circle
        )
    ),
    primary: .init(
        title: .init(text: "Restaurant Name", style: .heading3),
        subtitle: .init(text: "Thai Cuisine", style: .body2)
    ),
    trailing: .init(
        accessory: .chevron
    )
)
let listItem = DuxtonListItemV3(config: config)
```

### 이미지가 있는 리스트 아이템

```swift
let config = DuxtonListItemV3Config(
    leading: .init(
        thumbnail: .init(
            media: .image(UIImage(named: "food_image")),
            size: .large,
            style: .squircle
        )
    ),
    primary: .init(
        title: .init(text: "Pad Thai", style: .heading3),
        subtitle: .init(text: "$12.50", style: .body2)
    ),
    trailing: .init(
        text: .init(text: "30 min", style: .caption1)
    )
)
```

### 리스트 아이템 스타일

- **Thumbnail 크기**: `.small`, `.medium`, `.large`, `.xLarge`
- **Thumbnail 모양**: `.circle`, `.square`, `.squircle`
- **Trailing Accessory**: `.chevron`, `.checkbox`, `.radio`, `.switch`

---

## 썸네일 (Thumbnails)

### GDSThumbnail

```swift
// 원형 썸네일
let config = GDSThumbnailContainerConfig(
    size: .large,
    shape: .circle
)
let thumbnail = GDSThumbnail(config: config)
thumbnail.setImage(UIImage(named: "profile_image"))

// 아이콘 사용
thumbnail.setIcon(.systemName("person.fill"))
```

### 썸네일 크기

```swift
.small      // 24x24
.medium     // 40x40  
.large      // 56x56
.xLarge     // 72x72
```

### 뱃지가 있는 썸네일

```swift
let thumbnail = GDSThumbnail(config: config)
thumbnail.setBadge(
    icon: .systemName("checkmark"),
    backgroundColor: DesignConstants.green
)
```

---

## 앱 바 (App Bar)

### DuxtonAppBar

```swift
// 기본 앱 바
let config = DuxtonAppBarConfig(
    title: "Home",
    leftButton: .back,
    rightButtons: [
        .icon(.systemName("bell")),
        .icon(.systemName("ellipsis"))
    ]
)
let appBar = DuxtonAppBar(config: config)
```

### 앱 바 스타일

```swift
// 뒤로가기 버튼
leftButton: .back

// 닫기 버튼  
leftButton: .close

// 커스텀 버튼
leftButton: .icon(.systemName("arrow.left"))

// 타이틀 + 서브타이틀
let config = DuxtonAppBarConfig(
    title: "Current Location",
    subtitle: "123 Main Street",
    leftButton: .back
)
```

### 앱 바 액션

```swift
appBar.leftButtonTapped = { [weak self] in
    self?.navigationController?.popViewController(animated: true)
}

appBar.rightButtonTapped = { [weak self] index in
    switch index {
    case 0: self?.showNotifications()
    case 1: self?.showMenu()
    default: break
    }
}
```

---

## 숏컷 (Shortcuts)

### DuxtonShortcut

```swift
// 아이콘 + 텍스트 숏컷
let config = DuxtonShortcutModelConfig(
    icon: .systemName("cart.fill"),
    title: "Food",
    subtitle: "Order now"
)
let shortcut = DuxtonShortcut(config: config)

// 탭 액션
shortcut.addTarget(self, action: #selector(shortcutTapped), for: .touchUpInside)
```

### 숏컷 레이아웃 (가로 스크롤)

```swift
let scrollView = UIScrollView()
let stackView = UIStackView()
stackView.axis = .horizontal
stackView.spacing = 16

let shortcuts = [
    createShortcut(icon: "cart.fill", title: "Food"),
    createShortcut(icon: "car.fill", title: "Ride"),
    createShortcut(icon: "shippingbox.fill", title: "Express")
]

shortcuts.forEach { stackView.addArrangedSubview($0) }
scrollView.addSubview(stackView)
```

---

## 드롭다운 (Dropdown)

### DuxtonDropdown

```swift
// 드롭다운 모델
let model = DuxtonDropdownModel(
    title: "Select Country",
    placeholder: "Choose a country",
    options: ["Singapore", "Malaysia", "Thailand", "Vietnam"]
)

let dropdown = DuxtonDropdown(model: model)

// 선택 이벤트
dropdown.onSelectionChanged = { [weak self] selectedIndex in
    print("Selected: \(model.options[selectedIndex])")
}
```

### 드롭다운 상태

```swift
dropdown.setState(.normal)    // 일반 상태
dropdown.setState(.error(message: "Please select a country"))  // 에러 상태
dropdown.setState(.disabled)  // 비활성화
```

---

## 💡 실전 사용 팁

### 1. 컴포넌트 검색 방법

```bash
# GrabUIKit 컴포넌트 찾기
cd ~/Projects/pax-ios
find Pods/GrabUIKit -name "Duxton*.swift" -type f

# 특정 컴포넌트 사용 예제 찾기
grep -r "DuxtonButton" src/ --include="*.swift"
```

### 2. 디자인 토큰 참조

모든 색상, 간격, 폰트는 `DesignConstants.swift`에 정의되어 있습니다:

```swift
// 간격 (Spacing)
let smallPadding: CGFloat = 8
let mediumPadding: CGFloat = 16
let largePadding: CGFloat = 24

// 폰트 크기
let heading1: CGFloat = 28
let heading2: CGFloat = 24
let heading3: CGFloat = 20
let body1: CGFloat = 16
let body2: CGFloat = 14
let caption: CGFloat = 12
```

### 3. Auto Layout 헬퍼

```swift
extension UIView {
    func pinToEdges(of superview: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
        ])
    }
}
```

### 4. 디버깅

```swift
// 컴포넌트 경계 표시
view.layer.borderWidth = 1
view.layer.borderColor = UIColor.red.cgColor

// 배경색으로 레이아웃 확인
view.backgroundColor = .systemPink.withAlphaComponent(0.3)
```

---

## 📱 실제 앱에서 사용된 예제 찾기

```bash
# Food 앱의 리스트 사용 예제
open ~/Projects/pax-ios/src/Food/Internal/Food/

# Transport 앱의 버튼 사용 예제
open ~/Projects/pax-ios/src/Transport/Internal/

# Payments 앱의 UI 컴포넌트
open ~/Projects/pax-ios/src/Payments/Internal/PaymentsUIKit/
```

---

## 🔗 참고 자료

- **Grab Design Wiki**: https://wiki.grab.com/display/DESIGN/Colors
- **GrabUIKit Repo**: `Pods/GrabUIKit/`
- **Design Constants**: `src/Platform/Shared/Theme/DesignConstants.swift`
- **Example App**: `Pods/GrabUIKit/Example/`

---

## ⚡️ 빠른 시작

1. 데모 파일 열기: `GrabUIKitDemo.swift`
2. Xcode에서 프리뷰 켜기: `Option + Cmd + Return`
3. 실시간으로 UI 수정하며 바이브코딩 시작! 🎨

---

**Happy Vibecoding! 🚀**
