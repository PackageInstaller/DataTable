-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Achieve\\ActivityGiftAchieve.lua

local RechargeManager = require("System/Recharge/RechargeManager")
local EventConst = require("EventConst")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivityGiftAchieveCell = Class("ActivityGiftAchieveCell", UIControls.Child)

function ActivityGiftAchieveCell:ctor()
	self:initUI()
end

function ActivityGiftAchieveCell:initUI()
	self.textProgress = UIControls.Label(self, "BgSliderNum/SliderNum")
	self.btnGet = UIControls.Button(self, "BtnGet")

	self.btnGet:addEventClick(self.onGetClick)

	self.bonusGrids = {}
end

function ActivityGiftAchieveCell:setData(data)
	self.actData = self.mParent.actObj.actData
	self.achieveData = data

	local showProgress, maxProgress = self.actData:getAchieveShowProgress(data)

	self.textProgress:setText(maxProgress)
	ClientUtils.CreateBonusGrid(self, self.bonusGrids, "AwardPanel/AwardNode", data.award, true, nil, true)

	local achState = self.actData:getAchieveState(data.type, data.index)

	if achState == Const.ACT_ACHIEVE_STATE_GOT then
		self:playStateAnimator("PaySignInPointPanelDis")
		self.btnGet:setVisible(false)
	elseif achState == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self:playStateAnimator("PaySignInPointPanelSel")
		self.btnGet:setVisible(true)
	else
		self:playStateAnimator("PaySignInPointPanelNml")
		self.btnGet:setVisible(false)
	end

	for _, grid in ipairs(self.bonusGrids) do
		grid:setGet(achState == Const.ACT_ACHIEVE_STATE_GOT)
	end
end

function ActivityGiftAchieveCell:onGetClick()
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mParent.actObj.opId, self.achieveData.index, self.achieveData.type), self.mParent.actObj.opId)
end

local classNameStr = "ActivityGiftAchieve"
local ActivityGiftAchieve = Class(classNameStr, UIControls.Child)

MixinClass(ActivityGiftAchieve, ActivityPanelMixin)

function ActivityGiftAchieve:_setData()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.textRule = UIControls.Label(self, "BgTextDes/TextDes")
	self.panelGift = UIControls.Panel(self, "BtnBuyPanel")
	self.giftBounsGrids = {}
	self.panelBuyOnce = UIControls.Panel(self, "BtnBuyPanel/BtnBuyOnePanel")
	self.btnBuyOnce = UIControls.Button(self, "BtnBuyPanel/BtnBuyOnePanel/BtnBuy")

	self.btnBuyOnce:addEventClick(self.onOnceBuyClick)

	self.onceIconCurrency = UIControls.Image(self, "BtnBuyPanel/BtnBuyOnePanel/BtnBuy/PricePanel/IconCurrency")
	self.onceTextPrice = UIControls.Label(self, "BtnBuyPanel/BtnBuyOnePanel/BtnBuy/PricePanel/TextPrice")
	self.textBuyOnce = UIControls.Label(self, "BtnBuyPanel/BtnBuyOnePanel/TextLimit")
	self.panelBuyMulti = UIControls.Panel(self, "BtnBuyPanel/BtnBuyMorePanel")
	self.btnBuyMulti = UIControls.Button(self, "BtnBuyPanel/BtnBuyMorePanel/BtnBuy")

	self.btnBuyMulti:addEventClick(self.onMultiBuyClick)

	self.multiIconCurrency = UIControls.Image(self, "BtnBuyPanel/BtnBuyMorePanel/BtnBuy/PricePanel/IconCurrency")
	self.multiTextPrice = UIControls.Label(self, "BtnBuyPanel/BtnBuyMorePanel/BtnBuy/PricePanel/TextPrice")
	self.btnGetMulti = UIControls.Button(self, "BtnBuyPanel/BtnBuyMorePanel/BtnFree")

	self.btnGetMulti:addEventClick(self.onMultiGetClick)

	self.textGetMulti = UIControls.Label(self, "BtnBuyPanel/BtnBuyMorePanel/TextLimit")
	self.panelGot = UIControls.Panel(self, "BtnBuyPanel/ImgStatePanel")
	self.textGotNotice = UIControls.Label(self, "BtnBuyPanel/ImgStatePanel/TextLimit")
	self.textProgress = UIControls.Label(self, "AddUpPanel/AddDayNum/TxtNum")
	self.textProgressShadow = UIControls.Label(self, "AddUpPanel/AddDayNum/TxtNum1")
	self.cells = {}
	self.relateGiftActId = self.actObj.templateData.relate_act and self.actObj.templateData.relate_act[1]
	self.giftActObj = CurAvatar:getActivityObj(self.relateGiftActId)
	self._slot4ProductLoaded = Slot(self.refreshData, self)

	EventCenter.addEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)

	local template_args = self.clientTemplateData.template_args

	if template_args then
		self.multiGetConfirm = tonumber(template_args[1])
	end

	self.onceIconCurrency:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", "IconRMB")
	self.multiIconCurrency:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas", "IconRMB")
