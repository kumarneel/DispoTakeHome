import Combine
import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private let searchGifInfo = PassthroughSubject<String, Never>()

    let gifImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let gifTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "title"
        return lbl
    }()
    
    let sharedLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "20 shares"
        return lbl
    }()
    
    let tagsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Tags: funny, weird"
        return lbl
    }()
    
    init(searchResult: SearchResult) {
        super.init(nibName: nil, bundle: nil)
        // load gif with king fisher
        gifImageView.getImageByURLUsingKingFisher(url: searchResult.gifUrl)
        searchGifInfo.send(searchResult.id)
        // last part of assignment I could not complete because of my TenorAPIClient GifInfo request
        let loadGif = detailViewModel(loadGifInfo: searchGifInfo.eraseToAnyPublisher())
        loadGif
            .sink { (returnedGif) in
                print(returnedGif)
                self.gifTitleLbl.text = returnedGif.title
                self.sharedLbl.text = "\(returnedGif.shares) shares"
                self.tagsLbl.text = "Tags \(returnedGif.tags)"
            }
    }
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(gifImageView)
        
        gifImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(100)
            make.centerX.equalTo(view)
            make.width.equalTo(view.frame.width * 0.80)
            make.height.equalTo(view.frame.width * 0.80)
        }
        
        view.addSubview(gifTitleLbl)
        
        gifTitleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(gifImageView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        view.addSubview(sharedLbl)
        
        sharedLbl.snp.makeConstraints { (make) in
            make.top.equalTo(gifTitleLbl.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        view.addSubview(tagsLbl)
        
        tagsLbl.snp.makeConstraints { (make) in
            make.top.equalTo(sharedLbl.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        // set up labels with GifInfo data...
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
