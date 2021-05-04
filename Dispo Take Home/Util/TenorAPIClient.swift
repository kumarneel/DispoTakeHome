import Combine
import UIKit

struct TenorAPIClient {
    var gifInfo: (_ gifId: String) -> AnyPublisher<GifInfo, Never>
    var searchGIFs: (_ query: String) -> AnyPublisher<[SearchResult], Never>
    var featuredGIFs: () -> AnyPublisher<[SearchResult], Never>
}

// MARK: - Live Implementation
let decoder = JSONDecoder()

extension TenorAPIClient {
    static let live = TenorAPIClient(
        gifInfo: { gifId in
            let fakeUrl = URL(string: "https://stackoverflow.com/")
            
            let temp = GifInfo(dictionary: ["":""])
            // TODO: Implement
            var components = URLComponents(
                url: URL(string: "https://g.tenor.com/v1/gifs")!,
                resolvingAgainstBaseURL: false
            )!
            components.queryItems = [
                .init(name: "ids", value: gifId),
                .init(name: "key", value: Constants.tenorApiKey),
                .init(name: "media_filter", value: "basic")
            ]
            let url = components.url!
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: GifInfo.self, decoder: JSONDecoder())
                .replaceError(with: temp)
                .eraseToAnyPublisher()
        },
        searchGIFs: { query in
            var components = URLComponents(
                url: URL(string: "https://g.tenor.com/v1/search")!,
                resolvingAgainstBaseURL: false
            )!
            components.queryItems = [
                .init(name: "q", value: query),
                .init(name: "key", value: Constants.tenorApiKey),
                .init(name: "limit", value: "30")
            ]
            let url = components.url!
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .decode(type: APIListResponse.self, decoder: JSONDecoder())
                .map { response in
                    response.results.map {
                        SearchResult(
                            id: $0.id,
                            gifUrl: $0.media[0].gif.url,
                            text: $0.h1_title ?? "no title"
                        )
                    }
                }
                .replaceError(with: [])
                .share()
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        },
        featuredGIFs: {
            var components = URLComponents(
                url: URL(string: "https://g.tenor.com/v1/trending")!,
                resolvingAgainstBaseURL: false
            )!
            components.queryItems = [
                .init(name: "key", value: Constants.tenorApiKey),
                .init(name: "limit", value: "30"),
            ]
            let url = components.url!
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .decode(type: APIListResponse.self, decoder: JSONDecoder())
                .map { response in
                    
                    response.results.map {
                        SearchResult(
                            id: $0.id,
                            gifUrl: $0.media[0].gif.url,
                            text: $0.h1_title ?? "no title"
                        )
                    }
                }
                .replaceError(with: [])
                .share()
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    )
}

private struct APIListResponse: Codable {
    var results: [Result]
    
    struct Result: Codable {
        var id: String
        var h1_title: String?
        var media: [Media]
        
        struct Media: Codable {
            var gif: MediaData
            
            struct MediaData: Codable {
                var url: URL
            }
        }
    }
}
