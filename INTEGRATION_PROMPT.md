# Stay22 iOS SDK - Integration Prompt

Use this prompt when integrating the Stay22 iOS SDK into an iOS app. The SDK is a
prebuilt `Stay22SDK.xcframework` distributed via Swift Package Manager (recommended)
or as a manually embedded XCFramework.

Provide the integrator with:

- the package URL `https://github.com/Stay22/stay22-ios-sdk` (or the
  `Stay22SDK.xcframework.zip` from a release, for manual integration)
- this prompt
- the Stay22 partner ID (`aid`)

## Prompt

````text
Integrate the Stay22 iOS SDK into this iOS app.

Context:
- Package: https://github.com/Stay22/stay22-ios-sdk (Swift Package Manager)
- Minimum iOS version: 15.0
- Partner ID: <AID>

Tasks:

1. Confirm this is an iOS app target.
   Look for an `.xcodeproj`, `.xcworkspace`, Swift files, or an iOS app target.

2. Add the SDK. Prefer Swift Package Manager.

   Swift Package Manager (recommended):
   - In Xcode: File > Add Package Dependencies, enter
     `https://github.com/Stay22/stay22-ios-sdk`, and use the "Up to Next Major
     Version" rule starting at the latest release.
   - Or in Package.swift:

     ```swift
     dependencies: [
         .package(url: "https://github.com/Stay22/stay22-ios-sdk.git", from: "<VERSION>")
     ]
     ```

     Then add the `Stay22SDK` product to the app target.

   Manual (XCFramework), only if not using SPM:
   - Download `Stay22SDK.xcframework.zip` from the repository's Releases, unzip it,
     and add `Stay22SDK.xcframework` to the app target under Frameworks, Libraries,
     and Embedded Content with the setting Embed & Sign.
   - Ensure the app target's Build Settings > Runpath Search Paths
     (`LD_RUNPATH_SEARCH_PATHS`) includes these values for every build
     configuration:

     ```text
     $(inherited)
     @executable_path/Frameworks
     ```

     This is required so iOS can load the embedded `Stay22SDK.framework` at app
     launch.

   - Ensure the app deployment target is iOS 15.0 or newer.

3. Add the required `Info.plist` keys.
   Add the following so the SDK can function correctly:

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

   If this key already exists in `Info.plist`, merge the values into the
   existing array.

4. Initialize the SDK once, early in app launch.

   ```swift
   import Stay22SDK

   Stay22.isEnabled = userHasOptedInToStay22Offers
   Stay22.initialize(aid: "<AID>")
   ```

5. Add consent and notification permission handling.
   Treat Stay22 notifications as promotional. Do not make them required for the app
   to function.

   When enabling Stay22:
   - consider surfacing opt-in language before enabling Stay22;
   - store the user's choice;
   - provide an in-app opt-out control.

   Wire opt-in and opt-out to:

   ```swift
   Stay22.isEnabled = userHasOptedInToStay22Offers
   ```

   When the user opts in, request local notification permission at an appropriate moment:

   ```swift
   Task {
       let granted = await Stay22.requestNotificationPermission()
   }
   ```

   To check permission without prompting:

   ```swift
   let canNotify = await Stay22.hasNotificationPermission()
   ```

6. Capture explicit travel intent.
   Search the app for screens, view models, routes, and analytics events where the app
   knows a destination, city, venue, hotel/accommodation search term, coordinates,
   booking, itinerary, event, search result, map place, or travel date.

   Add `Stay22.setTravelContext(...)` where the app first has reliable intent:

   ```swift
   Stay22.setTravelContext(
       TravelContext(
           address: "Paris, France",
           checkinDate: "2026-03-20",
           checkoutDate: "2026-03-25"
       )
   )
   ```

   Address-only and coordinates-only are also valid:

   ```swift
   Stay22.setTravelContext(TravelContext(address: "Paris, France"))
   Stay22.setTravelContext(TravelContext(latitude: 48.8566, longitude: 2.3522))
   ```

   Use `hotelName` when the app has hotel or accommodation search text. It does not
   need to be an exact canonical hotel match:

   ```swift
   Stay22.setTravelContext(
       TravelContext(address: "Paris, France", hotelName: "Hotel Example")
   )
   ```

   Date format: `YYYY-MM-DD`.

   Important:
   - Notifications are scheduled from explicit travel intent only: address, coordinates,
     or hotel/accommodation search text.
   - `setTravelContext` merges non-empty fields, so destination and dates can be
     provided across multiple screens.
   - Call `Stay22.clearTravelContext()` when a travel/search flow resets, the user
     signs out, or consent is revoked.

7. Optional: customize notification copy.
   Most integrations can use the default notification copy. If custom copy is needed:

   ```swift
   Stay22.notificationConfig = NotificationConfig(
       title: "Hotels in {destination}",
       message: "Find stays for {checkin}-{checkout}."
   )
   ```

   Supported placeholders: `{destination}`, `{checkin}`, `{checkout}`.

8. Optional: add attribution.

   ```swift
   Stay22.campaignId = "ios-pilot-2026" // optional
   ```

9. Optional: observe SDK events for QA.

   ```swift
   Stay22.advanced.setEventHandler { event in
       switch event {
       case .notificationScheduled(let destination, let delay):
           print("Stay22 scheduled: \(destination), delay=\(delay)s")
       case .notificationClicked(let destination, let url):
           print("Stay22 clicked: \(destination), \(url)")
       default:
           break
       }
   }
   ```

10. Prefer automatic scheduling.
   Automatic scheduling normally runs when fresh travel context exists and the app
   backgrounds. Use this default behavior whenever possible.

   Only use `Stay22.advanced.scheduleNotification()` for special app flows where
   background-based scheduling does not fit, and call it only after confirming the
   timing need with Stay22.

11. Development testing only:

   ```swift
   Stay22.testing.force = true
   Stay22.testing.showLogs = true
   ```

   Force mode uses a short local notification delay for repeatable QA. Never ship
   production builds with force mode enabled.

Public API to use:
- `Stay22.initialize(aid:)`
- `Stay22.isEnabled`
- `Stay22.requestNotificationPermission()`
- `Stay22.hasNotificationPermission()`
- `Stay22.setTravelContext(_:)`
- `Stay22.clearTravelContext()`
- `Stay22.notificationConfig`
- `Stay22.campaignId`
- `Stay22.advanced.setEventHandler(_:)`
- `Stay22.advanced.scheduleNotification()` only for special scheduling flows after discussing with Stay22
- `Stay22.testing.force`
- `Stay22.testing.showLogs`
- `TravelContext(address:latitude:longitude:checkinDate:checkoutDate:hotelName:)`
- `NotificationConfig(title:message:)`

Use only the APIs listed above. Do not use unsupported names such as
`setLocation`, `setKeywords`, `Stay22.force`, `Stay22.showLogs`, or
`scheduleNotification(delay:)`.
````
