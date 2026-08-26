-- chunkname: @modules/logic/store/view/skindiscountcompensate/SkinDiscountCompensateActivityView.lua

module("modules.logic.store.view.skindiscountcompensate.SkinDiscountCompensateActivityView", package.seeall)

local SkinDiscountCompensateActivityView = class("SkinDiscountCompensateActivityView", BaseView)

function SkinDiscountCompensateActivityView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "#simage_Title")
	self._txtTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_Time")
	self._btnclick1 = gohelper.findChildButtonWithAudio(self.viewGO, "Reward1/#btn_click1")
	self._btnclick2 = gohelper.findChildButtonWithAudio(self.viewGO, "Reward2/#btn_click2")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Buy")
	self._txtBuy = gohelper.findChildText(self.viewGO, "#btn_Buy/#txt_Buy")
	self._gonationalgift = gohelper.findChild(self.viewGO, "#btn_Buy/#go_nationalgift")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SkinDiscountCompensateActivityView:addEvents()
	self._btnclick1:AddClickListener(self._btnclick1OnClick, self)
	self._btnclick2:AddClickListener(self._btnclick2OnClick, self)
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self.refreshUI, self)
end

function SkinDiscountCompensateActivityView:removeEvents()
	self._btnclick1:RemoveClickListener()
	self._btnclick2:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self.removeEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self.refreshUI, self)
end

function SkinDiscountCompensateActivityView:_btnclick1OnClick()
	self:showItemDetail(1)
end

function SkinDiscountCompensateActivityView:_btnclick2OnClick()
	self:showItemDetail(2)
end

function SkinDiscountCompensateActivityView:_btnBuyOnClick()
	if not self:checkActOpen() then
		return
	end

	local storeGoodsMo = StoreModel.instance:getGoodsMO(self.chargeGoodIds)

	if storeGoodsMo:isSoldOut() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)

	local packageStoreId = self.chargeGoodIds

	PayController.instance:startPay(packageStoreId)
end

SkinDiscountCompensateActivityView.luckyBagCount = 2

function SkinDiscountCompensateActivityView:_editableInitView()
	self.chargeGoodIds = StoreEnum.V3a3_SkinDiscountItemId
	self.txtList = self:getUserDataTb_()

	for index = 1, SkinDiscountCompensateActivityView.luckyBagCount do
		local text = gohelper.findChildTextMesh(self.viewGO, string.format("Reward%s/txt_Reward%s", index, index))

		table.insert(self.txtList, text)
	end
end

function SkinDiscountCompensateActivityView:onUpdateParam()
	return
end

function SkinDiscountCompensateActivityView:onOpen()
	local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(self.chargeGoodIds)

	if not chargeConfig then
		return
	end

	self.actId = self.viewParam.actId
	self.itemParam = GameUtil.splitString2(chargeConfig.item, true)

	local parentGO = self.viewParam.parent

	if parentGO then
		gohelper.addChild(parentGO, self.viewGO)
	end

	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneSecond)
	self:refreshUI()
	self:refreshName()
end

function SkinDiscountCompensateActivityView:showItemDetail(index)
	local itemParam = self.itemParam[index]

	if not itemParam then
		logError("皮肤折扣 缺少道具数据 商品id: " .. tostring(self.chargeGoodIds) .. " 索引:" .. tostring(index))

		return
	end

	local itemId = itemParam[2]

	if not itemId then
		logError("皮肤折扣 缺少道具id 商品id: " .. tostring(self.chargeGoodIds) .. " 索引:" .. tostring(index))

		return
	end

	local param = {}

	param.type = SkinDiscountCompensateEnum.SelectDisplayType.DisplayOnly
	param.itemId = itemId

	ViewMgr.instance:openView(ViewName.SkinDiscountCompensateSelectView, param)
end

function SkinDiscountCompensateActivityView:refreshUI()
	self:refreshBuyState()
end

function SkinDiscountCompensateActivityView:refreshName()
	for i = 1, SkinDiscountCompensateActivityView.luckyBagCount do
		local textName = self.txtList[i]
		local itemParam = self.itemParam[i]

		if not itemParam then
			logError("皮肤折扣 缺少道具数据 商品id: " .. tostring(self.chargeGoodIds) .. " 索引:" .. tostring(i))
		else
			local itemId = itemParam[2]

			if not itemId then
				logError("皮肤折扣 缺少道具id 商品id: " .. tostring(self.chargeGoodIds) .. " 索引:" .. tostring(i))
			elseif not itemParam[3] then
				local config = ItemConfig.instance:getItemCo(itemId)

				textName.text = config.name
			end
		end
	end
end

function SkinDiscountCompensateActivityView:refreshBuyState()
	local storeGoodsMo = StoreModel.instance:getGoodsMO(self.chargeGoodIds)
	local isBuy = storeGoodsMo:isSoldOut()

	gohelper.setActive(self._gonationalgift, not isBuy)
	ZProj.UGUIHelper.SetGrayscale(self._btnBuy.gameObject, isBuy)

	if isBuy then
		self._txtBuy.text = luaLang("v3a3_skindiscount_buy_tip")
	else
		local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(self.chargeGoodIds)

		if not chargeConfig then
			return
		end

		self._txtBuy.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v3a3_skindiscount_price"), tostring(chargeConfig.price))
	end
end

function SkinDiscountCompensateActivityView:checkActOpen()
	local actInfo = ActivityModel.instance:getActMO(self.actId)
	local endTime = actInfo:getRealEndTimeStamp()
	local nowTime = ServerTime.now()

	if endTime <= nowTime then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return false
	end

	return true
end

function SkinDiscountCompensateActivityView:refreshTime()
	local actInfo = ActivityModel.instance:getActMO(self.actId)
	local endTime = actInfo:getRealEndTimeStamp()
	local nowTime = ServerTime.now()

	if endTime <= nowTime then
		self._txtTime.text = luaLang("ended")

		return
	end

	self._txtTime.text = TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function SkinDiscountCompensateActivityView:onClose()
	return
end

function SkinDiscountCompensateActivityView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

return SkinDiscountCompensateActivityView
