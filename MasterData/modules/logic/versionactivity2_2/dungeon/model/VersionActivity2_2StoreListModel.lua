-- chunkname: @modules/logic/versionactivity2_2/dungeon/model/VersionActivity2_2StoreListModel.lua

module("modules.logic.versionactivity2_2.dungeon.model.VersionActivity2_2StoreListModel", package.seeall)

local VersionActivity2_2StoreListModel = class("VersionActivity2_2StoreListModel", ListScrollModel)

function VersionActivity2_2StoreListModel:onInit()
	return
end

function VersionActivity2_2StoreListModel:reInit()
	return
end

function VersionActivity2_2StoreListModel:initStoreGoodsConfig()
	if self.goodsConfigList then
		return
	end

	self.goodsConfigList = {}

	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(VersionActivity2_2Enum.ActivityId.DungeonStore) or {}

	for _, coList in pairs(storeGroupDict) do
		tabletool.addValues(self.goodsConfigList, coList)
	end
end

function VersionActivity2_2StoreListModel._sortGoods(goodsCo1, goodsCo2)
	local goods1SellOut = goodsCo1.maxBuyCount ~= 0 and goodsCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity2_2Enum.ActivityId.DungeonStore, goodsCo1.id) <= 0
	local goods2SellOut = goodsCo2.maxBuyCount ~= 0 and goodsCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity2_2Enum.ActivityId.DungeonStore, goodsCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	return goodsCo1.id < goodsCo2.id
end

function VersionActivity2_2StoreListModel:refreshStore()
	self:initStoreGoodsConfig()
	table.sort(self.goodsConfigList, VersionActivity2_2StoreListModel._sortGoods)
	self:setList(self.goodsConfigList)
end

VersionActivity2_2StoreListModel.instance = VersionActivity2_2StoreListModel.New()

return VersionActivity2_2StoreListModel
