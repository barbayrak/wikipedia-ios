import UIKit

@objc(WMFReadingListHintPresenter)
public protocol ReadingListHintPresenter: class {
//    @objc var readingListHintController: ReadingListHintController? { get }
}

@objc(WMFReadingListHintController)
class ReadingListHintController: HintController {

    private let readingListHintViewController = ReadingListHintViewController(nibName: "HintViewController", bundle: Bundle.main)
    private let dataStore: MWKDataStore
    private var containerView = UIView()
        
    @objc init(dataStore: MWKDataStore) {
        self.dataStore = dataStore
        readingListHintViewController.dataStore = dataStore
        super.init(hintViewController: readingListHintViewController)
    }

    @objc func toggleHintForArticle(_ article: WMFArticle, theme: Theme) {
        let didSave = article.savedDate != nil

        let didSaveOtherArticle = didSave && !isHintHidden && article != readingListHintViewController.article
        let didUnsaveOtherArticle = !didSave && !isHintHidden && article != readingListHintViewController.article

        guard !didUnsaveOtherArticle else {
            return
        }

        self.theme = theme

        guard !didSaveOtherArticle else {
            resetHint()
            dismissHint()
            readingListHintViewController.article = article
            return
        }

        readingListHintViewController.article = article
        setHintHidden(!didSave)
    }
    
//    @objc func scrollViewWillBeginDragging() {
////        guard !isHintHidden else {
////            return
////        }
////        hintVisibilityTime = 0
//    }
}
