-- chunkname: @modules/logic/bossrush/model/BossRushPlayViewListModel.lua

module("modules.logic.bossrush.model.BossRushPlayViewListModel", package.seeall)

local BossRushPlayViewListModel = class("BossRushPlayViewListModel", ListScrollModel)

BossRushPlayViewListModel.instance = BossRushPlayViewListModel.New()

return BossRushPlayViewListModel
