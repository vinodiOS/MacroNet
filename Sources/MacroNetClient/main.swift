import MacroNet
import RequestBuilder
import Combine


struct Post: Codable {}

@Service
protocol User {
    func getPosts() async throws -> [Post]
}
