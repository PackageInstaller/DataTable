-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/store/VersionActivity1_8StoreItem.lua

module("modules.logic.versionactivity1_8.dungeon.view.store.VersionActivity1_8StoreItem", package.seeall)

local VersionActivity1_8StoreItem = class("VersionActivity1_8StoreItem", UserDataDispose)
local CLIP_POS_Y = 424
local START_FADE_POS_Y = 382.32
local SHOW_TAG_POS_Y = 300

local function sortGoods(goodCo1, goodCo2)
	local actId = VersionActivity1_8Enum.ActivityId.DungeonStore
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		return goods2SellOut
	end

	return goodCo1.id < goodCo2.id
end

function VersionActivity1_8StoreItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goStoreGoodsItem = gohelper.findChild(self.go, "#go_storegoodsitem")

	gohelper.setActive(self.goStoreGoodsItem, false)

	self.goodsItemList = self:getUserDataTb_()

	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
end

function VersionActivity1_8StoreItem:onBuyGoodsSuccess()
	self:sortGoodsCoList()
	self:refreshGoods()
end

function VersionActivity1_8StoreItem:updateInfo(groupId, groupGoodsCoList)
	gohelper.setActive(self.go, true)

	self.groupGoodsCoList = groupGoodsCoList or {}
	self.groupId = groupId

	self:sortGoodsCoList()
	self:refreshTag()
	self:refreshGoods()
end

function VersionActivity1_8StoreItem:sortGoodsCoList()
	table.sort(self.groupGoodsCoList, sortGoods)
end

function VersionActivity1_8StoreItem:refreshTag()
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

function VersionActivity1_8StoreItem:refreshTagClip(scrollStore)
	if not self.tagCanvasGroup then
		return
	end

	local tagPosY = recthelper.rectToRelativeAnchorPos(self.gotag.transform.position, scrollStore.transform)

	self.tagCanvasGroup.alpha = Mathf.Clamp((CLIP_POS_Y - tagPosY.y) / (CLIP_POS_Y - START_FADE_POS_Y), 0, 1)

	for _, v in ipairs(self.tagMaskList) do
		v.maskable = tagPosY.y <= SHOW_TAG_POS_Y
	end
end

function VersionActivity1_8StoreItem:refreshGoods()
	local goodsItem

	for index, goodsCo in ipairs(self.groupGoodsCoList) do
		goodsItem = self.goodsItemList[index]

		if not self.goodsItemList[index] then
			local goodsItemGO = gohelper.cloneInPlace(self.goStoreGoodsItem)

			goodsItem = VersionActivity1_8StoreGoodsItem.New()

			goodsItem:onInitView(goodsItemGO)
			table.insert(self.goodsItemList, goodsItem)
		end

		goodsItem:updateInfo(goodsCo)
	end

	for i = #self.groupGoodsCoList + 1, #self.goodsItemList do
		self.goodsItemList[i]:hide()
	end
end

function VersionActivity1_8StoreItem:getHeight()
	return recthelper.getHeight(self.go.transform)
end

function VersionActivity1_8StoreItem:onDestroy()
	for _, goodsItem in ipairs(self.goodsItemList) do
		goodsItem:onDestroy()
	end

	self:__onDispose()
end

return VersionActivity1_8StoreItem
