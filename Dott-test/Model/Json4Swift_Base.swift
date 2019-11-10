
import Foundation
struct Json4Swift_Base : Codable {
	let venues : Response?
	let confident : Bool?

	enum CodingKeys: String, CodingKey {

		case venues = "venues"
		case confident = "confident"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		venues = try values.decodeIfPresent(Response.self, forKey: .venues)
		confident = try values.decodeIfPresent(Bool.self, forKey: .confident)
	}

}
