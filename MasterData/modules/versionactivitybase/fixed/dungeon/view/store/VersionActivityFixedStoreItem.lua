-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/store/VersionActivityFixedStoreItem.lua

module("modules.versionactivitybase.fixed.dungeon.view.store.VersionActivityFixedStoreItem", package.seeall)

local VersionActivityFixedStoreItem = class("VersionActivityFixedStoreItem", UserDataDispose)
local CLIP_POS_Y = 424
local START_FADE_POS_Y = 382.32
local SHOW_TAG_POS_Y = 300

local function sortGoods(goodCo1, goodCo2, actId)
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		return goods2SellOut
	end

	if goodCo1.specProduct ~= goodCo2.specProduct then
		return goodCo1.specProduct == 1
	end

	return goodCo1.id < goodCo2.id
end

function VersionActivityFixedStoreItem:setActId(id)
	self.actId = id
end

function VersionActivityFixedStoreItem:onInitView(go)
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

	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
end

function VersionActivityFixedStoreItem:onBuyGoodsSuccess()
	self:sortGoodsCoList()
	self:refreshGoods()
end

function VersionActivityFixedStoreItem:updateInfo(groupId, groupGoodsCoList)
	gohelper.setActive(self.go, true)

	self.groupGoodsCoList = groupGoodsCoList or {}
	self.groupId = groupId

	self:sortGoodsCoList()
	self:refreshTag()
	self:refreshGoods()
end

function VersionActivityFixedStoreItem:sortGoodsCoList()
	table.sort(self.groupGoodsCoList, function(a, b)
		return sortGoods(a, b, self.actId)
	end)
end

function VersionActivityFixedStoreItem:refreshTag()
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

function VersionActivityFixedStoreItem:refreshTagClip(scrollStore)
	if not self.tagCanvasGroup then
		return
	end

	local tagPosY = recthelper.rectToRelativeAnchorPos(self.gotag.transform.position, scrollStore.transform)

	self.tagCanvasGroup.alpha = Mathf.Clamp((CLIP_POS_Y - tagPosY.y) / (CLIP_POS_Y - START_FADE_POS_Y), 0, 1)

	for _, v in ipairs(self.tagMaskList) do
		v.maskable = tagPosY.y <= SHOW_TAG_POS_Y
	end
end

function VersionActivityFixedStoreItem:refreshGoods()
	local goodsItem
	local count = 0

	for index, goodsCo in ipairs(self.groupGoodsCoList) do
		goodsItem = self.goodsItemList[goodsCo.id]

		if not self.goodsItemList[goodsCo.id] then
			local goodsItemGO = gohelper.cloneInPlace(self.goStoreGoodsItem)

			if goodsCo.specProduct == 1 then
				if not VersionActivitySpecialStoreGoodsItem then
					local storeGoodsItem = VersionActivityFixedStoreGoodsItem

					goodsItem = storeGoodsItem.New()

					goodsItem:setActId(self.actId)
					goodsItem:onInitView(goodsItemGO)

					self.goodsItemList[goodsCo.id] = goodsItem
				end
			end
		end

		goodsItem:updateInfo(goodsCo)

		count = count + 1

		gohelper.setSibling(goodsItem.go, index)
	end
end

function VersionActivityFixedStoreItem:getHeight()
	return recthelper.getHeight(self.go.transform)
end

function VersionActivityFixedStoreItem:onDestroy()
	for _, goodsItem in pairs(self.goodsItemList) do
		goodsItem:onDestroy()
	end

	self:__onDispose()
end

return VersionActivityFixedStoreItem
