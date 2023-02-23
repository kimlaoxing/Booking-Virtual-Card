import Foundation

final class ListPokemonMapper {
    static func listPokemonMapper(result: [ListPokemonResponse.Result]) -> [ListPokemonResult] {
        return result.map { data in
            return ListPokemonResult(
                name: data.name ?? ""
            )
        }
    }
}
