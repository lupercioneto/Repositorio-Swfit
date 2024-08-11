import Foundation

class Pokemon {

    let DexNumber: String // Número da National Dex
    let Name: String // Nome do Pokémon

    // Base Stats
    var HP: Int 
    var ATK: Int
    var DEF: Int
    var SpATK: Int
    var SpDEF: Int
    var SPD: Int 

    // Tipo do Pokemon
    var Type1: String
    var Type2: String?
    
    // Inicializando atributos
    init(DexNumber: String, Name: String, HP: Int, ATK: Int, DEF: Int, SpATK: Int, SpDEF: Int, SPD: Int, Type1: String, Type2: String? = nil) {
        self.DexNumber = DexNumber
        self.Name = Name
        self.HP = HP
        self.ATK = ATK
        self.DEF = DEF
        self.SpATK = SpATK
        self.SpDEF = SpDEF
        self.SPD = SPD 
        self.Type1 = Type1
        self.Type2 = Type2
    }

    // Função para realizar a soma do total de base stats
    func SumBStats() -> Int {
        let Total = HP + ATK + DEF + SpATK + SpDEF + SPD 
        return Total
    }
    
    // Função para retornar o tipo do pokemon
    func getTypes() -> String {
        if let type2 = Type2 {
            return "\(Type1)/\(type2)"
        } else {
            return Type1
        }
    }

    // Função que retorna todos os dados de um Pokémon
    func getInfos() -> String {
        return """

        Nome: \(Name)
        Número da Dex: #\(DexNumber)
        Tipos: \(getTypes())
        Stats Base:
        - HP: \(HP)
        - ATK: \(ATK)
        - DEF: \(DEF)
        - SpATK: \(SpATK)
        - SpDEF: \(SpDEF)
        - SPD: \(SPD)
        - Total: \(SumBStats())
        """
    }
}

// Método para adicionar um pokemon com seus respectivos status base
func AddPkmn(DexNumber: String, Name: String, HP: Int, ATK: Int, DEF: Int, SpATK: Int, SpDEF: Int, SPD: Int, Type1: String, Type2: String? = nil) -> Pokemon {
    return Pokemon(DexNumber: DexNumber, Name: Name, HP: HP, ATK: ATK, DEF: DEF, SpATK: SpATK, SpDEF: SpDEF, SPD: SPD, Type1: Type1, Type2: Type2)
}

// Função para procurar um Pokémon por seu nome 
func SrchPkmnByName(PkmnName: String) -> Pokemon? {
    for pokemon in DexGen1 {
        if pokemon.Name.lowercased() == PkmnName.lowercased() {
            return pokemon
        }
    }
    return nil
}

// Função para buscar Pokémon por seu número
func SrchPkmnByNumber(DexNumber: String) -> Pokemon? {
    for pokemon in DexGen1 {
        if pokemon.DexNumber == DexNumber {
            return pokemon
        }
    }
    return nil
}

// Função para desempacotanr as propriedades de cada pokémon individualmente e adicionando-os na lista DexGen1
func fillDex(with data: [[String: Any]]) {
    for pkmnData in data {
        if let DexNumber = pkmnData["DexNumber"] as? String,
           let Name = pkmnData["Name"] as? String,
           let HP = pkmnData["HP"] as? Int,
           let ATK = pkmnData["ATK"] as? Int,
           let DEF = pkmnData["DEF"] as? Int,
           let SpATK = pkmnData["SpATK"] as? Int,
           let SpDEF = pkmnData["SpDEF"] as? Int,
           let SPD = pkmnData["SPD"] as? Int,
           let Type1 = pkmnData["Type1"] as? String {
            let Type2 = pkmnData["Type2"] as? String
            let pkmn = AddPkmn(DexNumber: DexNumber, Name: Name, HP: HP, ATK: ATK, DEF: DEF, SpATK: SpATK, SpDEF: SpDEF, SPD: SPD, Type1: Type1, Type2: Type2)
            DexGen1.append(pkmn)
        }
    }
}

func MainHub() {
    fillDex(with: PokeData)
    while true {
        print("""
        Olá! Seja bem-vindo a Pokédex! Que operação deseja realizar?
        1 - Pesquisar Pokémon (via nome)
        2 - Pesquisar Pokémon (via número)
        3 - Sair da Pokédex
        """)
        print("Digite sua opção: ", terminator: "")
        
        if let input = readLine(), let option = Int(input) {
            switch option {
            case 1:
                print("Digite o nome do Pokémon que gostaria de ver: ", terminator: "")
                if let inp = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
                    if let foundPkmn = SrchPkmnByName(PkmnName: inp) {
                        print(foundPkmn.getInfos())
                        sleep(3)
                        print()
                    } else {
                        print("Pokémon não encontrado. Por favor, tente novamente.\n")
                        sleep(2)
                    }
                }
                
            case 2:
                print("Digite o número do Pokémon que gostaria de ver: ", terminator: "")
                if let inp = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
                    if let foundPkmn = SrchPkmnByNumber(DexNumber: inp) {
                        print(foundPkmn.getInfos())
                        sleep(3)
                        print()
                    } else {
                        print("Pokémon não encontrado. Por favor, tente novamente.\n")
                        sleep(2)
                    }
                }
                
            case 3:
                print("Finalizando operações... Até a próxima!")
                sleep(2)
                return
                
            default:
                print("Valor inválido. Por favor, tente novamente.")
                sleep(2) 
            }
        } else {
            print("ERRO! Por favor, digite apenas opções disponíveis no nosso menu de operações.")
        }
    }
}

