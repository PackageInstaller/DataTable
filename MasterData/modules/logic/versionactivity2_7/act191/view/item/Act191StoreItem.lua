-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191StoreItem.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191StoreItem", package.seeall)

local Act191StoreItem = class("Act191StoreItem", UserDataDispose)

local function sortGoods(goodCo1, goodCo2)
	local actId = Activity191Controller.instance:getStoreId()
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		return goods2SellOut
	end

	return goodCo1.id < goodCo2.id
end

function Act191StoreItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goStoreGoodsItem = gohelper.findChild(self.go, "#go_storegoodsitem")

	gohelper.setActive(self.goStoreGoodsItem, false)

	self.goodsItemList = self:getUserDataTb_()

	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
end

function Act191StoreItem:onBuyGoodsSuccess()
	self:sortGoodsCoList()
	self:refreshGoods()
end

function Act191StoreItem:updateInfo(groupId, groupGoodsCoList)
	gohelper.setActive(self.go, true)

	self.groupGoodsCoList = groupGoodsCoList or {}
	self.groupId = groupId

	self:sortGoodsCoList()
	self:refreshGoods()
end

function Act191StoreItem:sortGoodsCoList()
	table.sort(self.groupGoodsCoList, sortGoods)
end

function Act191StoreItem:refreshGoods()
	local goodsItem

	for index, goodsCo in ipairs(self.groupGoodsCoList) do
		goodsItem = self.goodsItemList[index]

		if not self.goodsItemList[index] then
			local goodsItemGO = gohelper.cloneInPlace(self.goStoreGoodsItem)

			goodsItem = Act191StoreGoodsItem.New()

			goodsItem:onInitView(goodsItemGO)
			table.insert(self.goodsItemList, goodsItem)
		end

		goodsItem:updateInfo(goodsCo)
	end

	for i = #self.groupGoodsCoList + 1, #self.goodsItemList do
		self.goodsItemList[i]:hide()
	end
end

function Act191StoreItem:onDestroy()
	for _, goodsItem in ipairs(self.goodsItemList) do
		goodsItem:onDestroy()
	end

	self:__onDispose()
end

return Act191StoreItem
