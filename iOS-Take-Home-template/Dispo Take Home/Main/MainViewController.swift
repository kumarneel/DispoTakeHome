import Combine
import UIKit
import Kingfisher

class MainViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    private let searchTextChangedSubject = PassthroughSubject<String, Never>()
    
    var gifsArray = [SearchResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        collectionView.dataSource = self
        collectionView.delegate = self
        let (
            loadResults,
            pushDetailView
        ) = mainViewModel(
            cellTapped: Empty().eraseToAnyPublisher(), // to compile but not function, you can replace with Empty().eraseToAnyPublisher()
            searchText: searchTextChangedSubject.eraseToAnyPublisher(),
            viewWillAppear: Empty().eraseToAnyPublisher() // to compile but not function, you can replace with Empty().eraseToAnyPublisher()
        )
        
        loadResults
            .sink { [weak self] results in
                // load search results into data source
                self!.gifsArray = results
                self!.collectionView.reloadData()
            }
            .store(in: &cancellables)
        
        pushDetailView
            .sink { [weak self] result in
                // push detail view
                print(result)
            }
            .store(in: &cancellables)
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search gifs..."
        searchBar.delegate = self
        return searchBar
    }()
    
    private var layout: UICollectionViewLayout {
        // TODO: implement
        let layout = UICollectionViewFlowLayout()
        return layout
        
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(GifCell.self, forCellWithReuseIdentifier: "GifCellId")
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    
}

// MARK: UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension MainViewController: UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let searchResult = gifsArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCellId", for: indexPath) as! GifCell
        cell.imageView.getImageByURLUsingKingFisher(url: searchResult.gifUrl)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 70)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextChangedSubject.send(searchText)
    }
}


// MARK: King Fisher
extension UIImageView {
    func getImageByURLUsingKingFisher(url: URL){
        self.kf.indicatorType = .none
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .forceTransition,
                .cacheOriginalImage
            ], completionHandler:
                {
                    result in
                    switch result {
                    case .success(_):
                        return
                    case .failure(_):
                        return
                    }
                })
    }
}
