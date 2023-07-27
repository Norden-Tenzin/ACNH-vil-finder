//
//  Helper.swift
//  AnimalCrossingTinder
//
//  Created by Tenzin Norden on 7/17/23.
//

import Foundation

class VillagerData: Codable {
    let poster: String
    let name: String
    let species: String
    let gender: String
    let personality: String
    let birthday: String
    let catchphrase: String

    init(poster: String, name: String, species: String, gender: String, personality: String, birthday: String, catchphrase: String) {
        self.poster = poster
        self.name = name
        self.species = species
        self.gender = gender
        self.personality = personality
        self.birthday = birthday
        self.catchphrase = catchphrase
    }
}

class VillagerCard: ObservableObject, Identifiable, Equatable {
    let id: UUID
    var villager: VillagerData
    @Published var degree: CGFloat
    @Published var value: CGFloat

    static func == (lhs: VillagerCard, rhs: VillagerCard) -> Bool {
        return lhs.id == rhs.id
    }

    init(villager: VillagerData) {
        self.id = UUID()
        self.villager = villager
        self.degree = .zero
        self.value = .zero
    }

    func update(degreeTo newDegree: CGFloat, valueTo newValue: CGFloat) {
        degree = newDegree
        value = newValue
    }

    func toString() -> String {
        return "Degree: \(degree), Value: \(value)"
    }

    func addToDeck() {
        degree = .zero
        value = .zero
    }

    func removeFromDeck() {
        degree = .zero
        value = -500
    }
}

class VillagerCards: ObservableObject {
    @Published var villagers: [VillagerCard]

    init(villagers: [VillagerCard]) {
        self.villagers = villagers
    }
}

func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}

func getJSONData (from file: String) -> Data? {
    guard let filePath = Bundle.main.path(forResource: file, ofType: "json") else {
        return nil
    }
    do {
        let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
        guard let jsonData = fileContents.data(using: .utf8) else {
            return nil
        }
        return jsonData
    } catch {
        print("error: \(error)")
    }
    return nil
}

func getJSON (from file: String) -> [VillagerCard] {
    do {
        let decoder = JSONDecoder()
        let villagerList = try decoder.decode([VillagerData].self, from: getJSONData(from: file)!)
        return villagerDataToVillagerCard(villagerList: villagerList)
    } catch {
        print("error: \(error)")
        return []
    }
}

func villagerDataToVillagerCard(villagerList: [VillagerData]) -> [VillagerCard] {
    var res: [VillagerCard] = []
    villagerList.forEach { villagerData in
        res.append(VillagerCard(villager: villagerData))
    }
    return res
}

func writeJSON (to file: String, villagers data: [VillagerCard]) -> Void {
    var jsonData: [VillagerData] = []
    for villager in data {
        jsonData.append(villager.villager)
    }
    do {
        let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("\(file).json")
        let encodedData = try JSONEncoder().encode(jsonData)
        try encodedData.write(to: fileURL)
    } catch {
        print("error: \(error)")
    }
}

func readJSON (from file: String, to data: VillagerCards) -> [VillagerData] {
    do {
        let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("\(file).json")
        return try JSONDecoder().decode([VillagerData].self, from: Data(contentsOf: fileURL))
    } catch {
        print("error: \(error)")
        return []
    }
}

func getFilePath (of fileName: String) -> URL? {
    do {
        let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(fileName)
        return fileURL
    } catch {
        print("error: \(error)")
        return nil
    }
}

func doesFileExist(at fileName: String) -> Bool? {
    return FileManager.default.fileExists(atPath: getFilePath(of: fileName)?.path ?? "")
}

func getJSONTest (from file: String, count num: Int) -> [VillagerCard] {
    do {
        var res: [VillagerCard] = []
        let decoder = JSONDecoder()
        let villagerList = try decoder.decode([VillagerData].self, from: getJSONData(from: file)!)
        villagerList.forEach { villagerData in
            res.append(VillagerCard(villager: villagerData))
        }
        return Array(res[0 ..< 5])
    } catch {
        print("error: \(error)")
        return []
    }
}

func getGenderSymbol(gender: String) -> String {
    if gender == "Male" {
        return "♂"
    } else {
        return "♀"
    }
}
