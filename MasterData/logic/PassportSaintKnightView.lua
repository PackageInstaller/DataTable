-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/saintknight/PassportSaintKnightView.lua

module("logic.extensions.passport.view.saintknight.PassportSaintKnightView", package.seeall)

local PassportSaintKnightView = class("PassportSaintKnightView", PassportwpView)

function PassportSaintKnightView:bindEvents()
	PassportSaintKnightView.super.bindEvents(self)
	GameUtil.addClickHandler(self._dayGift, self._onClickDayGift, self)
end

function PassportSaintKnightView:unbindEvents()
	PassportSaintKnightView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._dayGift)
end

function PassportSaintKnightView:buildUI()
	PassportSaintKnightView.super.buildUI(self)
	GameUtil.SetActive(self._extraPart, false)
	GameUtil.SetActive(self._goBuyPassport, false)

	self._dayGiftRect = self:getGo("dayGift")
	self._dayGift = self:getBtn("dayGift")
	self._item = self:getGo("dayGift/item")
	self._receieve = self:getGo("dayGift/receieve")
end

function PassportSaintKnightView:onEnter()
	self:_resetview()

	self._openparam = 7
	self._ableToLClick = true
	self._canGetRewardIndex = 0
	self._buyView = ViewName.PassportSaintKnightBuyView

	local effResPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	if not GameUtil.isEmptyString(effResPath) then
		self._playEff = UIEffectManager.instance:playEffect(self, effResPath, nil, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self.mainGO.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
	end

	self.proxy = MaterialMgr.setCellByCfg(self:_getShopItemMatStr(), self._item)

	self.proxy.binder:setAutoTips(false)
	self.proxy:setCallBack(function()
		self:_onClickDayGift()
	end)
	GlobalDispatcher:addListener(GlobalNotify.PassportExtraPrizeUpdate, self._refreshExtraPart, self)
	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._refreshUI, self)
	GlobalDispatcher:addListener(PayShopController.BuyItemRes, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function PassportSaintKnightView:onExit()
	PassportSaintKnightView.super.onExit(self)
	MaterialMgr.resetAll(self._item)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	GlobalDispatcher:removeListener(PayShopController.BuyItemRes, self._sendInfoReq, self)
end

function PassportSaintKnightView:_sendInfoReq()
	PassportController.instance:sendGetInfoReq(self._openparam, self._refreshUI, self)
end

function PassportSaintKnightView:_refreshUI()
	PassportSaintKnightView.super._refreshUI(self)
	self:_refreshDayGiftState()
end

function PassportSaintKnightView:_onClickBtnGoTo()
	GotoMgr.gotoByString("func#5")
end

function PassportSaintKnightView:_onClickBtnBuyPassport()
	if self._curData.hasPay then
		GameUtil.SetActive(self._goBuyPassport, false)
		GameUtil.SetActive(self._goLock, false)
		uGuiUtil.setImageGrayStateRecursive(self._goIconBottom, true)

		return
	end

	local data1, data2, data3, num = PassportModel.instance:getCurDataList(nil, self._curData.funcId)

	if GameUtil.isEmptyString(data1[1]) then
		UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 1, self._curData.sldValue, self:_getPassportbuyViewExtraParam())
	else
		UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 2, self._curData.sldValue, self:_getPassportbuyViewExtraParam())
	end
end

function PassportSaintKnightView:_onClickBtnBuyProgress()
	SurveyController.instance:reportBehavior(201100)
	PassportSaintKnightView.super._onClickBtnBuyProgress(self)
end

function PassportSaintKnightView:_onClickBtnGoTo()
	SurveyController.instance:reportBehavior(201101)
	PassportSaintKnightView.super._onClickBtnGoTo(self)
end

function PassportSaintKnightView:_onClickDayGift()
	PayShopController.instance:buyShopItem(self:_getShopItemGoodId(), 1, -1)
end

function PassportSaintKnightView:_getShopItemGoodId()
	return 440014
end

function PassportSaintKnightView:_getShopItemMatStr()
	return "10:177006"
end

function PassportSaintKnightView:_refreshDayGiftState()
	local isCanGet = PayShopModel.instance:getPayShopGoodsCanBuyById(self:_getShopItemGoodId())

	GameUtil.SetActive(self._receieve, not isCanGet)
	UIEffectManager.instance:stopEffect(self._pmEff)

	if self.proxy then
		self.proxy.binder:setAutoTips(not isCanGet)
	end

	if isCanGet then
		local effParent = self._item
		local pathName = "fx_ui_juqingfuben/fx_ui_juqingfuben02"

		if effParent and not string.nilorempty(pathName) then
			local path = pathName .. ".prefab"

			local function finishHandler(handlerTarget, eff)
				return
			end

			local function loadedHandler(handlerTarget, eff)
				eff:setClipping(self._dayGiftRect:GetComponent(goutil.Type_RectTransform))
				eff:setParent(effParent.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1, 1, 1)

				eff.hideEffWhileNotOnTop = true
			end

			local handlerTarget

			self._pmEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
		end
	end
end

return PassportSaintKnightView
