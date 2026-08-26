-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3StoreItem.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3StoreItem", package.seeall)

local VersionActivity1_3StoreItem = class("VersionActivity1_3StoreItem", UserDataDispose)

function VersionActivity1_3StoreItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goStoreGoodsItem = gohelper.findChild(self.go, "#go_storegoodsitem")

	gohelper.setActive(self.goStoreGoodsItem, false)

	self.goodsItemList = self:getUserDataTb_()
	self._clipPosY = 424
	self._startFadePosY = 382.32
	self._showTagPosY = 300

	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
end

function VersionActivity1_3StoreItem:onBuyGoodsSuccess()
	self:sortGoodsCoList()
	self:refreshGoods()
end

function VersionActivity1_3StoreItem:sortGoodsCoList()
	table.sort(self.groupGoodsCoList, VersionActivity1_3StoreItem.sortGoods)
end

function VersionActivity1_3StoreItem:updateInfo(groupId, groupGoodsCoList)
	gohelper.setActive(self.go, true)

	self.groupGoodsCoList = groupGoodsCoList
	self.groupId = groupId

	self:sortGoodsCoList()
	self:_initTag()
	self:refreshGoods()
end

function VersionActivity1_3StoreItem:_initTag()
	if self.gotag then
		return
	end

	self.gotag = gohelper.findChild(self.go, "tag" .. self.groupId)

	gohelper.setActive(self.gotag, true)

	self.canvasGroup = self.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.imageTagType = gohelper.findChildImage(self.gotag, "image_tagType")
	self.txtTagName1 = gohelper.findChildText(self.gotag, "txt_tagName1")
	self.txtTagName2 = gohelper.findChildText(self.gotag, "txt_tagName2")
	self.tagName = luaLang("versionactivity1_3_store_tag_" .. self.groupId)
	self.txtTagName1.text = self.tagName
	self.tagMaskList = self:getUserDataTb_()

	table.insert(self.tagMaskList, self.imageTagType)
	table.insert(self.tagMaskList, self.txtTagName1)
	table.insert(self.tagMaskList, self.txtTagName2)
end

function VersionActivity1_3StoreItem:refreshTag()
	self.tagName = luaLang("versionactivity1_3_store_tag_" .. self.groupId)

	UISpriteSetMgr.instance:setV1a3StoreSprite(self.imageTagType, "v1a3_store_smalltitlebg_" .. self.groupId)

	self.firstName = GameUtil.utf8sub(self.tagName, 1, 1)
	self.remainName = ""

	local tagNameLen = GameUtil.utf8len(self.tagName)

	if tagNameLen > 1 then
		self.remainName = GameUtil.utf8sub(self.tagName, 2, tagNameLen - 1)
	end

	self.txtTagFirstName.text = self.firstName
	self.txtTagRemainName.text = self.remainName
end

function VersionActivity1_3StoreItem:refreshGoods()
	local goodsItem

	for index, goodsCo in ipairs(self.groupGoodsCoList) do
		goodsItem = self.goodsItemList[index]

		if not self.goodsItemList[index] then
			goodsItem = VersionActivity1_3StoreGoodsItem.New()

			goodsItem:onInitView(gohelper.cloneInPlace(self.goStoreGoodsItem))
			table.insert(self.goodsItemList, goodsItem)
		end

		goodsItem:updateInfo(goodsCo)
	end

	for i = #self.groupGoodsCoList + 1, #self.goodsItemList do
		self.goodsItemList[i]:hide()
	end
end

function VersionActivity1_3StoreItem:refreshTagClip(scrollStore)
	if not self.canvasGroup then
		return
	end

	local tagPosY = recthelper.rectToRelativeAnchorPos(self.gotag.transform.position, scrollStore.transform)

	self.canvasGroup.alpha = Mathf.Clamp((self._clipPosY - tagPosY.y) / (self._clipPosY - self._startFadePosY), 0, 1)

	for k, v in ipairs(self.tagMaskList) do
		v.maskable = tagPosY.y <= self._showTagPosY
	end
end

function VersionActivity1_3StoreItem.sortGoods(goodCo1, goodCo2)
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_3Enum.ActivityId.DungeonStore, goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_3Enum.ActivityId.DungeonStore, goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	return goodCo1.id < goodCo2.id
end

function VersionActivity1_3StoreItem:onDestroy()
	for _, goodsItem in ipairs(self.goodsItemList) do
		goodsItem:onDestroy()
	end

	self:__onDispose()
end

return VersionActivity1_3StoreItem
