-- chunkname: @modules/logic/versionactivity/view/VersionActivityStoreItem.lua

module("modules.logic.versionactivity.view.VersionActivityStoreItem", package.seeall)

local VersionActivityStoreItem = class("VersionActivityStoreItem", UserDataDispose)

function VersionActivityStoreItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.gotag = gohelper.findChild(self.go, "tag")
	self.canvasGroup = self.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.imageTagType = gohelper.findChildImage(self.go, "tag/image_tagType")
	self.txtTagFirstName = gohelper.findChildText(self.go, "tag/txt_tagNameFirst")
	self.txtTagRemainName = gohelper.findChildText(self.go, "tag/txt_tagNameRemain")
	self.goStoreGoodsItem = gohelper.findChild(self.go, "#go_storegoodsitem")

	gohelper.setActive(self.goStoreGoodsItem, false)

	self.goodsItemList = self:getUserDataTb_()
	self.tagMaskList = self:getUserDataTb_()

	table.insert(self.tagMaskList, self.imageTagType)
	table.insert(self.tagMaskList, self.txtTagFirstName)
	table.insert(self.tagMaskList, self.txtTagRemainName)

	self._clipPosY = 424
	self._startFadePosY = 382.32
	self._showTagPosY = 300

	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
end

function VersionActivityStoreItem:onBuyGoodsSuccess()
	self:sortGoodsCoList()
	self:refreshGoods()
end

function VersionActivityStoreItem:sortGoodsCoList()
	table.sort(self.groupGoodsCoList, VersionActivityStoreItem.sortGoods)
end

function VersionActivityStoreItem:updateInfo(groupId, groupGoodsCoList)
	gohelper.setActive(self.go, true)

	self.groupGoodsCoList = groupGoodsCoList
	self.groupId = groupId

	self:sortGoodsCoList()
	self:refreshTag()
	self:refreshGoods()
end

function VersionActivityStoreItem:refreshTag()
	self.tagName = luaLang("versionactivity_store_tag_" .. self.groupId)

	UISpriteSetMgr.instance:setVersionActivitySprite(self.imageTagType, "img_title_label_" .. self.groupId)

	self.firstName = GameUtil.utf8sub(self.tagName, 1, 1)
	self.remainName = ""

	local tagNameLen = GameUtil.utf8len(self.tagName)

	if tagNameLen > 1 then
		self.remainName = GameUtil.utf8sub(self.tagName, 2, tagNameLen - 1)
	end

	self.txtTagFirstName.text = self.firstName
	self.txtTagRemainName.text = self.remainName
end

function VersionActivityStoreItem:refreshGoods()
	local goodsItem

	for index, goodsCo in ipairs(self.groupGoodsCoList) do
		goodsItem = self.goodsItemList[index]

		if not self.goodsItemList[index] then
			goodsItem = VersionActivityStoreGoodsItem.New()

			goodsItem:onInitView(gohelper.cloneInPlace(self.goStoreGoodsItem))
			table.insert(self.goodsItemList, goodsItem)
		end

		goodsItem:updateInfo(goodsCo)
	end

	for i = #self.groupGoodsCoList + 1, #self.goodsItemList do
		self.goodsItemList[i]:hide()
	end
end

function VersionActivityStoreItem:refreshTagClip(scrollStore)
	local tagPosY = recthelper.rectToRelativeAnchorPos(self.gotag.transform.position, scrollStore.transform)

	self.canvasGroup.alpha = Mathf.Clamp((self._clipPosY - tagPosY.y) / (self._clipPosY - self._startFadePosY), 0, 1)

	for k, v in ipairs(self.tagMaskList) do
		v.maskable = tagPosY.y <= self._showTagPosY
	end
end

function VersionActivityStoreItem.sortGoods(goodCo1, goodCo2)
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivityEnum.ActivityId.Act107, goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivityEnum.ActivityId.Act107, goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	return goodCo1.id < goodCo2.id
end

function VersionActivityStoreItem:onDestroy()
	for _, goodsItem in ipairs(self.goodsItemList) do
		goodsItem:onDestroy()
	end

	self:__onDispose()
end

return VersionActivityStoreItem
