class Info: Codable {
    let data: [UserData]
}

class UserData: Codable {
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}
