-- chunkname: @modules/logic/seasonver/act123/model/Season123StoreModel.lua

module("modules.logic.seasonver.act123.model.Season123StoreModel", package.seeall)

local Season123StoreModel = class("Season123StoreModel", ListScrollModel)

function Season123StoreModel:OnInit()
	self:reInit()
end

function Season123StoreModel:reInit()
	self.storeItemList = {}
end

function Season123StoreModel:setStoreItemList(itemList)
	self.storeItemList = tabletool.copy(itemList)

	table.sort(self.storeItemList, Season123StoreModel.sortGoods)
	self:setList(self.storeItemList)
end

function Season123StoreModel.sortGoods(goodCo1, goodCo2)
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(goodCo1.activityId, goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(goodCo2.activityId, goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	return goodCo1.id < goodCo2.id
end

Season123StoreModel.instance = Season123StoreModel.New()

return Season123StoreModel
