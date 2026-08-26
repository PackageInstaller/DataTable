-- chunkname: @modules/logic/versionactivity2_5/dungeon/model/VersionActivity2_5StoreListModel.lua

module("modules.logic.versionactivity2_5.dungeon.model.VersionActivity2_5StoreListModel", package.seeall)

local VersionActivity2_5StoreListModel = class("VersionActivity2_5StoreListModel", ListScrollModel)

function VersionActivity2_5StoreListModel:onInit()
	return
end

function VersionActivity2_5StoreListModel:reInit()
	return
end

function VersionActivity2_5StoreListModel:initStoreGoodsConfig()
	if self.goodsConfigList then
		return
	end

	self.goodsConfigList = {}

	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(VersionActivity2_5Enum.ActivityId.DungeonStore) or {}

	for _, coList in pairs(storeGroupDict) do
		tabletool.addValues(self.goodsConfigList, coList)
	end
end

function VersionActivity2_5StoreListModel._sortGoods(goodsCo1, goodsCo2)
	local goods1SellOut = goodsCo1.maxBuyCount ~= 0 and goodsCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity2_5Enum.ActivityId.DungeonStore, goodsCo1.id) <= 0
	local goods2SellOut = goodsCo2.maxBuyCount ~= 0 and goodsCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity2_5Enum.ActivityId.DungeonStore, goodsCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	return goodsCo1.id < goodsCo2.id
end

function VersionActivity2_5StoreListModel:refreshStore()
	self:initStoreGoodsConfig()
	table.sort(self.goodsConfigList, VersionActivity2_5StoreListModel._sortGoods)
	self:setList(self.goodsConfigList)
end

VersionActivity2_5StoreListModel.instance = VersionActivity2_5StoreListModel.New()

return VersionActivity2_5StoreListModel
