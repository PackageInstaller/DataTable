-- chunkname: @modules/logic/reactivity/view/ReactivityStoreItem.lua

module("modules.logic.reactivity.view.ReactivityStoreItem", package.seeall)

local ReactivityStoreItem = class("ReactivityStoreItem", UserDataDispose)

function ReactivityStoreItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goStoreGoodsItem = gohelper.findChild(self.go, "#go_storegoodsitem")

	gohelper.setActive(self.goStoreGoodsItem, false)

	self.goodsItemList = self:getUserDataTb_()
	self._clipPosY = 400
	self._startFadePosY = 360.32
	self._showTagPosY = 300

	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
end

function ReactivityStoreItem:onBuyGoodsSuccess()
	self:sortGoodsCoList()
	self:refreshGoods()
end

function ReactivityStoreItem:sortGoodsCoList()
	table.sort(self.groupGoodsCoList, ReactivityStoreItem.sortGoods)
end

function ReactivityStoreItem:updateInfo(groupId, groupGoodsCoList)
	gohelper.setActive(self.go, true)

	self.groupGoodsCoList = groupGoodsCoList
	self.groupId = groupId

	self:sortGoodsCoList()
	self:refreshTag()
	self:refreshGoods()
end

function ReactivityStoreItem:refreshTag()
	if self.gotag then
		return
	end

	self.gotag = gohelper.findChild(self.go, "tag" .. self.groupId)
	self.canvasGroup = self.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.imageTagType = gohelper.findChildImage(self.gotag, "image_tagType")

	gohelper.setActive(self.gotag, true)

	self.tagMaskList = self:getUserDataTb_()

	table.insert(self.tagMaskList, self.imageTagType)
end

function ReactivityStoreItem:refreshGoods()
	local goodsItem

	for index, goodsCo in ipairs(self.groupGoodsCoList) do
		goodsItem = self.goodsItemList[index]

		if not self.goodsItemList[index] then
			goodsItem = ReactivityStoreGoodsItem.New()

			goodsItem:onInitView(gohelper.cloneInPlace(self.goStoreGoodsItem))
			table.insert(self.goodsItemList, goodsItem)
		end

		goodsItem:updateInfo(goodsCo)
	end

	for i = #self.groupGoodsCoList + 1, #self.goodsItemList do
		self.goodsItemList[i]:hide()
	end
end

function ReactivityStoreItem:refreshTagClip(scrollStore)
	if not self.canvasGroup then
		return
	end

	local tagPosY = recthelper.rectToRelativeAnchorPos(self.gotag.transform.position, scrollStore.transform)

	self.canvasGroup.alpha = Mathf.Clamp((self._clipPosY - tagPosY.y) / (self._clipPosY - self._startFadePosY), 0, 1)

	for k, v in ipairs(self.tagMaskList) do
		v.maskable = tagPosY.y <= self._showTagPosY
	end
end

function ReactivityStoreItem.sortGoods(goodCo1, goodCo2)
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

function ReactivityStoreItem:getHeight()
	return recthelper.getHeight(self.go.transform)
end

function ReactivityStoreItem:onDestroy()
	for _, goodsItem in ipairs(self.goodsItemList) do
		goodsItem:onDestroy()
	end

	self:__onDispose()
end

return ReactivityStoreItem
