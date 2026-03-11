# Slack Message for iOS Team

---

## 📋 복사해서 슬랙에 붙여넣기

```
Hi iOS PAX team! 👋

I'm trying to set up my local iOS development environment to run the Grab app in the simulator, but I'm getting a build error due to an expired provisioning profile.

## ❌ Error Details

**Error Message:**
```
ERROR: On target "@@//src/Grab/Internal:GrabNotification", 
provisioning profile ExpirationDate ("2026-01-07T10:00:06") is in the past.
Target //src/Grab/Internal:Grab failed to build
```

**Failed Target:** `//src/Grab/Internal:GrabNotification`

**File Location:** `/Users/suzyn.jang/Projects/pax-ios/src/Grab/Internal/BUILD.bazel` (line 1084-1127)

## 📅 Expiration Info

- **Profile Name:** `iOS Team Provisioning Profile: com.grabtaxi.iphone.notification`
- **Bundle ID:** `com.grabtaxi.iphone.notification`
- **Team ID:** C9YMA892DM
- **Expired Date:** January 7, 2026 at 10:00:06
- **Days Expired:** ~30 days (today is Feb 6, 2026)

## 🔧 My Environment

- **macOS:** Sequoia 15.7 (24G419)
- **Xcode:** 16.0 (Build 16A242d)
- **Bazel:** 8.4.2
- **Branch:** master
- **Device:** Apple Silicon Mac (M-series)
- **Target:** iPhone 16 Pro Simulator (iOS 18.0)

## 📍 What I'm Trying to Do

Build and run the Grab app on the iPhone 16 Pro simulator using:
- Workspace: `PAX.Bazel.xcworkspace`
- Scheme: `Grab`
- Configuration: Debug

## 🔍 Affected Provisioning Profiles

Based on the BUILD.bazel file, the following profiles are configured:

**Main App:**
- `PAX_Grab_DEBUG_provisioning_profile` (com.grabtaxi.iphone)

**Extensions:**
- `PAX_Grab_DEBUG_notification_provisioning_profile` (com.grabtaxi.iphone.notification) ❌ **EXPIRED**

## 📂 File References

**BUILD.bazel Location:**
`src/Grab/Internal/BUILD.bazel`

**Profile Definition:**
Lines 1084-1088 (profile definition)
Lines 1102-1127 (GrabNotification target configuration)

**Provisioning Profile Files:**
`Scripts/Signing/Secrets.enc/IOSCI_Dogfood_Debug_Notification.mobileprovision`

## ✅ What I Need

Could someone with Apple Developer account access please:
1. Regenerate the expired provisioning profile for **GrabNotification** extension
2. Update the BUILD.bazel file or provisioning profile files as needed
3. Push the changes so I (and others) can build the app

This is blocking my development environment setup - I've completed all other prerequisites successfully (SSH, JFrog, Xcode, dependencies, etc.).

## 📊 Setup Progress

✅ Command Line Tools installed
✅ Git configured
✅ Homebrew installed
✅ Xcode 16.0 installed
✅ SSH keys configured for GitLab
✅ Engineering-mobile & Gamma permissions granted
✅ JFrog credentials working
✅ Ruby 3.2.2 & Bundler installed
✅ Repository cloned
✅ Bazel 8.4.2 installed
✅ Dependencies installed
✅ Workspaces generated
❌ **Build fails due to expired provisioning profile**

## 🙏 Additional Notes

This seems to affect the whole team since the profile expired a month ago. I'm happy to test the fix once the new profiles are available!

Thanks for your help! 🚀

---

**User:** Suzyn Jang (@suzyn.jang)
**Slack Thread:** #ios-pax or #gai-design-vibecode-in-production
```

---

## 🎯 보낼 때 팁

1. **채널 선택:**
   - `#ios-pax` (iOS PAX 팀 메인 채널)
   - `#gai-design-vibecode-in-production` (바이브코드 전용 채널)
   - 또는 iOS 팀 리드에게 DM

2. **멘션 추가:**
   ```
   Hi @ios-team 또는 @[iOS 팀 리드 이름] 
   ```

3. **긴급도 표시 (필요시):**
   ```
   🔴 High Priority - Blocking development setup
   ```

4. **에러 로그 첨부 (선택사항):**
   - 전체 빌드 로그 스크린샷
   - 또는 에러 부분만 캡처

---

## 📸 함께 첨부하면 좋은 스크린샷

1. Xcode 빌드 에러 화면
2. 터미널 에러 출력
3. BUILD.bazel 파일의 해당 부분

---

## ✅ 메시지 전송 후

1. **확인 대기:** 팀 응답 대기 (보통 몇 시간 내)
2. **진행 상황 체크:** 프로파일 갱신 진행 중인지 확인
3. **테스트 준비:** 새 프로파일이 푸시되면 `git pull` 후 재빌드

---

**이 메시지를 복사해서 슬랙에 붙여넣으세요!** 📋
