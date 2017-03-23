# MVVMSample

It's so common for iOS projects to cram way too much code into the View Controllers that MVC has become known to mean Massive View Controller. While many remedies to this situation can be found elsewhere, some with a fairly large footprint, the aim of this project is to illustrate how View Models can be used as a low-impact first step towards moving code out of the View Controller and into a much more testable space. Dependency injection is used to handle some more complex situations while still maintaining testability.


Some basic principles:
- All public View Model properties and methods should be easily testable. For example, an image URL can easily be tested by checking its absoluteString, whereas a UIImage would be difficult to test. In general, it's usually best to avoid having to import UIKit into a view model.
- The View Model "owns" the data model, and thus does not allow direct access to the data model.
- The View Model "serves" the view controller, meaning that it does what it can to make things easy for the view controller.
- If data needs to be passed into a view controller from another, then the `viewModel` property should be defined as a forced unwrapped optional and be set by the presenting code.**
- If data does not need to be passed into a view controller from another, then the view model should be instantiated w/in that view controller.**

** Not a hard-and-fast rule. The important thing is to be consistent.
