# BSSocialManager
Simple manager for get token from VK, FB, Twitter, Odnoklassniki.

### Download
##### Submodule
```
git clone https://github.com/BenjaminSarkisyan/BSSocialManager --recursive
```
##### Cocoapods
```
pod 'OK-ios-sdk',       :git => 'https://github.com/apiok/ok-ios-sdk'
pod 'BSSocialManager',  :git => 'https://github.com/BenjaminSarkisyan/BSSocialManager'
```

### Install
<!--![Image](http://s12.postimg.org/m4aa7v0q5/Social_Settings.png)-->
1. Add in Info.plist<br/>
```XML
<key>Social Settings</key>
<dict>
	<key>FB</key>
	<dict>
		<key>FBAppID</key>
		<string>FB_APP_ID</string>
		<key>FBAppName</key>
		<string>FB_APP_NAME</string>
		<key>FBPermissions</key>
		<array>
			<string>email</string>
		</array>
	</dict>
	<key>OK</key>
	<dict>
		<key>OKAppID</key>
		<string>OK_APP_ID</string>
		<key>OKAppKey</key>
		<string>OK_APP_KEY</string>
		<key>OKAppSecret</key>
		<string>OK_APP_SECRET</string>
		<key>OKPermissions</key>
		<array/>
	</dict>
	<key>TW</key>
	<dict>
		<key>TWAppID</key>
		<string>TW_APP_ID</string>
		<key>TWAppSecret</key>
		<string>TW_APP_SECRET</string>
	</dict>
	<key>VK</key>
	<dict>
		<key>VKAppID</key>
		<string>VK_APP_ID</string>
		<key>VKPermissions</key>
		<array>
			<string>wall</string>
		</array>
	</dict>
</dict>
```
<br/>
2. Add facebook url scheme in format "fb\<FB_APP_ID\>"<br/>
3. Use

### How to use
```
VK:[SocialManager loginToVKWithSuccess:^(NSString *token){} failure:^(NSError *error){}];
FB:[SocialManager loginToFBWithSuccess:^(NSString *token){} failure:^(NSError *error){}];
TW:[SocialManager loginToTWWithSuccess:^(NSString *token){} failure:^(NSError *error){}];
OK:[SocialManager loginToOKWithSuccess:^(NSString *token){} failure:^(NSError *error){}];
```
