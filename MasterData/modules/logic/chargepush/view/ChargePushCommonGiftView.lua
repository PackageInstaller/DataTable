-- chunkname: @modules/logic/chargepush/view/ChargePushCommonGiftView.lua

module("modules.logic.chargepush.view.ChargePushCommonGiftView", package.seeall)

local ChargePushCommonGiftView = class("ChargePushCommonGiftView", BaseView)

function ChargePushCommonGiftView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self.btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyLeft")
	self.btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyRight")
	self.btnTop = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyTop")
	self.btnBottom = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyBottom")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "root/info/#scroll_desc/Viewport/Content/#txt_desc")
	self.goGiftItem = gohelper.findChild(self.viewGO, "root/#scroll_gift/Viewport/Content/#go_giftitem")

	gohelper.setActive(self.goGiftItem, false)

	self.goodsItemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChargePushCommonGiftView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickClose, self)
	self.addClickCb(self, self.btnLeft, self.onClickClose, self)
	self.addClickCb(self, self.btnRight, self.onClickClose, self)
	self.addClickCb(self, self.btnTop, self.onClickClose, self)
	self.addClickCb(self, self.btnBottom, self.onClickClose, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._payFinished, self)
end

function ChargePushCommonGiftView:removeEvents()
	self:removeClickCb(self.btnClose)
	self:removeClickCb(self.btnLeft)
	self:removeClickCb(self.btnRight)
	self:removeClickCb(self.btnTop)
	self:removeClickCb(self.btnBottom)
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._payFinished, self)
end

function ChargePushCommonGiftView:_editableInitView()
	return
end

function ChargePushCommonGiftView:_payFinished()
	if not self.config then
		return
	end

	local goodsIds = string.splitToNumber(self.config.containedgoodsId, "#")
	local hasNotBuyGoods = false

	for _, goodsId in ipairs(goodsIds) do
		local goodsMO = StoreModel.instance:getGoodsMO(goodsId)

		if goodsMO and not goodsMO:isSoldOut() then
			hasNotBuyGoods = true

			break
		end
	end

	if hasNotBuyGoods then
		self:refreshView()

		return
	end

	if ChargePushController.instance:tryShowNextPush(self.config.className) then
		return
	end

	self:closeThis()
end

function ChargePushCommonGiftView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function ChargePushCommonGiftView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function ChargePushCommonGiftView:refreshParam()
	self.config = self.viewParam and self.viewParam.config
end

function ChargePushCommonGiftView:refreshView()
	if not self.config then
		return
	end

	self.txtDesc.text = self.config.desc

	local availableGoodsIds = {}
	local goodsIds = string.splitToNumber(self.config.containedgoodsId, "#")

	for i, v in ipairs(goodsIds) do
		local goodsMO = StoreModel.instance:getGoodsMO(v)

		if goodsMO and not goodsMO:isSoldOut() then
			table.insert(availableGoodsIds, v)
		end
	end

	for i = 1, 2 do
		availableGoodsIds[i] = availableGoodsIds[i] or 0
	end

	for i = 1, math.max(#availableGoodsIds, #self.goodsItemList) do
		local item = self:getItem(i)

		self:updateItem(item, availableGoodsIds[i])
	end
end

function ChargePushCommonGiftView:getItem(index)
	local item = self.goodsItemList[index]

	if not item then
		item = self:getUserDataTb_()
		self.goodsItemList[index] = item
		item.go = gohelper.cloneInPlace(self.goGiftItem, tostring(index))
		item.goHas = gohelper.findChild(item.go, "#go_has")
		item.goEmpty = gohelper.findChild(item.go, "#go_empty")
	end

	return item
end

function ChargePushCommonGiftView:updateItem(item, goodsId)
	item.goodsId = goodsId

	if not goodsId then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local config = StoreConfig.instance:getChargeGoodsConfig(goodsId, true)
	local isEmpty = config == nil

	gohelper.setActive(item.goEmpty, isEmpty)
	gohelper.setActive(item.goHas, not isEmpty)

	if isEmpty then
		return
	end

	local packageMo = StoreModel.instance:getPackageGoodMo(goodsId)

	if not item.goodsItem then
		local resPath = self.viewContainer:getSetting().otherRes.itemRes
		local go = self.viewContainer:getResInst(resPath, item.goHas, "goodsItem")

		item.goodsItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, PackageStoreGoodsItem)

		item.goodsItem:setClickCallback(self.onClickGoodsItem, self)
	end

	item.goodsItem:onUpdateMO(packageMo)
end

function ChargePushCommonGiftView:onClickGoodsItem(goodsMo)
	return
end

function ChargePushCommonGiftView:onClose()
	return
end

function ChargePushCommonGiftView:onDestroyView()
	return
end

function ChargePushCommonGiftView:onClickClose()
	self:closeThis()
end

function ChargePushCommonGiftView:onClickModalMask()
	self:closeThis()
end

return ChargePushCommonGiftView
