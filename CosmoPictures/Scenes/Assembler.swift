
import UIKit

final class Assembler {
    
    // MARK: - Public Methods

    public func build() -> UIViewController {
        let presenter = PresenterImpl()
        let viewController = MainViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
