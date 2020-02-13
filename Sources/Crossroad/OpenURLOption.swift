#if os(iOS)

import Foundation
import UIKit

public typealias ApplicationOpenURLOptions = [UIApplication.OpenURLOptionsKey: Any]

// https://developer.apple.com/documentation/uikit/uiapplicationopenurloptionskey
public struct OpenURLOption {
    public let sourceApplication: String?
    public let annotation: [String: Any]?
    public let openInPlace: Bool

    public init(options: ApplicationOpenURLOptions) {
        self.sourceApplication = options[.sourceApplication] as? String
        self.annotation = options[.annotation] as? [String: Any]
        self.openInPlace = options[.openInPlace] as? Bool ?? false
    }

    @available(iOS 13.0, *)
    public init(options: UIScene.OpenURLOptions) {
        self.sourceApplication = options.sourceApplication
        self.annotation = options.annotation as? [String: Any]
        self.openInPlace = options.openInPlace
    }
}

public typealias DefaultRouter = Router<OpenURLOption>

public extension Router where UserInfo == OpenURLOption {
    func openIfPossible(_ url: URL, options: ApplicationOpenURLOptions) -> Bool {
        return openIfPossible(url, userInfo: OpenURLOption(options: options))
    }

    func responds(to url: URL, options: ApplicationOpenURLOptions) -> Bool {
        return responds(to: url, userInfo: OpenURLOption(options: options))
    }
}

#endif
