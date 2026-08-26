-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheStoreItem.lua

module("modules.logic.sodache.view.outside.comp.SodacheStoreItem", package.seeall)

local SodacheStoreItem = class("SodacheStoreItem", UserDataDispose)

local function sortGoods(goodCo1, goodCo2)
	local actId = VersionActivity3_7Enum.ActivityId.SodacheStore
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		return goods2SellOut
	end

	return goodCo1.id < goodCo2.id
end

function SodacheStoreItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goStoreGoodsItem = gohelper.findChild(self.go, "#go_storegoodsitem")

	gohelper.setActive(self.goStoreGoodsItem, false)

	self.goodsItemList = self:getUserDataTb_()

	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
end

function SodacheStoreItem:onBuyGoodsSuccess()
	self:sortGoodsCoList()
	self:refreshGoods()
end

function SodacheStoreItem:updateInfo(groupId, groupGoodsCoList)
	gohelper.setActive(self.go, true)

	self.groupGoodsCoList = groupGoodsCoList or {}
	self.groupId = groupId

	self:sortGoodsCoList()
	self:refreshGoods()
end

function SodacheStoreItem:sortGoodsCoList()
	table.sort(self.groupGoodsCoList, sortGoods)
end

function SodacheStoreItem:refreshGoods()
	local count = 0

	for _, goodsCo in ipairs(self.groupGoodsCoList) do
		if goodsCo.specProduct == 0 then
			count = count + 1

			local goodsItem = self.goodsItemList[count]

			if not goodsItem then
				local goodsItemGO = gohelper.cloneInPlace(self.goStoreGoodsItem)

				goodsItem = SodacheStoreGoodsItem.New()

				goodsItem:onInitView(goodsItemGO)

				self.goodsItemList[count] = goodsItem
			end

			goodsItem:updateInfo(goodsCo)
		end
	end

	for i = count + 1, #self.goodsItemList do
		self.goodsItemList[i]:hide()
	end
end

function SodacheStoreItem:onDestroy()
	for _, goodsItem in ipairs(self.goodsItemList) do
		goodsItem:onDestroy()
	end

	self:__onDispose()
end

return SodacheStoreItem
