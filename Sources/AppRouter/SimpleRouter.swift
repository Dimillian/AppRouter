import Foundation
import SwiftUI

/// A simple navigation router for single-stack navigation with sheet presentation.
/// Use this when you don't need tab-based navigation, just a single NavigationStack.
@Observable
@MainActor
public final class SimpleRouter<Destination: DestinationType, Sheet: SheetType> {

  // MARK: - Public Properties

  /// The navigation path for the router
  public var path: [Destination] = []

  /// The currently presented sheet, if any
  public var presentedSheet: Sheet?

  // MARK: - Initialization

  /// Creates a new simple router
  nonisolated public init() {}

  // MARK: - Navigation Methods

  /// Pops the navigation stack to the root
  public func popToRoot() {
    path = []
  }

  /// Pops the last destination from the navigation stack
  public func popNavigation() {
    if !path.isEmpty {
      path.removeLast()
    }
  }

  /// Navigates to the specified destination
  /// - Parameter destination: The destination to navigate to
  public func navigateTo(_ destination: Destination) {
    path.append(destination)
  }

  // MARK: - Sheet Methods

  /// Presents the specified sheet
  /// - Parameter sheet: The sheet to present
  public func presentSheet(_ sheet: Sheet) {
    presentedSheet = sheet
  }

  /// Dismisses the currently presented sheet
  public func dismissSheet() {
    presentedSheet = nil
  }

  // MARK: - URL Routing Methods

  /// Navigates to a URL by parsing its components and routing accordingly
  /// - Parameter url: The URL to navigate to
  /// - Returns: True if the URL was successfully routed, false otherwise
  @discardableResult
  public func navigate(to url: URL) -> Bool {
    return URLNavigationHelper.navigate(url: url) { destinations in
      path = destinations
    }
  }

  /// Navigates to a URL string by parsing its components and routing accordingly
  /// - Parameter urlString: The URL string to navigate to
  /// - Returns: True if the URL was successfully routed, false otherwise
  @discardableResult
  public func navigate(to urlString: String) -> Bool {
    guard let url = URL(string: urlString) else {
      return false
    }
    return navigate(to: url)
  }
}
