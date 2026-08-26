-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_StoreItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_StoreItem", package.seeall)

local Rouge2_StoreItem = class("Rouge2_StoreItem", UserDataDispose)

function Rouge2_StoreItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goStoreGoodsItem = gohelper.findChild(self.go, "#go_storegoodsitem")

	gohelper.setActive(self.goStoreGoodsItem, false)

	self.goodsItemList = self:getUserDataTb_()
	self._clipPosY = 424
	self._startFadePosY = 382.32
	self._showTagPosY = 300

	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnBuyStoreGoodsSuccess, self.onBuyGoodsSuccess, self)
end

function Rouge2_StoreItem:onBuyGoodsSuccess()
	self:sortGoodsCoList()
	self:refreshGoods()
end

function Rouge2_StoreItem:sortGoodsCoList()
	table.sort(self.groupGoodsCoList, Rouge2_StoreItem.sortGoods)
end

function Rouge2_StoreItem:updateInfo(groupId, groupGoodsCoList)
	gohelper.setActive(self.go, true)

	self.groupGoodsCoList = groupGoodsCoList
	self.groupId = groupId

	self:sortGoodsCoList()
	self:refreshTag()
	self:refreshGoods()
end

function Rouge2_StoreItem:refreshTag()
	if self.gotag then
		return
	end

	self.gotag = gohelper.findChild(self.go, "tag" .. self.groupId)
	self.canvasGroup = self.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.imageTagType = gohelper.findChildImage(self.gotag, "image_tagType")
	self.txtTagName = gohelper.findChildTextMesh(self.imageTagType.gameObject, "txt_tagName")

	gohelper.setActive(self.gotag, true)

	local constId = Rouge2_Enum.RewardGroupConstIdOffset + self.groupId
	local constConfig = Rouge2_OutSideConfig.instance:getConstConfigById(constId)

	if constConfig then
		self.txtTagName.text = constConfig.desc
	else
		logError("不存在的商店标题 groupId: " .. self.groupId .. "constId: " .. tostring(constId))
	end

	self.tagMaskList = self:getUserDataTb_()

	table.insert(self.tagMaskList, self.imageTagType)
	table.insert(self.tagMaskList, self.txtTagName)
end

function Rouge2_StoreItem:refreshGoods()
	local goodsItem

	for index, goodsCo in ipairs(self.groupGoodsCoList) do
		goodsItem = self.goodsItemList[index]

		if not self.goodsItemList[index] then
			goodsItem = Rouge2_StoreGoodsItem.New()

			goodsItem:onInitView(gohelper.cloneInPlace(self.goStoreGoodsItem))
			table.insert(self.goodsItemList, goodsItem)
		end

		goodsItem:updateInfo(goodsCo)
	end

	for i = #self.groupGoodsCoList + 1, #self.goodsItemList do
		self.goodsItemList[i]:hide()
	end
end

function Rouge2_StoreItem:refreshTagClip(scrollStore)
	if not self.canvasGroup then
		return
	end

	local tagPosY = recthelper.rectToRelativeAnchorPos(self.gotag.transform.position, scrollStore.transform)

	self.canvasGroup.alpha = Mathf.Clamp((self._clipPosY - tagPosY.y) / (self._clipPosY - self._startFadePosY), 0, 1)

	for k, v in ipairs(self.tagMaskList) do
		v.maskable = tagPosY.y <= self._showTagPosY
	end
end

function Rouge2_StoreItem.sortGoods(goodCo1, goodCo2)
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - Rouge2_StoreModel.instance:getGoodsBuyCount(goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - Rouge2_StoreModel.instance:getGoodsBuyCount(goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	local rewardPriority1 = goodCo1.rewardPriority
	local rewardPriority2 = goodCo2.rewardPriority

	if rewardPriority1 ~= rewardPriority2 then
		return rewardPriority2 < rewardPriority1
	end

	return goodCo1.id < goodCo2.id
end

function Rouge2_StoreItem:onDestroy()
	for _, goodsItem in ipairs(self.goodsItemList) do
		goodsItem:onDestroy()
	end

	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnBuyStoreGoodsSuccess, self.onBuyGoodsSuccess, self)
	self:__onDispose()
end

function Rouge2_StoreItem:getHeight()
	return recthelper.getHeight(self.go.transform)
end

return Rouge2_StoreItem
