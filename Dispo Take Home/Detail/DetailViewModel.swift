import Combine
import UIKit

func detailViewModel(
    loadGifInfo: AnyPublisher<String, Never>
) -> (
    AnyPublisher<GifInfo, Never>
) {
    let api = TenorAPIClient.live
    
    let gif = loadGifInfo
        .map { api.gifInfo($0) }
        .switchToLatest()
    
    return (gif.eraseToAnyPublisher())
}
