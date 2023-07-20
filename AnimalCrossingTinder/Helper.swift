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

struct VillagerCard: Identifiable, Equatable {
    let id: UUID = UUID()
    var villager: VillagerData
    var degree: CGFloat = .zero
    var value: CGFloat = .zero

    static func == (lhs: VillagerCard, rhs: VillagerCard) -> Bool {
        return lhs.id == rhs.id
    }

    mutating func update(degreeTo newDegree: CGFloat, valueTo newValue: CGFloat) {
        degree = newDegree
        value = newValue
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
        var res: [VillagerCard] = []
        let decoder = JSONDecoder()
        let villagerList = try decoder.decode([VillagerData].self, from: getJSONData(from: file)!)
        villagerList.forEach { villagerData in
            res.append(VillagerCard(villager: villagerData, degree: .zero, value: .zero))
        }
        return res
    } catch {
        print("error: \(error)")
        return []
    }
}

func getJSONTest (from file: String, count num: Int) -> [VillagerCard] {
    do {
        var res: [VillagerCard] = []
        let decoder = JSONDecoder()
        let villagerList = try decoder.decode([VillagerData].self, from: getJSONData(from: file)!)
        villagerList.forEach { villagerData in
            res.append(VillagerCard(villager: villagerData, degree: .zero, value: .zero))
        }
        return Array(res[0 ..< 5])
    } catch {
        print("error: \(error)")
        return []
    }
}
