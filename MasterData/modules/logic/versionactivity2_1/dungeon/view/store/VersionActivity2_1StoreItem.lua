-- chunkname: @modules/logic/versionactivity2_1/dungeon/view/store/VersionActivity2_1StoreItem.lua

module("modules.logic.versionactivity2_1.dungeon.view.store.VersionActivity2_1StoreItem", package.seeall)

local VersionActivity2_1StoreItem = class("VersionActivity2_1StoreItem", UserDataDispose)
local CLIP_POS_Y = 424
local START_FADE_POS_Y = 382.32
local SHOW_TAG_POS_Y = 300

local function sortGoods(goodCo1, goodCo2)
	local actId = VersionActivity2_1Enum.ActivityId.DungeonStore
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		return goods2SellOut
	end

	return goodCo1.id < goodCo2.id
end

function VersionActivity2_1StoreItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goStoreGoodsItem = gohelper.findChild(self.go, "#go_storegoodsitem")

	gohelper.setActive(self.goStoreGoodsItem, false)

	for i = 1, 3 do
		local gotag = gohelper.findChild(self.go, "tag" .. i)

		gohelper.setActive(gotag, false)
	end

	self.goodsItemList = self:getUserDataTb_()

	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
end

function VersionActivity2_1StoreItem:onBuyGoodsSuccess()
	self:sortGoodsCoList()
	self:refreshGoods()
end

function VersionActivity2_1StoreItem:updateInfo(groupId, groupGoodsCoList)
	gohelper.setActive(self.go, true)

	self.groupGoodsCoList = groupGoodsCoList or {}
	self.groupId = groupId

	self:sortGoodsCoList()
	self:refreshTag()
	self:refreshGoods()
end

function VersionActivity2_1StoreItem:sortGoodsCoList()
	table.sort(self.groupGoodsCoList, sortGoods)
end

function VersionActivity2_1StoreItem:refreshTag()
	if self.gotag then
		return
	end

	self.gotag = gohelper.findChild(self.go, "tag" .. self.groupId)
	self.tagCanvasGroup = self.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.imageTagType = gohelper.findChildImage(self.gotag, "image_tagType")
	self.txtTagName = gohelper.findChildText(self.gotag, "txt_tagName")

	gohelper.setActive(self.gotag, true)

	self.tagMaskList = self:getUserDataTb_()

	table.insert(self.tagMaskList, self.imageTagType)
	table.insert(self.tagMaskList, self.txtTagName)
end

function VersionActivity2_1StoreItem:refreshTagClip(scrollStore)
	if not self.tagCanvasGroup then
		return
	end

	local tagPosY = recthelper.rectToRelativeAnchorPos(self.gotag.transform.position, scrollStore.transform)

	self.tagCanvasGroup.alpha = Mathf.Clamp((CLIP_POS_Y - tagPosY.y) / (CLIP_POS_Y - START_FADE_POS_Y), 0, 1)

	for _, v in ipairs(self.tagMaskList) do
		v.maskable = tagPosY.y <= SHOW_TAG_POS_Y
	end
end

function VersionActivity2_1StoreItem:refreshGoods()
	local goodsItem

	for index, goodsCo in ipairs(self.groupGoodsCoList) do
		goodsItem = self.goodsItemList[index]

		if not self.goodsItemList[index] then
			local goodsItemGO = gohelper.cloneInPlace(self.goStoreGoodsItem)

			goodsItem = VersionActivity2_1StoreGoodsItem.New()

			goodsItem:onInitView(goodsItemGO)
			table.insert(self.goodsItemList, goodsItem)
		end

		goodsItem:updateInfo(goodsCo)
	end

	for i = #self.groupGoodsCoList + 1, #self.goodsItemList do
		self.goodsItemList[i]:hide()
	end
end

function VersionActivity2_1StoreItem:getHeight()
	return recthelper.getHeight(self.go.transform)
end

function VersionActivity2_1StoreItem:onDestroy()
	for _, goodsItem in ipairs(self.goodsItemList) do
		goodsItem:onDestroy()
	end

	self:__onDispose()
end

return VersionActivity2_1StoreItem
