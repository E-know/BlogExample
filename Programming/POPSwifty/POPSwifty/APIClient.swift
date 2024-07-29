//
//  APIClient.swift
//  POPSwifty
//
//  Created by Inho Choi on 7/14/24.
//

import Foundation

enum MarvelError: Error{
	case decoding
}

protocol APIResponse {}

protocol APIRequest: Encodable {
	var resourceName: String { get }
}

protocol APIClient {
	func send(_ request: APIRequest,
			  completion: @escaping (APIResponse?, Error?) -> Void)
	
	func send(_ request: APIRequest) async throws-> APIResponse?
}

struct GetCharacters: APIRequest {
	typealias Response = [ComicCharacter]

	var resourceName: String {
		return "characters"
	}

	// Parameters
	let name: String?
	let nameStartsWith: String?
	let limit: Int?
	let offset: Int?

	init(name: String? = nil,
		 nameStartsWith: String? = nil,
		 limit: Int? = nil,
		 offset: Int? = nil) {
		self.name = name
		self.nameStartsWith = nameStartsWith
		self.limit = limit
		self.offset = offset
	}
}

struct ComicCharacter: Decodable {
	let id: Int
	let name: String?
	let description: String?
	let thumbnail: Image?
}

struct Image: Decodable {
	enum ImageKeys: String, CodingKey {
		case path = "path"
		case fileExtension = "extension"
	}

	let url: URL

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: ImageKeys.self)

		let path = try container.decode(String.self, forKey: .path)
		let fileExtension = try container.decode(String.self, forKey: .fileExtension)

		guard let url = URL(string: "\(path).\(fileExtension)") else { throw MarvelError.decoding }

		self.url = url
	}
}
