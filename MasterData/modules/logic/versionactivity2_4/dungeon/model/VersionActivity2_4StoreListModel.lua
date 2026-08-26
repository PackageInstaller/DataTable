-- chunkname: @modules/logic/versionactivity2_4/dungeon/model/VersionActivity2_4StoreListModel.lua

module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4StoreListModel", package.seeall)

local VersionActivity2_4StoreListModel = class("VersionActivity2_4StoreListModel", ListScrollModel)

function VersionActivity2_4StoreListModel:onInit()
	return
end

function VersionActivity2_4StoreListModel:reInit()
	return
end

function VersionActivity2_4StoreListModel:initStoreGoodsConfig()
	if self.goodsConfigList then
		return
	end

	self.goodsConfigList = {}

	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(VersionActivity2_4Enum.ActivityId.DungeonStore) or {}

	for _, coList in pairs(storeGroupDict) do
		tabletool.addValues(self.goodsConfigList, coList)
	end
end

function VersionActivity2_4StoreListModel._sortGoods(goodsCo1, goodsCo2)
	local goods1SellOut = goodsCo1.maxBuyCount ~= 0 and goodsCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity2_4Enum.ActivityId.DungeonStore, goodsCo1.id) <= 0
	local goods2SellOut = goodsCo2.maxBuyCount ~= 0 and goodsCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity2_4Enum.ActivityId.DungeonStore, goodsCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	return goodsCo1.id < goodsCo2.id
end

function VersionActivity2_4StoreListModel:refreshStore()
	self:initStoreGoodsConfig()
	table.sort(self.goodsConfigList, VersionActivity2_4StoreListModel._sortGoods)
	self:setList(self.goodsConfigList)
end

VersionActivity2_4StoreListModel.instance = VersionActivity2_4StoreListModel.New()

return VersionActivity2_4StoreListModel
