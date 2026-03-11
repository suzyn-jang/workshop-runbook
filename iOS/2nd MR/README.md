# 🎨 Grab Design System - 바이브코딩 시작하기

그랩 iOS 디자인 시스템을 사용한 빠른 UI 개발 가이드

## 📁 파일 구조

```
2nd MR/
├── GrabUIKitDemo.swift          # 메인 데모 뷰컨트롤러
├── GrabUIKitPlayground.swift    # 인터랙티브 플레이그라운드
├── GrabUIKit_CheatSheet.md      # 컴포넌트 치트시트
└── README.md                     # 이 파일
```

## 🚀 빠른 시작

### 1. 프로젝트에서 GrabUIKit 사용하기

```swift
import GrabUIKit

// 버튼 만들기
let button = DuxtonPrimaryButton()
button.setTitle("Book Ride", for: .normal)

// 색상 사용하기
view.backgroundColor = DesignConstants.grayXS
label.textColor = DesignConstants.green
```

### 2. 데모 파일 실행하기

#### Option A: Xcode에서 실행
1. Xcode에서 `GrabUIKitDemo.swift` 열기
2. 파일 상단에 `import GrabUIKit` 확인
3. Cmd + R 로 실행

#### Option B: SwiftUI 프리뷰 사용
1. `GrabUIKitDemo.swift` 파일 열기
2. `Option + Cmd + Return` 눌러 프리뷰 켜기
3. 실시간으로 코드 수정하며 확인

### 3. Playground로 실험하기

```bash
# Playground 파일을 Xcode에서 열기
open GrabUIKitPlayground.swift
```

## 📚 주요 컴포넌트

### 버튼 (Buttons)
- `DuxtonPrimaryButton` - 메인 액션 버튼
- `DuxtonSecondaryButton` - 보조 액션 버튼

### 리스트 (List Items)
- `DuxtonListItemV3` - 표준 리스트 아이템
- 썸네일, 타이틀, 서브타이틀, 액세서리 지원

### 썸네일 (Thumbnails)
- `GDSThumbnail` - 다양한 크기/모양의 썸네일
- 원형, 사각형, 스쿼클 지원

### 앱 바 (Navigation)
- `DuxtonAppBar` - 네비게이션 바
- 타이틀, 버튼, 액션 지원

### 숏컷 (Shortcuts)
- `DuxtonShortcut` - 아이콘 기반 액션 버튼
- 홈 화면 퀵 액션용

## 🎨 디자인 토큰

### 색상 시스템

```swift
// 브랜드 컬러
DesignConstants.green        // 그랩 그린
DesignConstants.blue         // 인포 블루
DesignConstants.red          // 에러 레드

// 그레이스케일
DesignConstants.grayXXL      // 헤딩/본문
DesignConstants.grayL        // 보조 텍스트
DesignConstants.grayM        // 보더/구분선
DesignConstants.grayXS       // 배경
```

### 간격 (Spacing)

```swift
let extraSmall: CGFloat = 4
let small: CGFloat = 8
let medium: CGFloat = 16
let large: CGFloat = 24
let extraLarge: CGFloat = 32
```

### 타이포그래피

```swift
let heading1 = UIFont.systemFont(ofSize: 28, weight: .bold)
let heading2 = UIFont.systemFont(ofSize: 24, weight: .bold)
let heading3 = UIFont.systemFont(ofSize: 20, weight: .semibold)
let body1 = UIFont.systemFont(ofSize: 16, weight: .regular)
let body2 = UIFont.systemFont(ofSize: 14, weight: .regular)
let caption = UIFont.systemFont(ofSize: 12, weight: .regular)
```

## 💡 실전 팁

### 1. 컴포넌트 빠르게 찾기

```bash
# GrabUIKit 컴포넌트 검색
cd ~/Projects/pax-ios
find Pods/GrabUIKit -name "*.swift" | grep -i "button"
```

### 2. 실제 앱 코드에서 예제 찾기

```bash
# Food 앱 예제
open ~/Projects/pax-ios/src/Food/Internal/

# Transport 앱 예제
open ~/Projects/pax-ios/src/Transport/Internal/

# Payments 앱 예제
open ~/Projects/pax-ios/src/Payments/Internal/
```

### 3. 레이아웃 헬퍼 사용

```swift
// 컴포넌트를 슈퍼뷰에 꽉 채우기
view.pinToEdges(of: superview)

// 마진과 함께 채우기
view.pinToEdges(of: superview, insets: .init(top: 16, left: 16, bottom: 16, right: 16))
```

### 4. 디버깅 팁

```swift
// 레이아웃 경계 표시
view.layer.borderWidth = 1
view.layer.borderColor = UIColor.red.cgColor

// 배경색으로 영역 확인
view.backgroundColor = .systemPink.withAlphaComponent(0.2)
```

## 📖 추가 학습 자료

### 문서
- **치트시트**: `GrabUIKit_CheatSheet.md` - 모든 컴포넌트 사용법
- **데모 코드**: `GrabUIKitDemo.swift` - 실제 동작하는 예제
- **플레이그라운드**: `GrabUIKitPlayground.swift` - 인터랙티브 실험

### 코드 위치
- **GrabUIKit Pod**: `~/Projects/pax-ios/Pods/GrabUIKit/`
- **Design Constants**: `~/Projects/pax-ios/src/Platform/Shared/Theme/DesignConstants.swift`
- **실제 앱 코드**: `~/Projects/pax-ios/src/[Food|Transport|Payments]/`

### 온라인 리소스
- **Grab Design Wiki**: https://wiki.grab.com/display/DESIGN/
- **GitLab**: https://gitlab.myteksi.net/mobile/payments/iOS-Payments/grabuikit

## 🛠 문제 해결

### Q: GrabUIKit import가 안돼요
```bash
# Pod 다시 설치
cd ~/Projects/pax-ios
bundle exec pod install
```

### Q: 컴포넌트가 제대로 표시되지 않아요
```swift
// Auto Layout 제약 조건 확인
view.translatesAutoresizingMaskIntoConstraints = false

// 높이 제약 조건 추가
view.heightAnchor.constraint(equalToConstant: 48).isActive = true
```

### Q: 프리뷰가 작동하지 않아요
1. Xcode 16.0 사용 중인지 확인
2. `Option + Cmd + Return` 으로 프리뷰 재시작
3. Product > Clean Build Folder 후 재빌드

## 🎯 다음 단계

1. ✅ 데모 파일 실행해보기
2. ✅ 치트시트 참고하며 컴포넌트 익히기
3. ✅ 실제 앱 코드에서 사용 패턴 학습
4. ✅ 나만의 커스텀 뷰 만들기

## 💬 도움이 필요하면

- **Slack**: `#gai-design-vibecode-in-production`
- **iOS 팀**: iOS PAX 팀 채널
- **문서**: Grab Design Wiki

---

**Happy Vibecoding! 🚀**

Made with ❤️ for Grab Designers & PMs
