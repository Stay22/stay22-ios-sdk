# Stay22 iOS SDK

Native iOS SDK for notification-driven accommodation discovery. When your app captures
a destination, dates or a hotel, the SDK can schedule one local notification that opens
a Stay22 booking page for that trip.

- No third-party dependencies · iOS 15+ · Swift 5.9+
- Ships an Apple privacy manifest
- You control enablement, notification permission and user consent

## Installation

The SDK is distributed as a prebuilt binary `Stay22SDK.xcframework`. Use Swift Package
Manager (recommended) or embed the framework manually.

### Swift Package Manager (recommended)

In Xcode, choose **File > Add Package Dependencies…**, enter the repository URL, and
select the **Up to Next Major Version** rule starting at `3.1.1`:

```text
https://github.com/Stay22/stay22-ios-sdk
```

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Stay22/stay22-ios-sdk.git", from: "3.1.1")
]
```

Then add the `Stay22SDK` product to your app target:

```swift
.target(
    name: "YourApp",
    dependencies: [
        .product(name: "Stay22SDK", package: "stay22-ios-sdk")
    ]
)
```

`Stay22SDK` is a binary target, so SPM downloads the prebuilt `.xcframework` directly;
there is nothing to compile from source.

### Manual (XCFramework)

Download `Stay22SDK.xcframework.zip` from this repository's
[Releases](https://github.com/Stay22/stay22-ios-sdk/releases), unzip it, and add
`Stay22SDK.xcframework` to the app target under **Frameworks, Libraries, and Embedded
Content** with the setting **Embed & Sign**. Then confirm the app target's
**Build Settings > Runpath Search Paths** (`LD_RUNPATH_SEARCH_PATHS`) contains:

```text
$(inherited)
@executable_path/Frameworks
```

This runpath is required for iOS to load the embedded `Stay22SDK.framework` at app
launch. Missing it can cause the app to fail before `main` with a dynamic library
loading error.

## Quick Start

Run SDK calls on the main actor. Initialize during app launch, before handling a cold
notification tap.

```swift
import Foundation
import Stay22SDK

@MainActor
func startStay22(userOptedIn: Bool) {
    Stay22.isEnabled = userOptedIn
    Stay22.initialize(aid: "your-partner-id")
}

@MainActor
func submitTrip() -> NotificationResult {
    // Illustrative app-chosen validity bounds, not SDK defaults.
    let now = Int64(Date().timeIntervalSince1970 * 1000)
    let request = NotificationRequest(
        trip: TravelContext(address: "Paris, France"),
        timing: .after(delayMs: 30 * 60 * 1000),
        expiresAtMs: now + 12 * 60 * 60 * 1000,
        actionExpiresAtMs: now + 24 * 60 * 60 * 1000
    )
    return Stay22.notifications.ensure(request)
}
```

Submit each trip once and keep the request to retry it; a submitted result can still be
rejected during preparation. The two expiry times are required unless your Stay22 account
sets a validity policy. Ask for notification permission when it fits your flow:

```swift
let granted = await Stay22.requestNotificationPermission()
```

To keep the SDK off until the user opts in, set `Stay22RequiresConsent` to `true` in
`Info.plist`, then set `Stay22.isEnabled = true` after consent. Otherwise the SDK
starts enabled.

## Info.plist

The SDK checks which booking apps are installed. iOS answers only for schemes your app
declares; an undeclared app is treated as unknown:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>airbnb</string>
    <string>booking</string>
    <string>expda</string>
    <string>hotelsapp</string>
    <string>agoda</string>
</array>
```

## Notification Taps

`initialize(aid:)` sets the SDK as `UNUserNotificationCenter.delegate` and forwards to
any delegate already there. If another push library assigns the delegate after it, or
your app owns the delegate, forward Stay22 notifications yourself:

```swift
// didReceive
if Stay22.handleNotificationResponse(response) { completionHandler(); return }

// willPresent: present only when the SDK still allows it
if Stay22.isStay22Notification(notification) {
    let show = Stay22.handleWillPresentNotification(notification)
    completionHandler(show ? [.banner, .sound, .list] : [])
    return
}
```

Without forwarding, a tap opens nothing.

## Verify

In an internal build, request a test notification that skips the normal delay and
cooldowns (consent and permission still apply):

```swift
Stay22.testing.showLogs = true
Stay22.testing.scheduleNotification(TravelContext(address: "Paris, France"))
```

Keep test calls and logging out of public builds.

Upgrading from 1.x: the breaking changes and what to call instead are in this
repository's [Releases](https://github.com/Stay22/stay22-ios-sdk/releases).

## License

This SDK is proprietary and closed source. © 2026 Stay22 Technologies Inc. All
Rights Reserved. Use is governed by the [LICENSE](LICENSE) and any separate written
agreement with Stay22. Contact your Stay22 representative for terms.

## Support

Full guide, privacy details and changelog: https://dev.stay22.com/docs/mobile-sdk.
Questions? Contact your Stay22 representative.
