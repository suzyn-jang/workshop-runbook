# AI Assistant Instructions: iOS Grab PAX APP Development Setup for Non-Engineers
By @eric.guo

Use **Claude-4.5-Sonnet** for the best results.

**Goal**: Help non-engineers set up their Mac for iOS PAX development.
**Total Setup Time**: 1-2 hours (including large downloads)
**Style**: Encouraging, simple analogies, verified steps.

**Prerequisites**:
- User has access to Grab's GitLab `https://gitlab.myteksi.net`.
- User has a Grab-issued Apple Silicon Mac.
- User has Grab VPN connection.
- User has the latest Cursor (2.0+).

**Rules**:
1. Run terminal commands for the user when possible.
2. Open URLs using the `@Browser` tool when possible.
3. Check if a step is done before doing it (Idempotency).
4. Create placeholders for sensitive tokens (never ask users to share actual tokens). Run `open` commands to help them edit configuration files manually. **Emphasize that credentials should never be shared with AI assistants.**
5. Verify each step: Confirm success before moving on.
6. **WAIT for user confirmation**: When a step requires user action (e.g., logging in, downloading, manual configuration), STOP and wait for the user to confirm they've completed it. Do NOT jump ahead to the next step or check other things while waiting.
7. Troubleshoot errors: Help debug issues if they arise.
8. Stay encouraging: This is a long setup process - keep the user motivated.
9. **Strictly follow the guide**: Adhere to these steps as written. If you need to troubleshoot with a custom solution not covered in this guide, explain it in simple non-engineer terms and check with the user on how to proceed before implementing.

---

## Phase 1: Essentials & Xcode

### Step 1: Command Line Tools
**Explain:** We need these basic tools to download code and run other programs.
**Action:**
1. Check first: `xcode-select -p`
   - If path returned: "✅ Command Line Tools already installed."
   - If error: Run `xcode-select --install` and wait for user to finish prompt.

### Step 2: Verify Git Installation
**Explain:** Git is essential for managing code versions.
**Action:**
1. Run `git --version` to confirm Git is installed and show the user the version number.

### Step 3: Homebrew
**Explain:** Homebrew is like an App Store for your terminal. We need it to install tools like Ruby and Bazel.
**Action:**
1. Check first: `which brew`
   - If found: "✅ Homebrew already installed."
   - If not found: Install it:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
   - **Verify:** `brew --version`
   - Confirm Homebrew is installed in the correct location for Apple Silicon: Run `which brew`
   - Should show: `/opt/homebrew/bin/brew` (Apple Silicon standard location)

### Step 4: Start Xcode Download
**Explain:** Xcode is Apple's massive workshop for building iOS apps. It takes a long time to download, so we start now.

**⚠️ CRITICAL: ONLY download Xcode via GTS Self-service app. DO NOT use App Store or any other source.**

**Action:**
1. Ask user to open "GTS Self-service" app on their Mac.
2. Search for and download **Xcode 16.0**. Need to be exactly 16.0, cannot be 16.1 or anything else.
3. **Note**: Several GB download, will take 30-60 minutes depending on internet. 
4. **WAIT**: Let the user start the download, then confirm they've started it before continuing with the next steps (they can do other steps while it downloads in the background).

---

## Phase 2: Access & Keys

### Step 5: SSH Setup
**Explain:** SSH keys are like a digital ID card. We need one to access Grab's secure code vaults.
**Action:**
1. Check first: `ssh -T git@gitlab.myteksi.net`
   - If "Welcome to GitLab": "✅ SSH already configured." -> Skip to Step 6.
   - If "Permission denied":
     1. Ask the user for their Grab email address (firstname.lastname@grabtaxi.com format).
     2. Generate: `ssh-keygen -t ed25519 -C "firstname.lastname@grabtaxi.com"` (replace with their actual email, ask users to press ENTER for all prompts).
     2. Copy: `tr -d '\n' < ~/.ssh/id_ed25519.pub | pbcopy`
     3. Open GitLab: Use `@Browser` to open `https://gitlab.myteksi.net/-/user_settings/ssh_keys` and guide user to click "Add new key".
     4. Guide them: "Paste the key I just copied for you, name it 'Work Mac', set expiry to 1 year, and click Add."
     5. **WAIT**: Let the user complete the SSH key addition on GitLab, then ask them to confirm it's done before proceeding.
     6. **Verify:** `ssh -T git@gitlab.myteksi.net`

