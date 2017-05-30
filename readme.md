### Requirements

 * Xcode 8.3 or above

### Building

 * Open the `Weather.xcworkspace` file in the root directory of this project
 * Select `Product > Run` from the menu to build and run
 * Select `Product > Test` from the menu to run the unit tests (not much point at the moment)

### Todo

 * Improve efficiency of UITableView forecast data access
 * Remove implicitly unwrapped optionals where possible
 * Add error handling, e.g. if the OWM API is unavailable
 * Fix bug where UITableView is populated incorrectly when there are no more future weather windows for the current day
 * Finish implementing unit tests
 * Add UI tests
 * Add support for multiple locations
 * Suggest clothing to wear for the day

### Notes
 * SwiftyJSON, Alamofire, Nimble, Quick and Mockingjay CocoaPods have been checked in to make the project easier to build
