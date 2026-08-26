-- chunkname: @modules/logic/versionactivity2_8/dungeontaskstore/model/VersionActivity2_8StoreListModel.lua

module("modules.logic.versionactivity2_8.dungeontaskstore.model.VersionActivity2_8StoreListModel", package.seeall)

local VersionActivity2_8StoreListModel = class("VersionActivity2_8StoreListModel", ListScrollModel)

function VersionActivity2_8StoreListModel:onInit()
	return
end

function VersionActivity2_8StoreListModel:reInit()
	return
end

function VersionActivity2_8StoreListModel:initStoreGoodsConfig()
	if self.goodsConfigList then
		return
	end

	self.goodsConfigList = {}

	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(VersionActivity2_8DungeonTaskStoreController.instance:getModuleConfig().DungeonStore) or {}

	for _, coList in pairs(storeGroupDict) do
		tabletool.addValues(self.goodsConfigList, coList)
	end
end

function VersionActivity2_8StoreListModel._sortGoods(goodsCo1, goodsCo2)
	local goods1SellOut = goodsCo1.maxBuyCount ~= 0 and goodsCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity2_8DungeonTaskStoreController.instance:getModuleConfig().DungeonStore, goodsCo1.id) <= 0
	local goods2SellOut = goodsCo2.maxBuyCount ~= 0 and goodsCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity2_8DungeonTaskStoreController.instance:getModuleConfig().DungeonStore, goodsCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	if goodsCo1.specProduct ~= goodsCo2.specProduct then
		return goodsCo1.specProduct == 1
	end

	return goodsCo1.id < goodsCo2.id
end

function VersionActivity2_8StoreListModel:refreshStore()
	self:initStoreGoodsConfig()
	table.sort(self.goodsConfigList, VersionActivity2_8StoreListModel._sortGoods)
	self:setList(self.goodsConfigList)
end

VersionActivity2_8StoreListModel.instance = VersionActivity2_8StoreListModel.New()

return VersionActivity2_8StoreListModel