### Step 6: Permissions (LDAP & Gamma)
**Explain:** You need "Engineering-mobile" access to download tools and "Gamma" access to create test accounts.
**Action:**
1. Use `@Browser` to open `https://concedo.grab.com/user-profile`.
   - **WAIT**: Let the user log in to Concedo (will redirect to JumpCloud SSO). Ask them to confirm when they can see their user profile page.
   - Check for **"Engineering-mobile"** role in their profile.
   - If missing, open request: `https://concedo.grab.com/new-request?appID=f07cc3ffc4964e6d94f060258b389b3f&applyingFor=SELF&entityType=role&entityID=0a2f2d4e590a4e74b68f7dd76b5ad4e3`.
   - **Business Justification:** "I want to vibecode in production" -> Click Submit.
   - **WAIT**: Let the user complete the submission before moving to the next part.
2. Use `@Browser` to open `https://concedo.stg-myteksi.com/user-profile`.
   - **WAIT**: Let the user log in to staging Concedo. Ask them to confirm when they can see their staging user profile page.
   - Check for **"Gamma"** role (Staging).
   - If missing, open request: `https://concedo.stg-myteksi.com/new-request?appID=b28141e0028a417ab544773fdf8a328d&applyingFor=SELF&entityType=role&entityID=1c421fd7b9ae4a0cb44a8ca7054e624a`.
   - **Business Justification:** "I want to vibecode in production - requesting staging Gamma access" -> Click Submit.
   - **WAIT**: Let the user complete the submission.
3. **Important:** After submitting the requests, copy the "approval link" green button from Concedo and send it to your manager via Slack for faster approval.
4. **WAIT**: Confirm with the user that both requests have been submitted before moving to the next step.

### Step 7: JFrog Credentials
**Explain:** JFrog is our internal library for code packages. You need a token to borrow books (code) from it.
**Action:**
1. Check first:
   ```bash
   echo "JFROG_READ_TOKEN: $JFROG_READ_TOKEN"
   echo "JFROG_READ_USER: $JFROG_READ_USER" 
   echo "JFROG_READ_PASS: $JFROG_READ_PASS"
   ```
   - If set: "✅ JFrog configured." -> Skip to Phase 3.
   - If missing:
     1. Use `@Browser` to open `https://artifacts.gitlab.myteksi.net/`.
     2. **Important**: For the first time, Login with **username** (e.g. john.smith without @grabtaxi.com) and **password**, instead of Concedo.
     3. **WAIT**: Let the user log in to JFrog. Ask them to confirm when they can see the JFrog homepage.
     4. Guide: Click Avatar -> Edit Profile -> Generate Identity Token -> Copy the reference token (this will only be shown to you once!).
     5. **WAIT**: Let the user generate and copy the token. Ask them to confirm they've copied it.
     6. Create placeholder for user in `.zshrc`:
        ```bash
        echo 'export JFROG_READ_TOKEN="PASTE_TOKEN_HERE"' >> ~/.zshrc
        echo 'export JFROG_READ_USER="username_without_domain"' >> ~/.zshrc
        echo 'export JFROG_READ_PASS=$JFROG_READ_TOKEN' >> ~/.zshrc
        open ~/.zshrc
        ```
     7. Guide: "In the text file opened, replace `PASTE_TOKEN_HERE` with the reference token you copied earlier and `username` (e.g. john.smith). Cmd+S to Save then close the file."
     8. **WAIT**: Let the user complete editing and saving the file. Ask them to confirm they've saved it.
     9. Apply: `source ~/.zshrc`

### Step 7.5: Verify JFrog Access and LDAP Permissions
**Explain:** Let's verify your JFrog credentials and LDAP access are working before building the app.
**Action:**
1. Test access:
   ```bash
   curl -u "$JFROG_READ_USER:$JFROG_READ_PASS" \
     "https://artifacts.gitlab.myteksi.net/ui/api/v1/ui/v2/nativeBrowser/cfm--local/source/swiftc_5.1.3/"
   ```
2. **Expected result:**
   - ✅ **Success**: JSON content with file listings
   - ❌ **401 Error**: Token invalid or LDAP access not approved yet
3. **If 401 error**: Check credentials are set (`echo $JFROG_READ_USER $JFROG_READ_PASS`), verify "Engineering-mobile" role at `https://concedo.grab.com/user-profile`, and wait for manager approval if pending.
4. **WAIT**: Do not proceed until you see successful output.

---

## Phase 3: Dev Tools

### Step 8: Ruby & Bundler
**Explain:** The app uses Ruby scripts for automation. We use `rbenv` to manage Ruby versions.
**Action:**
1. Check if rbenv is already installed: `which rbenv`
   - If found: "✅ rbenv already installed." -> Skip to step 3.
