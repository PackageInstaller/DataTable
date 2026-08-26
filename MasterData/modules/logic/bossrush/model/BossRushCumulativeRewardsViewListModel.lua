-- chunkname: @modules/logic/bossrush/model/BossRushCumulativeRewardsViewListModel.lua

module("modules.logic.bossrush.model.BossRushCumulativeRewardsViewListModel", package.seeall)

local BossRushCumulativeRewardsViewListModel = class("BossRushCumulativeRewardsViewListModel", ListScrollModel)

BossRushCumulativeRewardsViewListModel.instance = BossRushCumulativeRewardsViewListModel.New()

return BossRushCumulativeRewardsViewListModel
