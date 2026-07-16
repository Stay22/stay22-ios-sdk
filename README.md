# Stay22 iOS SDK

Native iOS SDK that turns travel intent in your app into timely, revenue-generating
accommodation offers. When your app captures a destination, dates, or hotel/accommodation
search text, the SDK schedules a single, well-timed local notification that opens a
curated Stay22 booking experience.

- No third-party dependencies · iOS 15+ · Swift 5.9+
- Ships an Apple privacy manifest
- You control enablement, notification permission, and user consent

## Installation

The SDK is distributed as a prebuilt binary `Stay22SDK.xcframework`. Use Swift Package
Manager (recommended) or embed the framework manually.

### Swift Package Manager (recommended)

In Xcode, choose **File > Add Package Dependencies…**, enter the repository URL, and
select the **Up to Next Major Version** rule starting at `1.0.11`:

```text
https://github.com/Stay22/stay22-ios-sdk
```

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Stay22/stay22-ios-sdk.git", from: "1.0.11")
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

```swift
import Stay22SDK

// Set before initialize if you gate Stay22 behind consent.
Stay22.isEnabled = userHasOptedInToStay22Offers

Stay22.initialize(aid: "your-partner-id")

Task {
    await Stay22.requestNotificationPermission()
}

Stay22.setTravelContext(
    TravelContext(address: "Paris, France")
)
```

Call `initialize(aid:)` once, as early as possible in app launch.

## Consent And Permission

Recommended practices when enabling Stay22:

- consider surfacing opt-in language before enabling Stay22;
- do not require Stay22 or notification permission for core app functionality;
- provide an in-app opt-out control;
- update your privacy disclosures as needed.

```swift
Stay22.isEnabled = userHasOptedInToStay22Offers
```

When set to `false`, the SDK stops scheduling and clears pending Stay22
notifications. The value is persisted and can be set before initialization.

Request local notification permission when it fits your UX:

```swift
let granted = await Stay22.requestNotificationPermission()
```

Check status without prompting:

```swift
let canNotify = await Stay22.hasNotificationPermission()
```

## Travel Context

Pass explicit travel intent when the app knows a destination, coordinates, dates,
or hotel/accommodation search text.

```swift
Stay22.setTravelContext(
    TravelContext(
        address: "Tokyo, Japan",
        latitude: 35.6762,
        longitude: 139.6503,
        checkinDate: "2026-04-10",
        checkoutDate: "2026-04-15"
    )
)
```

Address-only and coordinate-only contexts are valid:

```swift
Stay22.setTravelContext(TravelContext(address: "Barcelona, Spain"))
Stay22.setTravelContext(TravelContext(latitude: 41.3851, longitude: 2.1734))
```

Use `hotelName` when the app has hotel or accommodation search text. It does not
need to be an exact canonical hotel match:

```swift
Stay22.setTravelContext(
    TravelContext(address: "Paris, France", hotelName: "Hotel Example")
)
```

Notes:

- Dates use `YYYY-MM-DD`.
- `setTravelContext` merges non-empty fields, so destination and dates can arrive
  on different screens.
- Scheduling only uses explicit travel intent: address, coordinates, or hotel
  search text.
- Call `Stay22.clearTravelContext()` when a search/trip flow resets, the user signs
  out, or consent is revoked.

## Notification Appearance

```swift
Stay22.notificationConfig = NotificationConfig(
    title: "Hotels in {destination}",
    subtitle: "{checkin}-{checkout}",
    message: "Find stays near {destination}.",
    categoryId: "stay22_destinations",
    threadId: "stay22",
    badge: 1,
    launchImageName: "Stay22Launch",
    targetContentIdentifier: "stay22-trip",
    interruptionLevel: .active,
    relevanceScore: 0.8,
    attachments: [
        NotificationAttachment(fileURL: localImageFileURL)
    ],
    actions: [
        NotificationAction(identifier: "open_stays", title: "View stays")
    ]
)
```

Supported placeholders in text fields: `{destination}`, `{checkin}`, `{checkout}`.
Attachments must use local file URLs. iOS controls the compact notification layout;
custom expanded layouts require a host-app Notification Content Extension.

## Required Info.plist Keys

Add the following keys to the host app's `Info.plist` for the SDK to function correctly:

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

## Scheduling

Automatic scheduling runs when fresh travel context exists and the app backgrounds.
The delay, cooldown, frequency, distance gates, and remote disable switch come from
Stay22 partner config and Nova decisions.

If the host app needs to choose the scheduling moment:

```swift
Stay22.advanced.scheduleNotification()
```

The SDK keeps at most one pending Stay22 notification. A changed travel context
replaces the pending notification; the same context keeps the existing timer.

## Events

```swift
Stay22.advanced.setEventHandler { event in
    switch event {
    case .locationUpdated(let destination):
        print("Stay22 context: \(destination)")
    case .notificationScheduled(let destination, let delay):
        print("Stay22 scheduled: \(destination), delay=\(delay)s")
    case .notificationClicked(let destination, let url):
        print("Stay22 clicked: \(destination), \(url)")
    case .notificationSkipped(let reason),
         .notificationBlocked(let reason),
         .notificationCancelled(let reason):
        print("Stay22 stopped: \(reason)")
    default:
        break
    }
}
```

Locally emitted skip reasons include `sdk_disabled`, `missing_destination`,
`app_foreground`, `home_destination`, `partner_config_disabled`, `local_cooldown`,
`duplicate_pending_notification`, and `notification_permission_denied`. The Nova
decision endpoint can also return server-provided reasons (for example
`distance_below_threshold` or `frequency_capped`).

## Testing

For local QA only:

```swift
Stay22.testing.force = true
Stay22.testing.showLogs = true
Stay22.setTravelContext(TravelContext(address: "Paris, France"))
```

Force mode uses a 5-second notification delay and skips local gates so the same
flow can be tested repeatedly. Do not ship production builds with force mode on.

## Privacy

The SDK does not request device GPS permission and is not used for cross-app
tracking. It may send the partner ID, explicit destination context, and anonymous
SDK interaction events to Stay22. The host app is responsible for consent, privacy
policy disclosures, and app-store privacy answers.

## API Summary

| API | Purpose |
|---|---|
| `Stay22.initialize(aid:)` | Start the SDK. |
| `Stay22.isEnabled` | Enable/disable scheduling; persisted, settable before init. |
| `Stay22.requestNotificationPermission()` | Prompt for local notification permission. |
| `Stay22.hasNotificationPermission()` | Check notification permission. |
| `Stay22.setTravelContext(_:)` | Provide destination, coordinates, dates, or hotel search text. |
| `Stay22.clearTravelContext()` | Clear context and pending Stay22 notification. |
| `Stay22.notificationConfig` | Customize notification copy, grouping, badge, attachments, and actions. |
| `Stay22.campaignId` | Optional URL attribution. |
| `Stay22.advanced.setEventHandler(_:)` | Observe SDK events. |
| `Stay22.advanced.scheduleNotification()` | Manually run scheduling. |
| `Stay22.testing.force/showLogs` | QA overrides. |

## License

This SDK is proprietary and closed source. © 2026 Stay22 Technologies Inc. All
Rights Reserved. Use is governed by the [LICENSE](LICENSE) and any separate written
agreement with Stay22. Contact your Stay22 representative for terms.

## Support

Questions? Contact your Stay22 representative or visit
[stay22.com](https://www.stay22.com).
