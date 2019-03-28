struct GitRS: Codable {
    let total_count: Int
    let incomplete_results: Bool
    
    let items : [UserGit]
}