end

function ActivityGiftAchieve:_onShow(pageShow)
	self.achieveData = {}

	for achieveType, typeData in pairs(self.actObj.actData.clientData) do
		self.achieveData = typeData

		break
	end

	for index = #self.cells, #self.achieveData - 1 do
		local newCell = ActivityGiftAchieveCell(self, "AddUpPanel/PointPanel", "System/Activity/ActivityPaySignInGift/ActivityPaySignInPointCell01")

		table.insert(self.cells, newCell)
	end

	self:refreshData()

	if pageShow then
		self.giftActObj:saveTodayOnceNew()
	end
end

function ActivityGiftAchieve:refreshData()
	self.giftProduct = nil

	if self.giftActObj then
		local products = self.giftActObj.actData:getAllProduct(true)

		self.giftProduct = products[1]
	end

	if self.giftProduct then
		local product = self.giftProduct[1]

		self.onceTextPrice:setText(product.priceText)
		ClientUtils.CreateBonusGrid(self, self.giftBounsGrids, "GiftPanel", product.randId, true, nil, true)
		self.panelGift:setVisible(true)

		self.rechargeId = product.rechargeId
		self.multiProduct = RechargeManager.getProductByRechargeId(product.mulityLinkId)

		if self.multiProduct then
			self.multiTextPrice:setText(self.multiProduct.priceText)
		end

		local canGotTime = product:getGetLeftTimes()
		local maxTime = product.buyTimesMax
		local count = self.giftActObj.actData:getHasBuyNum(self.rechargeId)

		product.buyTimesLeft = maxTime - count

		if product.buyTimesLeft <= 0 then
			self.panelBuyOnce:setVisible(false)
			self.panelBuyMulti:setVisible(false)
			self.panelGot:setVisible(true)

			if canGotTime and canGotTime > 0 then
				self.textGotNotice:setText(string.format(Lang.get(70238), canGotTime))
			else
				self.textGotNotice:setText("")
			end
		else
			self.panelGot:setVisible(false)

			if canGotTime and canGotTime > 0 then
				self.panelBuyOnce:setVisible(false)
				self.panelBuyMulti:setVisible(true)
				self.btnBuyMulti:setVisible(false)
				self.btnGetMulti:setVisible(true)
				self.textGetMulti:setText(string.format(Lang.get(103888), canGotTime))
			else
				self.panelBuyOnce:setVisible(true)
				self.panelBuyMulti:setVisible(true)
				self.btnBuyMulti:setVisible(true)
				self.btnGetMulti:setVisible(false)
				self.textGetMulti:setText("")
			end
		end

		for _, grid in ipairs(self.giftBounsGrids) do
			grid:setGet(product.buyTimesLeft <= 0)
		end
	else
		self.panelGift:setVisible(false)
	end

	for index, cell in ipairs(self.cells) do
		cell:setVisible(true)
		cell:setData(self.achieveData[index])
	end

	local actData = self.actObj.actData
	local curProgress = 0

	if actData.serverData[self.achieveData[1].type] then
		curProgress = actData.serverData[self.achieveData[1].type].progress
	end

	self.textProgress:setText(curProgress)
	self.textProgressShadow:setText(curProgress)
end

function ActivityGiftAchieve:onActivityDataRefresh()
	self:refreshData()
end

function ActivityGiftAchieve:updateRelatedActivityData()
	self:refreshData()
end

function ActivityGiftAchieve:onOnceBuyClick()
	if self.rechargeId then
		CurAvatar:activityRPC(Functor(RechargeManager.startRecharge, self.rechargeId, nil, nil), self.giftActObj.opId)
	end
end

function ActivityGiftAchieve:onMultiBuyClick()
	if self.multiProduct then
		local function yesFunc()
			CurAvatar:activityRPC(Functor(RechargeManager.startRecharge, self.multiProduct.rechargeId, nil, nil), self.giftActObj.opId)
		end

		if self.multiGetConfirm then
			UIManager.showConfirmWithId(self.multiGetConfirm, yesFunc)
		else
			yesFunc()
		end
	end
end

function ActivityGiftAchieve:realGetMulti()
	if self.rechargeId and self.multiProduct then
		CurAvatar:activityRPC(Functor(RPC.rechargeGetMulityAward, self.multiProduct.rechargeId, self.rechargeId), self.giftActObj.opId)
	end
end

function ActivityGiftAchieve:onMultiGetClick()
	if self.rechargeId and self.multiProduct then
		self.slotRealGetMulti = self.slotRealGetMulti or Slot(self.realGetMulti, self)

		UIManager.showConfirmWithId(1138, self.slotRealGetMulti)
	end
end

function ActivityGiftAchieve:onDestroy()
	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
	ActivityGiftAchieve.super.onDestroy(self)
end

return ActivityGiftAchieve
