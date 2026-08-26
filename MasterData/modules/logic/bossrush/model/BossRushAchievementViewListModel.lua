-- chunkname: @modules/logic/bossrush/model/BossRushAchievementViewListModel.lua

module("modules.logic.bossrush.model.BossRushAchievementViewListModel", package.seeall)

local BossRushAchievementViewListModel = class("BossRushAchievementViewListModel", ListScrollModel)

BossRushAchievementViewListModel.instance = BossRushAchievementViewListModel.New()

return BossRushAchievementViewListModel
