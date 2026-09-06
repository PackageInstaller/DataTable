-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/OptionalBuyView.lua

module("logic.extensions.equipment.view.OptionalBuyView", package.seeall)

local OptionalBuyView = class("OptionalBuyView", ViewComponent)

function OptionalBuyView:ctor()
	OptionalBuyView.super.ctor(self)
end

function OptionalBuyView:bindEvents()
	OptionalBuyView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "optionalbuy")
	end, self)
	self._popupBtn:AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self._popupBtn, MatType.Cloth, 300001, 0)
	end, self)
	self._lookBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.OptionalLook)
	end, self)
	self._buyBtn:AddClickListener(self._onClickBuyBtn, self)
end

function OptionalBuyView:unbindEvents()
	OptionalBuyView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._popupBtn:RemoveClickListener()
	self._lookBtn:RemoveClickListener()
	self._buyBtn:RemoveClickListener()
end

function OptionalBuyView:onExit()
	OptionalBuyView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._onShopItemBuySucRes, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil
end

function OptionalBuyView:destroyUI()
	OptionalBuyView.super.destroyUI(self)
end

function OptionalBuyView:buildUI()
	OptionalBuyView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._popupBtn = self:getBtn("popupBtn")
	self._lookBtn = self:getBtn("lookBtn")
	self._buyBtn = self:getBtn("buyBtn")
	self._timeTxt = goutil.findChildTextComponent(self.mainGO, "timeTxt")
	self._buyTxt = goutil.findChildTextComponent(self.mainGO, "buyBtn/buyTxt")
	self._buyImaGo = self:getGo("buyBtn/buyTxt/buyIma")
	self._buyOkGo = self:getGo("buyOkGo")
	self._timeTxt.text = ""
	self._buyTxt.text = ""

	self._buyOkGo:SetActive(false)
end

function OptionalBuyView:onEnter()
	OptionalBuyView.super.onEnter(self)
	removetimer(self._calculationSurplusTime, self)

	self._optionalInfo = PetEquipModel.instance:getOptionalFuncInfo()

	self:_showActivityTimer()

	if self._optionalInfo.isBuy then
		uGuiUtil.setImageGrayStateRecursive(self._buyBtn.gameObject, true)
		uGuiUtil.setTextGrayState(self._buyTxt.gameObject, true)
	else
		uGuiUtil.setImageGrayStateRecursive(self._buyBtn.gameObject, false)
		uGuiUtil.setTextGrayState(self._buyTxt.gameObject, false)
		GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._onShopItemBuySucRes, self)
	end

	local mibaoCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._optionalInfo.shopId)

	if mibaoCfg == nil or string.nilorempty(mibaoCfg.content) then
		printError("sr---自选购买装备 OptionalBuyView:onEnter()    为毛商品空的 = ", self._optionalInfo.shopId)
	end

	local isDiscountTime = PayShopController.instance:checkTimeStr(mibaoCfg.discountTime)

	if isDiscountTime then
		if not mibaoCfg.discountGoodsId then
			local payStr = mibaoCfg.originalGoodsId

			if string.find(payStr, "rmb") then
				local payCfg = PayConfig.instance:getPayGoodsCfg(payStr)

				self._buyImaGo:GetComponent("UIImageColorChange"):SetState(2)
				self._buyImaGo:GetComponent("UIImageSpriteChange"):SetState(2)

				if payCfg then
					self._buyTxt.text = tostring(payCfg.payMoney * PayModel.RMB_UNIT)
				end
			else
				local list = string.split(payStr, ":")

				self._buyTxt.text = list[3]

				if checknumber(list[1]) == MatType.Diamond_Consume then
					self._buyImaGo:GetComponent("UIImageColorChange"):SetState(1)
					self._buyImaGo:GetComponent("UIImageSpriteChange"):SetState(1)
				else
					self._buyImaGo:GetComponent("UIImageColorChange"):SetState(0)
					self._buyImaGo:GetComponent("UIImageSpriteChange"):SetState(0)
				end
			end

			local effPath = "fx_ui_lunhuitanbao/fx_ui_lunhuitanbao01.prefab"

			self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

			self.pmEff:setParent(self.mainGO.transform)
			self.pmEff:setLocalPos(0, 0, 0)
			self.pmEff:setScale(1)
		end
	end
end

function OptionalBuyView:_showActivityTimer()
	local actId, typeId = PetEquipModel.instance:getOptionalActivityId()

	if checknumber(actId) <= 0 then
		actId = self._optionalInfo.lastActId
	end

	local actCfg = ActivityDefineConfig.instance:getCfgById(typeId, actId)

	if actCfg == nil or actCfg.endTime == nil then
		self._timeTxt.text = lang("text_equip_desc_1")

		return
	end

	self._timeEnd = GameUtil.string2time(actCfg.endTime)

	if self._timeEnd <= ServerTime.now() then
		self._timeTxt.text = lang("text_equip_desc_1")
	else
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function OptionalBuyView:_calculationSurplusTime()
	local supTime = self._timeEnd - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timeTxt.text = lang("text_equip_desc_1")

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timeTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
end

function OptionalBuyView:_onClickBuyBtn()
	if self._optionalInfo == nil or self._optionalInfo.isBuy then
		TipsFacade.instance:openCommonTips(lang("text_equip_buy"))

		return
	end

	if checknumber(self._timeEnd) <= ServerTime.now() then
		TipsFacade.instance:openCommonTips(lang("text_equip_desc_1"))

		return
	end

	UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, {
		times = 1,
		id = self._optionalInfo.shopId
	})
end

function OptionalBuyView:_onShopItemBuySucRes(msg)
	if msg == nil or msg.buyTimes == nil then
		return
	end

	if msg.buyTimes.id == self._optionalInfo.shopId and (msg.buyTimes.times > 0 or msg.buyTimes.totalBuyTimes > 0) then
		uGuiUtil.setImageGrayStateRecursive(self._buyBtn.gameObject, true)
		uGuiUtil.setTextGrayState(self._buyTxt.gameObject, true)

		self._optionalInfo = PetEquipModel.instance:getOptionalFuncInfo()
	end
end

return OptionalBuyView
