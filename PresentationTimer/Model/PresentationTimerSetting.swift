//
//  PresentationTimerSetting.swift
//  PresentationTimer
//
//  Created by 村中令 on 2023/06/16.
//

import Foundation
import RealmSwift

final class PresentationTimerSettingRepository {
    private let realm = try! Realm()
    //　並び替えあり
    func load(uuidString: String) -> PresentationTimerSetting {
        let realmTrainingMenus = realm
            .objects(RealmPresentationTimerSetting.self)
        let realmTrainingMenusArray = Array(realmTrainingMenus)
        let trainingMenus = realmTrainingMenusArray.map { PresentationTimerSetting(managedObject: $0) }
        let specifiedTrainingMenu = trainingMenus.filter { trainingMenu in
            trainingMenu.uuidString == uuidString
        }.first
        guard let specifiedTrainingMenu = specifiedTrainingMenu else { fatalError("指定のメニューがありません")}
        return specifiedTrainingMenu
    }
    func loadAtCreated(ascending: Bool) -> [PresentationTimerSetting] {
        let realmTrainingMenus = realm
            .objects(RealmPresentationTimerSetting.self)
            .sorted(byKeyPath: "createdAt", ascending: !ascending)
        let realmTrainingMenusArray = Array(realmTrainingMenus)
        let trainingMenus = realmTrainingMenusArray.map { PresentationTimerSetting(managedObject: $0) }
        return trainingMenus
    }

    func loadAtUsed(ascending: Bool) -> [PresentationTimerSetting] {
        let realmTrainingMenus = realm
            .objects(RealmPresentationTimerSetting.self)
            .sorted(byKeyPath: "usedAt", ascending: !ascending)
        let realmTrainingMenusArray = Array(realmTrainingMenus)
        let trainingMenus = realmTrainingMenusArray.map { PresentationTimerSetting(managedObject: $0) }
        return trainingMenus
    }

    func loadAtFavorites(isFavorite: Bool) -> [PresentationTimerSetting] {
        let realmTrainingMenus = realm
            .objects(RealmPresentationTimerSetting.self)
        let realmTrainingMenusArray = Array(realmTrainingMenus)
        let trainingMenus = realmTrainingMenusArray.map { PresentationTimerSetting(managedObject: $0) }
        let favoriteTrainingMenus = trainingMenus.filter { trainingMenu in
            trainingMenu.isFavorite == isFavorite
        }
        return favoriteTrainingMenus
    }

    // 新規追加
    func append(presentationTimerSetting: PresentationTimerSetting) {
        try! realm.write {
            let realmTrainingMenu = presentationTimerSetting.managedObject()
            realm.add(realmTrainingMenu)
        }
    }

    // 編集
    func update(presentationTimerSetting: PresentationTimerSetting) {
        try! realm.write {
            let realmTrainingMenu = realm.object(ofType: RealmPresentationTimerSetting.self, forPrimaryKey: presentationTimerSetting.uuidString)
            realmTrainingMenu?.totalTime = presentationTimerSetting.totalTime
            realmTrainingMenu?.firstSoundTime = presentationTimerSetting.firstSoundTime
            realmTrainingMenu?.secondSoundTime = presentationTimerSetting.secondSoundTime
            realmTrainingMenu?.thirdSoundTime = presentationTimerSetting.thirdSoundTime
            realmTrainingMenu?.isFavorite = presentationTimerSetting.isFavorite
            realmTrainingMenu?.createdAt = presentationTimerSetting.createdAt
            realmTrainingMenu?.usedAt = presentationTimerSetting.usedAt
        }
    }
    // 削除
    func remove(presentationTimerSetting: PresentationTimerSetting) {
        guard let trainingMenu = realm.object(
            ofType: RealmPresentationTimerSetting.self,
            forPrimaryKey: presentationTimerSetting.uuidString
        ) else { return }
        try! realm.write {
            realm.delete(trainingMenu)
        }
    }
}

struct PresentationTimerSetting {
    var uuidString = UUID().uuidString
    var totalTime: Int
    var firstSoundTime: Int
    var secondSoundTime: Int
    var thirdSoundTime: Int
    var isFavorite: Bool
    var createdAt: Date = Date()
    var usedAt: Date?
    var uuid: UUID? {
        UUID(uuidString: uuidString)
    }
}

class RealmPresentationTimerSetting: Object {
    @Persisted(primaryKey: true)
    var uuidString = ""
    @Persisted
    var totalTime: Int
    @Persisted
    var firstSoundTime: Int
    @Persisted
    var secondSoundTime: Int
    @Persisted
    var thirdSoundTime: Int
    @Persisted
    var isFavorite: Bool
    @Persisted
    var createdAt: Date
    @Persisted
    var usedAt: Date?
    var uuid: UUID? {
        UUID(uuidString: uuidString)
    }
    convenience init(
        totalTime: Int,
        firstSoundTime: Int,
        secondSoundTime: Int,
        thirdSoundTime: Int,
        isFavorite: Bool,
        createdAt: Date,
        usedAt: Date?
    ) {
        self.init()
        self.totalTime = totalTime
        self.firstSoundTime = firstSoundTime
        self.secondSoundTime = secondSoundTime
        self.thirdSoundTime = thirdSoundTime
        self.isFavorite = isFavorite
        self.createdAt = createdAt
        self.usedAt = usedAt
    }

    func update(value: PresentationTimerSetting) {
        totalTime = value.totalTime
        firstSoundTime = value.firstSoundTime
        secondSoundTime = value.secondSoundTime
        thirdSoundTime = value.thirdSoundTime
        isFavorite = value.isFavorite
        createdAt = value.createdAt
        usedAt = value.usedAt
    }
}

private extension PresentationTimerSetting {
    init(managedObject: RealmPresentationTimerSetting) {
        self.uuidString = managedObject.uuidString
        self.totalTime = managedObject.totalTime
        self.firstSoundTime = managedObject.firstSoundTime
        self.secondSoundTime = managedObject.secondSoundTime
        self.thirdSoundTime = managedObject.thirdSoundTime
        self.isFavorite = managedObject.isFavorite
        self.createdAt =  managedObject.createdAt
        self.usedAt =  managedObject.usedAt
    }

    func managedObject() -> RealmPresentationTimerSetting {
        let realmTrainingMenu = RealmPresentationTimerSetting()
        realmTrainingMenu.uuidString = uuidString
        realmTrainingMenu.totalTime = totalTime
        realmTrainingMenu.firstSoundTime = firstSoundTime
        realmTrainingMenu.secondSoundTime = secondSoundTime
        realmTrainingMenu.thirdSoundTime = thirdSoundTime
        realmTrainingMenu.isFavorite = isFavorite
        realmTrainingMenu.createdAt =  createdAt
        realmTrainingMenu.usedAt =  usedAt
        return realmTrainingMenu
    }
}
