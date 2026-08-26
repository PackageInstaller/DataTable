-- chunkname: @modules/versionactivitybase/fixed/dungeon/model/VersionActivityFixedStoreListModel.lua

module("modules.versionactivitybase.fixed.dungeon.model.VersionActivityFixedStoreListModel", package.seeall)

local VersionActivityFixedStoreListModel = class("VersionActivityFixedStoreListModel", ListScrollModel)

function VersionActivityFixedStoreListModel:onInit()
	return
end

function VersionActivityFixedStoreListModel:reInit()
	return
end

function VersionActivityFixedStoreListModel:initStoreGoodsConfig()
	if self.goodsConfigList then
		return
	end

	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local actId = VersionActivityFixedHelper.getVersionActivityDungeonStore(bigVersion, smallVersion)

	self.goodsConfigList = {}
	self._speGoodsCoList = {}

	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(actId) or {}

	for _, coList in pairs(storeGroupDict) do
		tabletool.addValues(self.goodsConfigList, coList)

		for _, co in ipairs(coList) do
			if co.specProduct == 1 then
				table.insert(self._speGoodsCoList, co)
			end
		end
	end

	table.sort(self._speGoodsCoList, function(a, b)
		return a.id < b.id
	end)
end

function VersionActivityFixedStoreListModel._sortGoods(goodsCo1, goodsCo2)
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local actId = VersionActivityFixedHelper.getVersionActivityDungeonStore(bigVersion, smallVersion)
	local goods1SellOut = goodsCo1.maxBuyCount ~= 0 and goodsCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, goodsCo1.id) <= 0
	local goods2SellOut = goodsCo2.maxBuyCount ~= 0 and goodsCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, goodsCo2.id) <= 0

	if goodsCo1.specProduct ~= goodsCo2.specProduct then
		return goodsCo1.specProduct == 1
	end

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	return goodsCo1.id < goodsCo2.id
end

function VersionActivityFixedStoreListModel:refreshStore()
	self:initStoreGoodsConfig()
	table.sort(self.goodsConfigList, VersionActivityFixedStoreListModel._sortGoods)
	self:setList(self.goodsConfigList)
end

function VersionActivityFixedStoreListModel:getSpecialGoodsList()
	return self._speGoodsCoList or {}
end

VersionActivityFixedStoreListModel.instance = VersionActivityFixedStoreListModel.New()

return VersionActivityFixedStoreListModel
