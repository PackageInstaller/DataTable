-- chunkname: @modules/logic/bossrush/model/BossRushSelectBossViewListModel.lua

module("modules.logic.bossrush.model.BossRushSelectBossViewListModel", package.seeall)

local BossRushSelectBossViewListModel = class("BossRushSelectBossViewListModel", ListScrollModel)

BossRushSelectBossViewListModel.instance = BossRushSelectBossViewListModel.New()

return BossRushSelectBossViewListModel