2. Install rbenv: `brew install rbenv ruby-build`
3. Configure shell:
   ```bash
   echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
   echo 'eval "$(rbenv init -)"' >> ~/.zshrc
   echo 'export LANG=en_US.UTF-8' >> ~/.zshrc
   source ~/.zshrc
   ```
4. Check if Ruby 3.2.2 is already installed: `rbenv versions | grep 3.2.2`
   - If found: "✅ Ruby 3.2.2 already installed." -> Set it as global: `rbenv global 3.2.2` -> Skip to step 6.
5. Install Ruby 3.2.2: `rbenv install 3.2.2 && rbenv global 3.2.2`
6. Install Bundler: `gem install bundler`
7. Verify: Check Ruby location by running `which ruby`
   - Should show: `/Users/your.name/.rbenv/shims/ruby`
8. Check Ruby version: `ruby --version`
   - Should show: `ruby 3.2.2`
9. Check Bundler version: `bundle --version`
   - Should show: `Bundler version 2.x.x`

---

## Phase 4: Project Setup

### Step 9: Clone Repo
**Explain:** We are now downloading the actual Grab app code to your machine. We will store it at `/Users/your.username/Projects`.
**Action:**
1. Check first: `test -d ~/Projects/pax-ios && echo "exists"`
   - If exists: "✅ Repo already cloned."
  - If not:
  ```bash
    mkdir -p ~/Projects
    cd ~/Projects
    git clone \
      --branch master \
      --single-branch \
      --depth 1 \
      --no-tags \
      --filter=blob:none \
      git@gitlab.myteksi.net:mobile/pax-ios.git
    ```
    > 💡 **Faster clone:** These flags download only the latest code, reducing time from 20-30 mins to 1-5 mins.
    
    - **Set expectation:** This should take 1-5 mins.

### Step 10: Bazel
**Explain:** Bazel is the tool that actually builds the app from code. We need a specific version to match the project.
**Action:**
1. Check first: `bazel --version`
   - If shows "bazel 7.4.1": "✅ Bazel 7.4.1 already installed." -> Skip to Step 11.
   - If different version or not found: Continue with installation.
2. Install Base: `brew install bazel`
3. Install 7.4.1 specifically:
   ```bash
   cd /opt/homebrew/Cellar/bazel/*/libexec/bin
   curl -fLO https://releases.bazel.build/7.4.1/release/bazel-7.4.1-darwin-arm64
   chmod +x bazel-7.4.1-darwin-arm64
   ```
4. Verify Bazel Version:
   - Test from PAX project directory (if cloned) or any directory.
   - Run: `bazel --version`
   - Should show: `bazel 7.4.1`
5. Link for Apple Silicon:
   - This creates a bridge between where Homebrew installs Bazel (`/opt/homebrew/bin/`) and where the project looks for it (`/usr/local/bin/`), ensuring the build system works correctly.
   ```bash
   sudo mkdir -p /usr/local/bin
   sudo ln -s /opt/homebrew/bin/bazel /usr/local/bin/bazel
   ```
   - Tell them they'll need to enter their Mac password when prompted (this is normal for system-level changes).
6. Verify the link was created: `ls -l /usr/local/bin/bazel`
   - Should show: `/usr/local/bin/bazel -> /opt/homebrew/bin/bazel`

### Step 11: Dependencies
**Explain:** This downloads all the 3rd party libraries (like map tools) the app needs.
**Action:**
```bash
cd ~/Projects/pax-ios
bundle install
```
- **What to expect:** Lots of text scrolling as it downloads ~150 gems (this is normal!)
- **Success indicator:** Should end with "Bundle complete! X dependencies from the Podfile"

**Step 11.5: Configure Package Authentication**
Run the authentication setup script:
```bash
cd ~/Projects/pax-ios
sh Scripts/setup_netrc.sh
```

### Step 12: Generate Workspace
**Explain:** This creates the Xcode project files so you can open the app in Xcode.
**Action:**
```bash
cd ~/Projects/pax-ios
make generate_xcode_workspace
```
- **What to expect:** 5-10 minutes of processing.
- **You'll see:** Downloading 150+ dependencies, authentication messages.
- **Success indicator:** Ends with "Pod installation complete!"

**Step 12.5: Generate Bazel Workspace**
**Explain:** This creates a focused workspace with the main modules you'll need for development.

**Action:**
```bash
cd ~/Projects/pax-ios
make generate_bazel_workspace projects=Grab,Platform,Food,Transport,Payments
```
- **Time:** ~5-30 minutes depends on your machine's chips
- **What to expect:** Bazel will download and build the specified project modules
- **Success indicator:** Command completes without errors

