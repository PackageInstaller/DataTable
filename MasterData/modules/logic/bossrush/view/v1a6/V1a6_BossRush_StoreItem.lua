-- chunkname: @modules/logic/bossrush/view/v1a6/V1a6_BossRush_StoreItem.lua

module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_StoreItem", package.seeall)

local V1a6_BossRush_StoreItem = class("V1a6_BossRush_StoreItem", UserDataDispose)

function V1a6_BossRush_StoreItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goStoreGoodsItem = gohelper.findChild(self.go, "#go_storegoodsitem")
	self._btnTips = gohelper.findChildButtonWithAudio(self.go, "tag2/#go_Time/image_TipsBG/#txt_Time/#btn_Tips")
	self._goTips = gohelper.findChild(self.go, "tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips")
	self._txtTimeTips = gohelper.findChildText(self.go, "tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips/image_Tips/#txt_TimeTips")
	self._btnclosetip = gohelper.findChildButtonWithAudio(self.go, "tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips/#btn_closetip")

	gohelper.setActive(self.goStoreGoodsItem, false)

	self.goodsItemList = self:getUserDataTb_()
	self._clipPosY = 424
	self._startFadePosY = 382.32
	self._showTagPosY = 300

	self._btnTips:AddClickListener(self._btnTipsOnClick, self)
	self._btnclosetip:AddClickListener(self._btnclosetipOnClick, self)
	gohelper.setActive(self._goTips, false)
end

function V1a6_BossRush_StoreItem:_btnclosetipOnClick()
	gohelper.setActive(self._goTips, false)
end

function V1a6_BossRush_StoreItem:_btnTipsOnClick()
	gohelper.setActive(self._goTips, true)
end

function V1a6_BossRush_StoreItem:_updateInfo()
	self:sortGoodsMoList()
	self:refreshGoods()
end

function V1a6_BossRush_StoreItem:sortGoodsMoList()
	if self.groupGoodsMoList then
		table.sort(self.groupGoodsMoList:getGoodsList(), V1a6_BossRush_StoreItem.sortGoods)
	end
end

function V1a6_BossRush_StoreItem:updateInfo(groupId, groupGoodsMoList)
	gohelper.setActive(self.go, true)

	self.groupGoodsMoList = groupGoodsMoList
	self.groupId = groupId

	self:sortGoodsMoList()
	self:refreshTag()
	self:refreshGoods()
	self:_updateInfo()

	local isNilStoreMo = next(self.groupGoodsMoList:getGoodsList()) == nil

	gohelper.setActive(self.gotag, not isNilStoreMo)
end

function V1a6_BossRush_StoreItem:refreshTag()
	self.gotag = gohelper.findChild(self.go, "tag" .. self.groupId)
	self.canvasGroup = self.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.imageTagType = gohelper.findChildImage(self.gotag, "image_tagType")
	self.txtTagName = gohelper.findChildText(self.gotag, "txt_tagName")

	gohelper.setActive(self.gotag, true)

	local storeType = V1a6_BossRush_StoreModel.instance:getStore()
	local nameCn, nameEn = V1a6_BossRush_StoreModel.instance:getStoreGroupName(storeType[self.groupId])

	self.txtTagName.text = nameCn
	self.tagMaskList = self:getUserDataTb_()

	table.insert(self.tagMaskList, self.imageTagType)
	table.insert(self.tagMaskList, self.txtTagName)
end

function V1a6_BossRush_StoreItem:refreshGoods()
	if not self.groupGoodsMoList then
		return
	end

	local goodsList = self.groupGoodsMoList:getGoodsList()

	if not goodsList then
		return
	end

	for index, goodsMo in pairs(goodsList) do
		local goodsItem = self.goodsItemList[index]

		if not goodsItem then
			goodsItem = V1a6_BossRush_StoreGoodsItem.New()

			local go = gohelper.cloneInPlace(self.goStoreGoodsItem)

			goodsItem:onInitView(go)
			table.insert(self.goodsItemList, goodsItem)
		end

		goodsItem:updateInfo(goodsMo)

		local _goodsNewData = V1a6_BossRush_StoreModel.instance:getStoreGoodsNewData(self.groupGoodsMoList.id, goodsMo.goodsId)

		goodsItem:updateNewData(_goodsNewData)
	end

	gohelper.setAsLastSibling(self.gotag.gameObject)

	for i = #goodsList + 1, #self.goodsItemList do
		self.goodsItemList[i]:hide()
	end
end

function V1a6_BossRush_StoreItem:refreshTagClip(scrollStore)
	if not self.canvasGroup then
		return
	end

	local tagPosY = recthelper.rectToRelativeAnchorPos(self.gotag.transform.position, scrollStore.transform)

	self.canvasGroup.alpha = Mathf.Clamp((self._clipPosY - tagPosY.y) / (self._clipPosY - self._startFadePosY), 0, 1)

	for k, v in ipairs(self.tagMaskList) do
		v.maskable = tagPosY.y <= self._showTagPosY
	end
end

function V1a6_BossRush_StoreItem.sortGoods(goodMo1, goodMo2)
	local co1 = goodMo1.config
	local co2 = goodMo2.config
	local goods1SellOut = goodMo1:isSoldOut()
	local goods2SellOut = goodMo2:isSoldOut()

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	if co1.order ~= co2.order then
		return co1.order < co2.order
	end

	return co1.id < co2.id
end

function V1a6_BossRush_StoreItem:getHeight()
	ZProj.UGUIHelper.RebuildLayout(self.go.transform)

	return (recthelper.getHeight(self.go.transform))
end

function V1a6_BossRush_StoreItem:onDestroy()
	for _, goodsItem in ipairs(self.goodsItemList) do
		goodsItem:onDestroy()
	end

	self:__onDispose()
end

function V1a6_BossRush_StoreItem:onClose()
	self._btnTips:RemoveClickListener()
	self._btnclosetip:RemoveClickListener()
end

return V1a6_BossRush_StoreItem
