-- chunkname: @modules/logic/versionactivity1_9/dungeon/model/VersionActivity1_9StoreListModel.lua

module("modules.logic.versionactivity1_9.dungeon.model.VersionActivity1_9StoreListModel", package.seeall)

local VersionActivity1_9StoreListModel = class("VersionActivity1_9StoreListModel", ListScrollModel)

function VersionActivity1_9StoreListModel:onInit()
	return
end

function VersionActivity1_9StoreListModel:reInit()
	return
end

function VersionActivity1_9StoreListModel:initStoreGoodsConfig()
	if self.goodsConfigList then
		return
	end

	self.goodsConfigList = {}

	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(VersionActivity1_9Enum.ActivityId.DungeonStore) or {}

	for _, coList in pairs(storeGroupDict) do
		tabletool.addValues(self.goodsConfigList, coList)
	end
end

function VersionActivity1_9StoreListModel._sortGoods(goodsCo1, goodsCo2)
	local goods1SellOut = goodsCo1.maxBuyCount ~= 0 and goodsCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_9Enum.ActivityId.DungeonStore, goodsCo1.id) <= 0
	local goods2SellOut = goodsCo2.maxBuyCount ~= 0 and goodsCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_9Enum.ActivityId.DungeonStore, goodsCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	return goodsCo1.id < goodsCo2.id
end

function VersionActivity1_9StoreListModel:refreshStore()
	self:initStoreGoodsConfig()
	table.sort(self.goodsConfigList, VersionActivity1_9StoreListModel._sortGoods)
	self:setList(self.goodsConfigList)
end

VersionActivity1_9StoreListModel.instance = VersionActivity1_9StoreListModel.New()

return VersionActivity1_9StoreListModel
