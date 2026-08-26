-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonother/view/VersionActivity1_2StoreItem.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2StoreItem", package.seeall)

local VersionActivity1_2StoreItem = class("VersionActivity1_2StoreItem", UserDataDispose)

function VersionActivity1_2StoreItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.gotag = gohelper.findChild(self.go, "tag")
	self.canvasGroup = self.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.imageTagType = gohelper.findChildImage(self.go, "tag/image_tagType")
	self.imageframebg = gohelper.findChildImage(self.go, "image_framebg")
	self.imageframeicon = gohelper.findChildImage(self.go, "image_framebg/image_frameicon")
	self.simagespecialframebg = gohelper.findChildSingleImage(self.go, "image_framebg/simage_specialframebg")
	self.txtTagName = gohelper.findChildText(self.go, "tag/image_tagType/txt_tagName")
	self.txtTagNameSpecial = gohelper.findChildText(self.go, "tag/image_tagType/txt_tagNameSpecial")
	self.goStoreGoodsItem = gohelper.findChild(self.go, "#go_storegoodsitem")

	gohelper.setActive(self.goStoreGoodsItem, false)

	self.goodsItemList = {}
	self.tagMaskList = self:getUserDataTb_()

	table.insert(self.tagMaskList, self.imageTagType)
	table.insert(self.tagMaskList, self.txtTagName)

	self._clipPosY = 437
	self._startFadePosY = 382.32
	self._showTagPosY = 300
	self._groupTxtColors = {
		"#884315",
		"#f2cf6d",
		"#98d999"
	}
	self._groupTagColors = {
		"#884315",
		"#4c3a15",
		"#304032"
	}
	self._specialFrameWidth = 1246
	self._normalFrameWidth = 452

	self.simagespecialframebg:LoadImage(ResUrl.getVersionTradeBargainBg("framebg"))
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
end

function VersionActivity1_2StoreItem:onBuyGoodsSuccess()
	self:sortGoodsCoList()
	self:refreshGoods()
end

function VersionActivity1_2StoreItem:sortGoodsCoList()
	table.sort(self.groupGoodsCoList, self.sortGoods)
end

function VersionActivity1_2StoreItem:updateInfo(groupId, groupGoodsCoList)
	gohelper.setActive(self.go, true)

	self.groupGoodsCoList = groupGoodsCoList
	self.groupId = groupId

	self:sortGoodsCoList()
	self:refreshTag()
	self:refreshGoods()
end

function VersionActivity1_2StoreItem:refreshTag()
	self.tagName = luaLang("versionactivity_store_1_2_tag_" .. self.groupId)

	UISpriteSetMgr.instance:setVersionActivity1_2Sprite(self.imageframeicon, "bg_quyudi_" .. self.groupId)
	recthelper.setWidth(self.imageframeicon.transform, (self.groupId == 1 or nil) and (self._specialFrameWidth or self._normalFrameWidth))

	local secondCharIndex = utf8.next_raw(self.tagName, 1)

	self.firstName = self.tagName:sub(1, secondCharIndex - 1)
	self.remainName = self.tagName:sub(secondCharIndex)

	gohelper.setActive(self.txtTagNameSpecial, self.groupId == 1)
	gohelper.setActive(self.txtTagName, self.groupId ~= 1)
	gohelper.setActive(self.simagespecialframebg.gameObject, self.groupId == 1)

	self.txtTagName.text = string.format("<size=50>%s</size>%s", self.firstName, self.remainName)
	self.txtTagNameSpecial.text = string.format("<size=50>%s</size>%s", self.firstName, self.remainName)

	SLFramework.UGUI.GuiHelper.SetColor(self.imageTagType, self._groupTagColors[self.groupId])
	SLFramework.UGUI.GuiHelper.SetColor(self.imageframebg, self.groupId == 1 and "#88431566" or "#FFFFFF38")
	SLFramework.UGUI.GuiHelper.SetColor(self.txtTagName, self._groupTxtColors[self.groupId])
end

function VersionActivity1_2StoreItem:refreshGoods()
	local goodsItem

	for index, goodsCo in ipairs(self.groupGoodsCoList) do
		goodsItem = self.goodsItemList[index]

		if not self.goodsItemList[index] then
			goodsItem = VersionActivity1_2StoreGoodsItem.New()

			goodsItem:onInitView(gohelper.cloneInPlace(self.goStoreGoodsItem))
			table.insert(self.goodsItemList, goodsItem)
		end

		goodsItem:updateInfo(goodsCo)
	end

	for i = #self.groupGoodsCoList + 1, #self.goodsItemList do
		self.goodsItemList[i]:hide()
	end
end

function VersionActivity1_2StoreItem:refreshTagClip(scrollStore)
	local tagPosY = recthelper.rectToRelativeAnchorPos(self.gotag.transform.position, scrollStore.transform)

	self.canvasGroup.alpha = Mathf.Clamp((self._clipPosY - tagPosY.y) / (self._clipPosY - self._startFadePosY), 0, 1)

	for k, v in ipairs(self.tagMaskList) do
		v.maskable = tagPosY.y <= self._showTagPosY
	end
end

function VersionActivity1_2StoreItem:getHeight()
	return recthelper.getHeight(self.go.transform)
end

function VersionActivity1_2StoreItem.sortGoods(goodCo1, goodCo2)
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_2Enum.ActivityId.DungeonStore, goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_2Enum.ActivityId.DungeonStore, goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	return goodCo1.id < goodCo2.id
end

function VersionActivity1_2StoreItem:onDestroy()
	for _, goodsItem in ipairs(self.goodsItemList) do
		goodsItem:onDestroy()
	end

	self.goodsItemList = nil
	self.tagMaskList = nil

	self.simagespecialframebg:UnLoadImage()
	self:__onDispose()
end

return VersionActivity1_2StoreItem
