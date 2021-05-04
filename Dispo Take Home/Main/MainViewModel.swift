import Combine
import UIKit

func mainViewModel(
    cellTapped: AnyPublisher<SearchResult, Never>,
    searchText: AnyPublisher<String, Never>,
    viewWillAppear: AnyPublisher<Void, Never>
) -> (
    loadResults: AnyPublisher<[SearchResult], Never>,
    pushDetailView: AnyPublisher<SearchResult, Never>,
    loadFeaturedPosts: AnyPublisher<[SearchResult], Never>
) {
    let api = TenorAPIClient.live
            
    let searchResults = searchText
        .map { api.searchGIFs($0) }
        .switchToLatest()
    
    // featured gifs attempt below
    let featuredResults = api.featuredGIFs

    // show featured gifs when there is no search query, otherwise show search results
    let loadResults = searchResults
        .eraseToAnyPublisher()
    
    // load featured results
    let loadFeaturedResults = featuredResults()
        .eraseToAnyPublisher()
    
    // cell tapped
    let pushDetailView = cellTapped
        .eraseToAnyPublisher()
    

    return (
        loadResults: loadResults,
        pushDetailView: pushDetailView,
        loadFeaturedPosts: loadFeaturedResults
    )
}