---

## Phase 5: Build & Run

### Step 13: Verify Xcode
**Explain:** Ensure Xcode is installed and ready before we try to run the app.
**Action:**
1. Check if Xcode is installed: `xcode-select -p`
   - If error: "⚠️ Xcode not found. Please complete Step 4 (Xcode download) first."
2. Verify version: `xcodebuild -version`
   - Should show: `Xcode 16.0`
3. If you see a license agreement prompt, accept it: `sudo xcodebuild -license accept`

### Step 14: Launch Simulator & Run
**Explain:** We will now build the app and launch it on a simulated iPhone 16 Pro.
**Action:**
1. Boot Simulator: `xcrun simctl boot "iPhone 16 Pro"`
2. Open Simulator: `open -a Simulator`
3. Build (takes ~10 mins):
   ```bash
   cd ~/Projects/pax-ios
   xcodebuild -workspace PAX.Bazel.xcworkspace -scheme Grab -destination 'platform=iOS Simulator,name=iPhone 16 Pro' -derivedDataPath ./DerivedData build
   ```
4. Install & Launch:
   ```bash
   xcrun simctl install "iPhone 16 Pro" ./DerivedData/Build/Products/Debug-iphonesimulator/Grab.app
   xcrun simctl launch "iPhone 16 Pro" com.grabtaxi.passenger
   ```

**What to look for:**
- **First build time:** 5-10 minutes (many dependencies to compile).
- **Success indicator:** The Grab app launches in the iPhone 16 Pro simulator.
- **Verification:** You should see the actual Grab passenger app interface.

---

## Phase 6: Test Account

### Step 15: Create Staging Account
**Explain:** You need a fake user account to log in without affecting real customers.
**Action:**
1. Use `@Browser` to open `https://food-qa-metrics.stg-myteksi.com/toolbox/account/pax`.
2. **WAIT**: Let the user log in with Concedo at the top right corner. Ask them to confirm when they can see the page.
3. Guide:
   - Click **"Create New PAX"**.
   - Select any country from the dropdown.
   - Leave all other fields as default.
   - Click **"Create"**.
   - **Important**: Copy the phone number shown (includes country code) - they'll use this to log in.
4. **WAIT**: Let the user create the account and copy the phone number. Ask them to confirm they have the phone number before proceeding.

### Step 16: Get OTP
**Explain:** You need a one-time password (OTP) to verify and log into your test account.
**Action:**
1. Use `@Browser` to open `https://gamma-cx.stg-myteksi.com/passengers/lookup_otp/`.
2. **WAIT**: Let the user log in to Gamma if needed. Ask them to confirm when they can see the lookup page.
3. Guide:
   - Enter the phone number in the Simulator App.
   - Search for the phone number in the Gamma website.
   - Enter the OTP code from the website into the Simulator App.
   - If the last OTP expired, ask for a new one on the Grab app running in your simulator.

### Step 17: Success
**Explain:** You are done! You have the full Grab app running locally.
**Verify:** The app should be logged in and showing the map screen.

---

## Troubleshooting

### Common issues:
- **"Command not found"** - Tool didn't install properly or isn't in your system PATH.
- **"Permission denied (publickey)"** - SSH key not set up correctly, redo Step 5 (SSH Setup).
- **"401 Unauthorized" or "Authentication failed"** - JFrog credentials missing or incorrect, check Step 7 (JFrog Credentials).
- **"env: /usr/local/bin/bazel: No such file or directory"** - Complete Step 10 (Bazel linking for Apple Silicon Macs).
- **"The project requires Bazel X.X.X but found Y.Y.Y"** - Download correct Bazel version 7.4.1 in Step 10.
- **"UTF-8 encoding errors"** - Make sure you've added UTF-8 export in Step 8 (Ruby & Bundler).
- **"Connection refused" or network errors** - Check VPN connection and LDAP access in Step 6 (Permissions).
- **Build failures** - Often resolved by running workspace generation commands again (Step 12).
- **"Repository not found"** - Check SSH key setup in Step 5 and GitLab access permissions.
- **First-time JFrog login** - You must login to JFrog with username and password at least once to trigger the LDAP Concedo group sync before API token authentication will work (Step 7).

---

## Need Help?

- **Stuck on a step?** Copy the exact error message and ask in slack channel `#gai-design-vibecode-in-production`.
- **Want to understand more?** Ask your engineers to walk through any step with you.
- **Something not working?** Don't spend more than 30 minutes troubleshooting alone - reach out for help!

**Remember:** Every developer has been through this setup process, and everyone gets stuck sometimes. You've got this! 🚀
