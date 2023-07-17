//
//  SvatiDataService.swift
//  Svati
//
//  Created by Petr Hracek on 17.07.2023.
//

import Foundation

class SvatiDataService {
    // MARK: - Shared
    static var shared = SvatiDataService()
    
    // MARK: - Properties
    var svatiStructure: SvatiStructure?
    // MARK: -
    func loadData() {
        parseDatabaseJSON()
    }
    
    private func parseDatabaseJSON() {
        if let path = Bundle.main.path(forResource: "database", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                svatiStructure = try JSONDecoder().decode(SvatiStructure.self, from: data)
            }
            catch {
                print(path)
                print(error)
            }
        }
        else
        {
            print("File not found")
        }
    }
}