// Lista onde serão armazenadas todos os objetos "Pokemon"
var DexGen1: [Pokemon] = []

// Lista de dicionários onde deve ser preenchida com o pokemon que deseja adicionar
// Os atributos devem ser preenchidos na ordem: DexNumber - Name - HP - ATK - DEF - SpATK - SpDEF - SPD - Type1 - Type2
let PokeData: [[String: Any]] = [
    ["DexNumber": "0001", "Name": "Bulbasaur", "HP": 45, "ATK": 49, "DEF": 49, "SpATK": 65, "SpDEF": 65, "SPD": 45, "Type1": "Grass", "Type2": "Poison"],
    ["DexNumber": "0002", "Name": "Ivysaur", "HP": 60, "ATK": 62, "DEF": 63, "SpATK": 80, "SpDEF": 80, "SPD": 60, "Type1": "Grass", "Type2": "Poison"],
    ["DexNumber": "0003", "Name": "Venusaur", "HP": 80, "ATK": 82, "DEF": 83, "SpATK": 100, "SpDEF": 100, "SPD": 80, "Type1": "Grass", "Type2": "Poison"],
    ["DexNumber": "0004", "Name": "Charmander", "HP": 39, "ATK": 52, "DEF": 43, "SpATK": 60, "SpDEF": 50, "SPD": 65, "Type1": "Fire"],
    ["DexNumber": "0005", "Name": "Charmeleon", "HP": 58, "ATK": 64, "DEF": 58, "SpATK": 80, "SpDEF": 65, "SPD": 80, "Type1": "Fire"],
    ["DexNumber": "0006", "Name": "Charizard", "HP": 78, "ATK": 84, "DEF": 78, "SpATK": 109, "SpDEF": 85, "SPD": 100, "Type1": "Fire", "Type2": "Flying"],
    ["DexNumber": "0007", "Name": "Squirtle", "HP": 44, "ATK": 48, "DEF": 65, "SpATK": 50, "SpDEF": 64, "SPD": 43, "Type1": "Water"],
    ["DexNumber": "0008", "Name": "Wartortle", "HP": 59, "ATK": 63, "DEF": 80, "SpATK": 65, "SpDEF": 80, "SPD": 58, "Type1": "Water"],
    ["DexNumber": "0009", "Name": "Blastoise", "HP": 79, "ATK": 83, "DEF": 100, "SpATK": 85, "SpDEF": 105, "SPD": 78, "Type1": "Water"],
    ["DexNumber": "0010", "Name": "Caterpie", "HP": 45, "ATK": 30, "DEF": 35, "SpATK": 20, "SpDEF": 20, "SPD": 45, "Type1": "Bug"],
    ["DexNumber": "0011", "Name": "Metapod", "HP": 50, "ATK": 20, "DEF": 55, "SpATK": 25, "SpDEF": 25, "SPD": 30, "Type1": "Bug"],
    ["DexNumber": "0012", "Name": "Butterfree", "HP": 60, "ATK": 45, "DEF": 50, "SpATK": 90, "SpDEF": 80, "SPD": 70, "Type1": "Bug", "Type2": "Flying"],
    ["DexNumber": "0013", "Name": "Weedle", "HP": 40, "ATK": 35, "DEF": 30, "SpATK": 20, "SpDEF": 20, "SPD": 50, "Type1": "Bug", "Type2": "Poison"],
    ["DexNumber": "0014", "Name": "Kakuna", "HP": 45, "ATK": 25, "DEF": 50, "SpATK": 25, "SpDEF": 25, "SPD": 35, "Type1": "Bug", "Type2": "Poison"],
    ["DexNumber": "0015", "Name": "Beedrill", "HP": 65, "ATK": 90, "DEF": 40, "SpATK": 45, "SpDEF": 80, "SPD": 75, "Type1": "Bug", "Type2": "Poison"],
    ["DexNumber": "0016", "Name": "Pidgey", "HP": 40, "ATK": 45, "DEF": 40, "SpATK": 35, "SpDEF": 35, "SPD": 56, "Type1": "Normal", "Type2": "Flying"],
    ["DexNumber": "0017", "Name": "Pidgeotto", "HP": 63, "ATK": 60, "DEF": 55, "SpATK": 50, "SpDEF": 50, "SPD": 71, "Type1": "Normal", "Type2": "Flying"],
    ["DexNumber": "0018", "Name": "Pidgeot", "HP": 83, "ATK": 80, "DEF": 75, "SpATK": 70, "SpDEF": 70, "SPD": 101, "Type1": "Normal", "Type2": "Flying"],
    ["DexNumber": "0019", "Name": "Rattata", "HP": 30, "ATK": 56, "DEF": 35, "SpATK": 25, "SpDEF": 35, "SPD": 72, "Type1": "Normal"],
    ["DexNumber": "0020", "Name": "Raticate", "HP": 55, "ATK": 81, "DEF": 60, "SpATK": 50, "SpDEF": 70, "SPD": 97, "Type1": "Normal"],
    ["DexNumber": "0021", "Name": "Spearow", "HP": 40, "ATK": 60, "DEF": 30, "SpATK": 31, "SpDEF": 31, "SPD": 70, "Type1": "Normal", "Type2": "Flying"],
    ["DexNumber": "0022", "Name": "Fearow", "HP": 65, "ATK": 90, "DEF": 65, "SpATK": 61, "SpDEF": 61, "SPD": 100, "Type1": "Poison"],
    ["DexNumber": "0023", "Name": "Ekans", "HP": 35, "ATK": 60, "DEF": 44, "SpATK": 40, "SpDEF": 54, "SPD": 55, "Type1": "Poison"],
    ["DexNumber": "0024", "Name": "Arbok", "HP": 60, "ATK": 95, "DEF": 69, "SpATK": 65, "SpDEF": 79, "SPD": 80, "Type1": "Poison"],
    ["DexNumber": "0025", "Name": "Pikachu", "HP": 35, "ATK": 55, "DEF": 40, "SpATK": 50, "SpDEF": 50, "SPD": 90, "Type1": "Electric"],
    ["DexNumber": "0026", "Name": "Raichu", "HP": 60, "ATK": 90, "DEF": 55, "SpATK": 90, "SpDEF": 80, "SPD": 110, "Type1": "Electric"],
    ["DexNumber": "0027", "Name": "Sandshrew", "HP": 50, "ATK": 75, "DEF": 85, "SpATK": 20, "SpDEF": 30, "SPD": 40, "Type1": "Ground"],
    ["DexNumber": "0028", "Name": "Sandslash", "HP": 75, "ATK": 100, "DEF": 110, "SpATK": 45, "SpDEF": 55, "SPD": 65, "Type1": "Ground"],
    ["DexNumber": "0029", "Name": "Nidoran♀ ", "HP": 55, "ATK": 47, "DEF": 52, "SpATK": 40, "SpDEF": 40, "SPD": 41, "Type1": "Poison"],
    ["DexNumber": "0030", "Name": "Nidorina", "HP": 70, "ATK": 62, "DEF": 67, "SpATK": 55, "SpDEF": 55, "SPD": 56, "Type1": "Poison"],
    ["DexNumber": "0031", "Name": "Nidoqueen", "HP": 90, "ATK": 92, "DEF": 87, "SpATK": 75, "SpDEF": 85, "SPD": 76, "Type1": "Poison", "Type2": "Ground"],
    ["DexNumber": "0032", "Name": "Nidoran♂ ", "HP": 46, "ATK": 57, "DEF": 40, "SpATK": 40, "SpDEF": 40, "SPD": 50, "Type1": "Poison"],
    ["DexNumber": "0033", "Name": "Nidorino", "HP": 61, "ATK": 72, "DEF": 57, "SpATK": 55, "SpDEF": 55, "SPD": 65, "Type1": "Poison"],
    ["DexNumber": "0034", "Name": "Nidoking", "HP": 81, "ATK": 102, "DEF": 77, "SpATK": 85, "SpDEF": 75, "SPD": 85, "Type1": "Poison", "Type2": "Ground"],
    ["DexNumber": "0035", "Name": "Clefairy", "HP": 70, "ATK": 45, "DEF": 48, "SpATK": 60, "SpDEF": 65, "SPD": 35, "Type1": "Fairy"],
    ["DexNumber": "0036", "Name": "Clefable", "HP": 95, "ATK": 70, "DEF": 73, "SpATK": 95, "SpDEF": 90, "SPD": 60, "Type1": "Fairy"],
    ["DexNumber": "0037", "Name": "Vulpix", "HP": 38, "ATK": 41, "DEF": 40, "SpATK": 50, "SpDEF": 65, "SPD": 65, "Type1": "Fire"],
    ["DexNumber": "0038", "Name": "Ninetales", "HP": 73, "ATK": 76, "DEF": 75, "SpATK": 81, "SpDEF": 100, "SPD": 100, "Type1": "Fire"],
    ["DexNumber": "0039", "Name": "Jigglypuff", "HP": 115, "ATK": 45, "DEF": 20, "SpATK": 45, "SpDEF": 25, "SPD": 20, "Type1": "Normal", "Type2": "Fairy"],
    ["DexNumber": "0040", "Name": "Wigglytuff", "HP": 140, "ATK": 70, "DEF": 45, "SpATK": 85, "SpDEF": 50, "SPD": 45, "Type1": "Normal", "Type2": "Fairy"],
    ["DexNumber": "0041", "Name": "Zubat", "HP": 40, "ATK": 45, "DEF": 35, "SpATK": 30, "SpDEF": 40, "SPD": 55, "Type1": "Poison", "Type2": "Flying"],
    ["DexNumber": "0042", "Name": "Golbat", "HP": 75, "ATK": 80, "DEF": 70, "SpATK": 65, "SpDEF": 75, "SPD": 90, "Type1": "Poison", "Type2": "Flying"],
    ["DexNumber": "0043", "Name": "Oddish", "HP": 45, "ATK": 50, "DEF": 55, "SpATK": 75, "SpDEF": 65, "SPD": 30, "Type1": "Grass", "Type2": "Poison"],
    ["DexNumber": "0044", "Name": "Gloom", "HP": 60, "ATK": 65, "DEF": 70, "SpATK": 85, "SpDEF": 75, "SPD": 40, "Type1": "Grass", "Type2": "Poison"],
    ["DexNumber": "0045", "Name": "Vileplume", "HP": 75, "ATK": 80, "DEF": 85, "SpATK": 110, "SpDEF": 90, "SPD": 50, "Type1": "Grass", "Type2": "Poison"],
    ["DexNumber": "0046", "Name": "Paras", "HP": 35, "ATK": 70, "DEF": 55, "SpATK": 45, "SpDEF": 55, "SPD": 25, "Type1": "Bug", "Type2": "Grass"],
    ["DexNumber": "0047", "Name": "Parasect", "HP": 60, "ATK": 95, "DEF": 80, "SpATK": 60, "SpDEF": 80, "SPD": 30, "Type1": "Bug", "Type2": "Grass"],
    ["DexNumber": "0048", "Name": "Venonat", "HP": 60, "ATK": 55, "DEF": 50, "SpATK": 40, "SpDEF": 55, "SPD": 45, "Type1": "Bug", "Type2": "Poison"],
    ["DexNumber": "0049", "Name": "Venomoht", "HP": 70, "ATK": 65, "DEF": 60, "SpATK": 90, "SpDEF": 75, "SPD": 90, "Type1": "Bug", "Type2": "Poison"],
    ["DexNumber": "0050", "Name": "Diglett", "HP": 10, "ATK": 55, "DEF": 25, "SpATK": 35, "SpDEF": 45, "SPD": 95, "Type1": "Ground"],
    ["DexNumber": "0051", "Name": "Dugtrio", "HP": 35, "ATK": 100, "DEF": 50, "SpATK": 50, "SpDEF": 70, "SPD": 120, "Type1": "Ground"],
    ["DexNumber": "0052", "Name": "Meowth", "HP": 40, "ATK": 45, "DEF": 35, "SpATK": 40, "SpDEF": 40, "SPD": 90, "Type1": "Normal"],
    ["DexNumber": "0053", "Name": "Persian", "HP": 65, "ATK": 70, "DEF": 60, "SpATK": 65, "SpDEF": 65, "SPD": 115, "Type1": "Normal"],
    ["DexNumber": "0054", "Name": "Psyduck", "HP": 50, "ATK": 52, "DEF": 48, "SpATK": 65, "SpDEF": 50, "SPD": 55, "Type1": "Water"],
    ["DexNumber": "0055", "Name": "Golduck", "HP": 80, "ATK": 82, "DEF": 78, "SpATK": 95, "SpDEF": 80, "SPD": 85, "Type1": "Water"],
    ["DexNumber": "0056", "Name": "Mankey", "HP": 40, "ATK": 80, "DEF": 35, "SpATK": 35, "SpDEF": 45, "SPD": 70, "Type1": "Fighting"],
    ["DexNumber": "0057", "Name": "Primeape", "HP": 65, "ATK": 105, "DEF": 60, "SpATK": 60, "SpDEF": 70, "SPD": 95, "Type1": "Fighting"],
    ["DexNumber": "0058", "Name": "Growlithe", "HP": 55, "ATK": 70, "DEF": 45, "SpATK": 70, "SpDEF": 50, "SPD": 60, "Type1": "Fire"],
    ["DexNumber": "0059", "Name": "Arcanine", "HP": 90, "ATK": 110, "DEF": 80, "SpATK": 100, "SpDEF": 80, "SPD": 95, "Type1": "Fire"],
    ["DexNumber": "0060", "Name": "Poliwag", "HP": 40, "ATK": 50, "DEF": 40, "SpATK": 40, "SpDEF": 40, "SPD": 90, "Type1": "Water"],
    ["DexNumber": "0061", "Name": "Poliwhirl", "HP": 65, "ATK": 65, "DEF": 65, "SpATK": 50, "SpDEF": 50, "SPD": 90, "Type1": "Water"],
    ["DexNumber": "0062", "Name": "Poliwrath", "HP": 90, "ATK": 95, "DEF": 95, "SpATK": 70, "SpDEF": 90, "SPD": 70, "Type1": "Water", "Type2": "Fighting"],
    ["DexNumber": "0063", "Name": "Abra", "HP": 25, "ATK": 20, "DEF": 15, "SpATK": 105, "SpDEF": 55, "SPD": 90, "Type1": "Psychic"],
    ["DexNumber": "0064", "Name": "Kadabra", "HP": 40, "ATK": 35, "DEF": 30, "SpATK": 120, "SpDEF": 70, "SPD": 105, "Type1": "Psychic"],
    ["DexNumber": "0065", "Name": "Alakazam", "HP": 55, "ATK": 50, "DEF": 45, "SpATK": 135, "SpDEF": 95, "SPD": 120, "Type1": "Psychic"],
    ["DexNumber": "0066", "Name": "Machop", "HP": 70, "ATK": 80, "DEF": 50, "SpATK": 35, "SpDEF": 35, "SPD": 35, "Type1": "Fighting"],
    ["DexNumber": "0067", "Name": "Machoke", "HP": 80, "ATK": 100, "DEF": 70, "SpATK": 50, "SpDEF": 60, "SPD": 45, "Type1": "Fighting"],
    ["DexNumber": "0068", "Name": "Machamp", "HP": 90, "ATK": 130, "DEF": 80, "SpATK": 65, "SpDEF": 85, "SPD": 55, "Type1": "Fighting"],
    ["DexNumber": "0069", "Name": "Bellsprout", "HP": 50, "ATK": 75, "DEF": 35, "SpATK": 70, "SpDEF": 30, "SPD": 40, "Type1": "Grass", "Type2": "Poison"],
    ["DexNumber": "0070", "Name": "Weepinbell", "HP": 65, "ATK": 90, "DEF": 50, "SpATK": 85, "SpDEF": 45, "SPD": 55, "Type1": "Grass", "Type2": "Poison"],
    ["DexNumber": "0071", "Name": "Victreebell", "HP": 80, "ATK": 105, "DEF": 65, "SpATK": 100, "SpDEF": 70, "SPD": 70, "Type1": "Grass", "Type2": "Poison"],
    ["DexNumber": "0072", "Name": "Tentacool", "HP": 40, "ATK": 40, "DEF": 35, "SpATK": 50, "SpDEF": 100, "SPD": 70, "Type1": "Water", "Type2": "Poison"],
    ["DexNumber": "0073", "Name": "Tentacruel", "HP": 80, "ATK": 70, "DEF": 65, "SpATK": 80, "SpDEF": 120, "SPD": 100, "Type1": "Water", "Type2": "Poison"],
    ["DexNumber": "0074", "Name": "Geodude", "HP": 40, "ATK": 80, "DEF": 100, "SpATK": 30, "SpDEF": 30, "SPD": 20, "Type1": "Rock", "Type2": "Ground"],
    ["DexNumber": "0075", "Name": "Graveler", "HP": 55, "ATK": 95, "DEF": 115, "SpATK": 45, "SpDEF": 45, "SPD": 35, "Type1": "Rock", "Type2": "Ground"],
    ["DexNumber": "0076", "Name": "Golem", "HP": 80, "ATK": 120, "DEF": 130, "SpATK": 55, "SpDEF": 65, "SPD": 45, "Type1": "Rock", "Type2": "Ground"],
    ["DexNumber": "0077", "Name": "Ponyta", "HP": 50, "ATK": 85, "DEF": 55, "SpATK": 65, "SpDEF": 65, "SPD": 90, "Type1": "Fire"],
    ["DexNumber": "0078", "Name": "Rapidash", "HP": 65, "ATK": 100, "DEF": 70, "SpATK": 80, "SpDEF": 80, "SPD": 105, "Type1": "Fire"],
    ["DexNumber": "0079", "Name": "Slowpoke", "HP": 90, "ATK": 65, "DEF": 65, "SpATK": 40, "SpDEF": 40, "SPD": 15, "Type1": "Water", "Type2": "Psychic"],
    ["DexNumber": "0080", "Name": "Slowbro", "HP": 95, "ATK": 75, "DEF": 110, "SpATK": 100, "SpDEF": 80, "SPD": 30, "Type1": "Water", "Type2": "Psychic"],
    ["DexNumber": "0081", "Name": "Magnemite", "HP": 25, "ATK": 35, "DEF": 70, "SpATK": 95, "SpDEF": 55, "SPD": 45, "Type1": "Electric", "Type2": "Steel"],
    ["DexNumber": "0082", "Name": "Magneton", "HP": 50 , "ATK": 60, "DEF": 95, "SpATK": 120, "SpDEF": 70, "SPD": 70, "Type1": "Electric", "Type2": "Steel"],
    ["DexNumber": "0083", "Name": "Farfetch'd", "HP": 52, "ATK": 90, "DEF": 55, "SpATK": 58, "SpDEF": 62, "SPD": 60, "Type1": "Normal", "Type2": "Flying"],
    ["DexNumber": "0084", "Name": "Doduo", "HP": 35, "ATK": 85, "DEF": 45, "SpATK": 35, "SpDEF": 35, "SPD": 75, "Type1": "Normal", "Type2": "Flying"],
    ["DexNumber": "0085", "Name": "Dodrio", "HP": 60, "ATK": 110, "DEF": 70, "SpATK": 60, "SpDEF": 60, "SPD": 110, "Type1": "Normal", "Type2": "Flying"],
    ["DexNumber": "0086", "Name": "Seel", "HP": 65, "ATK": 45, "DEF": 55, "SpATK": 45, "SpDEF": 70, "SPD": 45, "Type1": "Water"],
    ["DexNumber": "0087", "Name": "Dewgong", "HP": 90, "ATK": 70, "DEF": 80, "SpATK": 70, "SpDEF": 95, "SPD": 70, "Type1": "Water", "Type2": "Ice"],
    ["DexNumber": "0088", "Name": "Grimer", "HP": 80, "ATK": 80, "DEF": 50, "SpATK": 40, "SpDEF": 50, "SPD": 25, "Type1": "Poison"],
    ["DexNumber": "0089", "Name": "Muk", "HP": 105, "ATK": 105, "DEF": 75, "SpATK": 65, "SpDEF": 100, "SPD": 50, "Type1": "Poison"],
    ["DexNumber": "0090", "Name": "Shellder", "HP": 30, "ATK": 65, "DEF": 100, "SpATK": 45, "SpDEF": 25, "SPD": 40, "Type1": "Water"],
    ["DexNumber": "0091", "Name": "Cloyster", "HP": 50, "ATK": 95, "DEF": 180, "SpATK": 85, "SpDEF": 45, "SPD": 70, "Type1": "Water", "Type2": "Ice"],
    ["DexNumber": "0092", "Name": "Gastly", "HP": 30, "ATK": 35, "DEF": 30, "SpATK": 100, "SpDEF": 35, "SPD": 80, "Type1": "Ghost", "Type2": "Poison"],
    ["DexNumber": "0093", "Name": "Haunter", "HP": 45, "ATK": 50, "DEF": 45, "SpATK": 115, "SpDEF": 55, "SPD": 95, "Type1": "Ghost", "Type2": "Poison"],
    ["DexNumber": "0094", "Name": "Gengar", "HP": 60, "ATK": 65, "DEF": 60, "SpATK": 130, "SpDEF": 75, "SPD": 110, "Type1": "Ghost", "Type2": "Poison"],
    ["DexNumber": "0095", "Name": "Onix", "HP": 35, "ATK": 45, "DEF": 160, "SpATK": 30, "SpDEF": 45, "SPD": 70, "Type1": "Rock", "Type2": "Ground"],
    ["DexNumber": "0096", "Name": "Drowzee", "HP": 60, "ATK": 48, "DEF": 45, "SpATK": 43, "SpDEF": 90, "SPD": 42, "Type1": "Psychic"],
    ["DexNumber": "0097", "Name": "Hypno", "HP": 85, "ATK": 73, "DEF": 70, "SpATK": 73, "SpDEF": 115, "SPD": 67, "Type1": "Psychic"],
    ["DexNumber": "0098", "Name": "Krabby", "HP": 30, "ATK": 105, "DEF": 90, "SpATK": 25, "SpDEF": 25, "SPD": 50, "Type1": "Water"],
    ["DexNumber": "0099", "Name": "Kingler", "HP": 55, "ATK": 130, "DEF": 110, "SpATK": 50, "SpDEF": 50, "SPD": 75, "Type1": "Water"],
    ["DexNumber": "0100", "Name": "Voltorb", "HP": 40, "ATK": 30, "DEF": 50, "SpATK": 55, "SpDEF": 55, "SPD": 100, "Type1": "Electric"],
    ["DexNumber": "0101", "Name": "Electrode", "HP": 60, "ATK": 50, "DEF": 70, "SpATK": 80, "SpDEF": 80, "SPD": 150, "Type1": "Electric"],
    ["DexNumber": "0102", "Name": "Exeggcute", "HP": 60, "ATK": 40, "DEF": 80, "SpATK": 60, "SpDEF": 45, "SPD": 40, "Type1": "Grass", "Type2": "Psychic"],
    ["DexNumber": "0103", "Name": "Exeggutor", "HP": 95, "ATK": 95, "DEF": 85, "SpATK": 125, "SpDEF": 75, "SPD": 55, "Type1": "Grass", "Type2": "Psychic"],
    ["DexNumber": "0104", "Name": "Cubone", "HP": 50, "ATK": 50, "DEF": 95, "SpATK": 40, "SpDEF": 50, "SPD": 35, "Type1": "Ground"],
    ["DexNumber": "0105", "Name": "Marowak", "HP": 60, "ATK": 80, "DEF": 110, "SpATK": 50, "SpDEF": 80, "SPD": 45, "Type1": "Ground"],
    ["DexNumber": "0106", "Name": "Hitmonlee", "HP": 50, "ATK": 120, "DEF": 53, "SpATK": 35, "SpDEF": 110, "SPD": 87, "Type1": "Fighting"],
    ["DexNumber": "0107", "Name": "Hitmonchan", "HP": 50, "ATK": 105, "DEF": 79, "SpATK": 35, "SpDEF": 110, "SPD": 76, "Type1": "Fighting"],
    ["DexNumber": "0108", "Name": "Lickitung", "HP": 90, "ATK": 55, "DEF": 75, "SpATK": 60, "SpDEF": 75, "SPD": 30, "Type1": "Normal"],
    ["DexNumber": "0109", "Name": "Koffing", "HP": 40, "ATK": 65, "DEF": 95, "SpATK": 60, "SpDEF": 45, "SPD": 35, "Type1": "Poison"],
    ["DexNumber": "0110", "Name": "Weezing", "HP": 65, "ATK": 90, "DEF": 120, "SpATK": 85, "SpDEF": 70, "SPD": 60, "Type1": "Poison"],
    ["DexNumber": "0111", "Name": "Rhyhorn", "HP": 80 , "ATK": 85, "DEF": 95, "SpATK": 30, "SpDEF": 30, "SPD": 25, "Type1": "Ground", "Type2": "Rock"],
    ["DexNumber": "0112", "Name": "Rhydon", "HP": 105, "ATK": 130, "DEF": 120, "SpATK": 45, "SpDEF": 45, "SPD": 40, "Type1": "Ground", "Type2": "Rock"],
    ["DexNumber": "0113", "Name": "Chansey", "HP": 250, "ATK": 5, "DEF": 5, "SpATK": 35, "SpDEF": 105, "SPD": 50, "Type1": "Normal"],
    ["DexNumber": "0114", "Name": "Tangela", "HP": 65, "ATK": 55, "DEF": 115, "SpATK": 100, "SpDEF": 40, "SPD": 60, "Type1": "Grass"],
    ["DexNumber": "0115", "Name": "Kangaskhan", "HP": 105, "ATK": 95, "DEF": 80, "SpATK": 40, "SpDEF": 80, "SPD": 90, "Type1": "Normal"],
    ["DexNumber": "0116", "Name": "Horsea", "HP": 30, "ATK": 40, "DEF": 70, "SpATK": 70, "SpDEF": 25, "SPD": 60, "Type1": "Water"],
    ["DexNumber": "0117", "Name": "Seadra", "HP": 55, "ATK": 65, "DEF": 95, "SpATK": 95, "SpDEF": 45, "SPD": 85, "Type1": "Water"],
    ["DexNumber": "0118", "Name": "Goldeen", "HP": 45, "ATK": 67, "DEF": 60, "SpATK": 35, "SpDEF": 50, "SPD": 63, "Type1": "Water" ],
    ["DexNumber": "0119", "Name": "Seaking", "HP": 80, "ATK":92, "DEF": 65, "SpATK": 65, "SpDEF": 80, "SPD": 68, "Type1": "Water"],
    ["DexNumber": "0120", "Name": "Staryu", "HP": 30, "ATK": 45, "DEF": 55, "SpATK": 70, "SpDEF": 55, "SPD": 85, "Type1": "Water"],
    ["DexNumber": "0121", "Name": "Starmie", "HP": 60, "ATK": 75, "DEF": 85, "SpATK": 100, "SpDEF": 85, "SPD": 115, "Type1": "Water", "Type2": "Psychic"],
    ["DexNumber": "0122", "Name": "Mr. Mime", "HP": 40, "ATK": 45, "DEF": 65, "SpATK": 100, "SpDEF": 120, "SPD": 90, "Type1": "Psychic"],
    ["DexNumber": "0123", "Name": "Scyther", "HP": 70, "ATK": 110, "DEF": 80, "SpATK": 55, "SpDEF": 80, "SPD": 105, "Type1": "Bug", "Type2": "Flying"],
    ["DexNumber": "0124", "Name": "Jynx", "HP": 65, "ATK": 50, "DEF": 35, "SpATK": 115, "SpDEF": 95, "SPD": 95, "Type1": "Ice", "Type2": "Psychic"],
    ["DexNumber": "0125", "Name": "Electabuzz", "HP": 65, "ATK": 83, "DEF": 57, "SpATK": 95, "SpDEF": 85, "SPD": 105, "Type1": "Electric"],
    ["DexNumber": "0126", "Name": "Magmar", "HP": 65, "ATK": 95, "DEF": 57, "SpATK": 100, "SpDEF": 85, "SPD": 93, "Type1": "Fire"],
    ["DexNumber": "0127", "Name": "Pinsir", "HP": 65, "ATK": 125, "DEF": 100, "SpATK": 55, "SpDEF": 70, "SPD": 85, "Type1": "Bug"],
    ["DexNumber": "0128", "Name": "Tauros", "HP": 75, "ATK": 100, "DEF": 95, "SpATK": 40, "SpDEF": 70, "SPD": 110, "Type1": "Normal"],
    ["DexNumber": "0129", "Name": "Magikarp", "HP": 20, "ATK": 10, "DEF": 55, "SpATK": 15, "SpDEF": 20, "SPD": 80, "Type1": "Water"],
    ["DexNumber": "0130", "Name": "Gyarados", "HP": 95, "ATK": 125, "DEF": 79, "SpATK": 60, "SpDEF": 100, "SPD": 81, "Type1": "Water", "Type2": "Flying"],
    ["DexNumber": "0131", "Name": "Lapras", "HP": 130, "ATK": 85, "DEF": 80, "SpATK": 85, "SpDEF": 95, "SPD": 60, "Type1": "Water", "Type2": "Ice"],
    ["DexNumber": "0132", "Name": "Ditto", "HP": 48, "ATK": 48, "DEF": 48, "SpATK": 48, "SpDEF": 48, "SPD": 48, "Type1": "Normal"],
    ["DexNumber": "0133", "Name": "Eevee", "HP": 55, "ATK": 55, "DEF": 50, "SpATK": 45, "SpDEF": 65, "SPD": 55, "Type1": "Normal"],
    ["DexNumber": "0134", "Name": "Vaporeon", "HP": 130, "ATK": 65, "DEF": 60, "SpATK": 110, "SpDEF": 95, "SPD": 65, "Type1": "Water"],
    ["DexNumber": "0135", "Name": "Jolteon", "HP": 65 , "ATK": 65, "DEF": 60, "SpATK": 110, "SpDEF": 95, "SPD": 130, "Type1": "Electric"],
    ["DexNumber": "0136", "Name": "Flareon", "HP": 65, "ATK": 130, "DEF": 60, "SpATK": 95, "SpDEF": 110, "SPD": 65, "Type1": "Fire"],
    ["DexNumber": "0137", "Name": "Porygon", "HP": 65, "ATK": 60, "DEF": 70, "SpATK": 85, "SpDEF": 75, "SPD": 40, "Type1": "Normal"],
    ["DexNumber": "0138", "Name": "Omanyte", "HP": 35, "ATK": 40, "DEF": 100, "SpATK": 90, "SpDEF": 55, "SPD": 35, "Type1": "Rock", "Type2": "Water"],
    ["DexNumber": "0139", "Name": "Omastar", "HP": 70, "ATK": 60, "DEF": 125, "SpATK": 115, "SpDEF": 70, "SPD": 55, "Type1": "Rock", "Type2": "Water"],
    ["DexNumber": "0140", "Name": "Kabuto", "HP": 30, "ATK": 80, "DEF": 90, "SpATK": 55, "SpDEF": 45, "SPD": 55, "Type1": "Rock", "Type2": "Water"],
    ["DexNumber": "0141", "Name": "Kabutops", "HP": 60, "ATK": 115, "DEF": 105, "SpATK": 65, "SpDEF": 70, "SPD": 80, "Type1": "Rock", "Type2": "Water"],
    ["DexNumber": "0142", "Name": "Aerodactyl", "HP": 80, "ATK": 105, "DEF": 65, "SpATK": 60, "SpDEF": 75, "SPD": 130, "Type1": "Rock", "Type2": "Flying"],
    ["DexNumber": "0143", "Name": "Sonrlax", "HP": 160, "ATK": 110, "DEF": 65, "SpATK": 65, "SpDEF": 110, "SPD": 30, "Type1": "Normal"],
    ["DexNumber": "0144", "Name": "Articuno", "HP": 90, "ATK": 85, "DEF": 100, "SpATK": 95, "SpDEF": 125, "SPD": 85, "Type1": "Ice", "Type2": "Flying"],
    ["DexNumber": "0145", "Name": "Zapdos", "HP": 90, "ATK": 90, "DEF": 85, "SpATK": 125, "SpDEF": 90, "SPD": 100, "Type1": "Electric", "Type2": "Flying"],
    ["DexNumber": "0146", "Name": "Moltres", "HP": 90, "ATK": 100, "DEF": 90, "SpATK": 125, "SpDEF": 85, "SPD": 90, "Type1": "Fire", "Type2": "Flying"],
    ["DexNumber": "0147", "Name": "Dratini", "HP": 41, "ATK": 64, "DEF": 45, "SpATK": 50, "SpDEF": 50, "SPD": 50, "Type1": "Dragon"],
    ["DexNumber": "0148", "Name": "Dragonair", "HP": 61, "ATK": 84, "DEF": 65, "SpATK": 70, "SpDEF": 70, "SPD": 70, "Type1": "Dragon"],
    ["DexNumber": "0149", "Name": "Dragonite", "HP": 91, "ATK": 134, "DEF": 95, "SpATK": 100, "SpDEF": 100, "SPD": 80, "Type1": "Dragon", "Type2": "Flying"],
    ["DexNumber": "0150", "Name": "Mewtwo", "HP": 106, "ATK": 110, "DEF": 90, "SpATK": 154, "SpDEF": 90, "SPD": 130, "Type1": "Psychic"],
    ["DexNumber": "0151", "Name": "Mew", "HP": 100, "ATK": 100, "DEF": 100, "SpATK": 100, "SpDEF": 100, "SPD": 100, "Type1": "Psychic"]
]






// PROGRAMA PRINCIPAL
MainHub()