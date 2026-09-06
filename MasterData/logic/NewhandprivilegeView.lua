-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandprivilegeView.lua

module("logic.extensions.newhandwelfare.view.NewhandprivilegeView", package.seeall)

local NewhandprivilegeView = class("NewhandprivilegeView", ViewComponent)

function NewhandprivilegeView:bindEvents()
	NewhandprivilegeView.super.bindEvents(self)
	self.btnBuy:AddClickListener(function()
		if self._params and self._params.isReceive then
			FloatWordMgr.instance:show("特权已领取，体验中")
		else
			RegressAgent.instance:sendPM_RegressGainGoldenDiamondCardReq()
		end
	end, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickbtnGet, self)
	self.btnShowAll:AddClickListener(function()
		UIStateManager.instance:push(ViewName.GoldendiamondallView)
	end, self)
	self.btnGainPrize:AddClickListener(self.onClickBtnGainPrize, self)
	self.btnTip:AddClickListener(function()
		ViewMgr.instance:open(ViewName.RulesView, "goldendiamondcard")
	end, self)
	self._btnClose:AddClickListener(self.close, self)
end

function NewhandprivilegeView:unbindEvents()
	NewhandprivilegeView.super.unbindEvents(self)
	self.btnBuy:RemoveClickListener()
	self.btnShowAll:RemoveClickListener()
	self.btnGainPrize:RemoveClickListener()
	self.btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnGet)

	for i, item in ipairs(self._privilegeItems or {}) do
		if item and item.itemGo then
			Framework.ButtonAdapter.Get(item.itemGo):RemoveClickListener()
		end
	end
end

function NewhandprivilegeView:onExit()
	NewhandprivilegeView.super.onExit(self)

	if self._source == NewhandwelfareEnum.PrivilegeViewSource_Regress then
		GlobalDispatcher:removeListener(GlobalNotify.UpdataBackGoldCard, self._updataBackGoldCard, self)
	end

	GlobalDispatcher:removeListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self.refreshView, self)
	RedPointController.instance:unregRedPoint(self.redPoint)

	for _, go in pairs(self._item or {}) do
		MaterialMgr.resetAll(go)
	end

	if self._playEff then
		UIEffectManager.instance:stopEffect(self._playEff)

		self._playEff = nil
	end

	for _, effGo in pairs(self._playEffs or {}) do
		UIEffectManager.instance:stopEffect(effGo)
	end

	self._playEffs = nil
end

function NewhandprivilegeView:buildUI()
	NewhandprivilegeView.super.buildUI(self)

	self.btnBuy = self:getBtn("card/buyBtn")
	self.txtPrice = self:getTxt("card/buyBtn/text")
	self.btnGainPrize = self:getBtn("card/btnGainPrize/btn")
	self.btnShowAll = self:getBtn("card/btnShowAll")
	self.btnTip = self:getBtn("card/btnTip")
	self.timeShow = self:getGo("card/remainTime")
	self.txtDay = goutil.findChildTextComponent(self.timeShow, "txt")
	self._item = {}

	for i = 1, 3 do
		self._item[i] = self:getGo("card/btnGainPrize/item" .. i)
	end

	self.markGain = self:getGo("card/btnGainPrize/markGain")
	self.redPoint = self:getGo("card/btnGainPrize/redpoint")
	self._btnClose = self:getBtn("btnClose")

	local root = self:getGo("privilege")

	self._privilegeItems = {}

	for i = 1, 9 do
		local cell = goutil.findChild(root, "btncell" .. i)

		self._privilegeItems[i] = {
			itemGo = cell,
			goIcon = goutil.findChild(cell, "icon"),
			goLock = goutil.findChild(cell, "lock"),
			txtDesc = goutil.findChildTextComponent(cell, "txtDesc"),
			txtName = goutil.findChildTextComponent(cell, "txtName")
		}
	end

	self._imgNew = self:getGo("imgNew")
	self._tipCon1 = goutil.findChild(self._imgNew, "con1")
	self._tipCon2 = goutil.findChild(self._imgNew, "con2")
	self._btnGet = self:getGo("card/buyGet")
	self._txtbtnGet = goutil.findChildTextComponent(self._btnGet, "text")
end

function NewhandprivilegeView:onEnter()
	NewhandprivilegeView.super.onEnter(self)

	self._periodId = NewhandwelfareModel.instance:getPeriodId()

	if NewhandwelfareModel.instance:checkPriviligeWholeLifeDot() then
		NewhandwelfareModel.instance:recordPriviligeWholeLifeDot()
		GlobalDispatcher:dispatch(NewhandwelfareenterView.CheckRedDot)
	end

	self._params = self:getFirstParam() or {}
	self._actId = checknumber(self._params and self._params.actId)
	self._source = self._params.source

	if string.nilorempty(self._source) then
		self._source = self._actId > 0 and NewhandwelfareEnum.PrivilegeViewSource_Annual or self._params.isReceive ~= nil and NewhandwelfareEnum.PrivilegeViewSource_Regress or NewhandwelfareEnum.PrivilegeViewSource_NewHand
	end

	if self._source == NewhandwelfareEnum.PrivilegeViewSource_Regress then
		GlobalDispatcher:addListener(GlobalNotify.UpdataBackGoldCard, self._updataBackGoldCard, self)
	end

	self:refreshView()
	GlobalDispatcher:addListener(GlobalNotify.UpdateGoldenDiamondCardInfo, self.refreshView, self)
	RedPointController.instance:regRedPoint(self.redPoint, RedPointModel.ID_GOLDENDIAMONDCARD)

	self.effResPath = "fx_ui_mibaoshangcheng/fx_ui_mibaoshangchang_jinzuantequan.prefab"
	self._playEff = UIEffectManager.instance:playEffect(self, self.effResPath, nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function NewhandprivilegeView:refreshView()
	self:_updataShowBuyInfo()

	local prizes = GoldenDiamondCardConfig.instance:getCommonValue("DAILY_PRIZE")
	local prizeStrs = MaterialMgr.changeItemStrArr(prizes)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._item[i])

		if GameUtil.isEmptyString(prizeStrs[i]) then
			goutil.setActive(self._item[i], false)
		else
			goutil.setActive(self._item[i], true)
			MaterialMgr.setCellByCfg(prizeStrs[i], self._item[i])
		end
	end

	local isGinPrize = GoldenDiamondCardModel.instance.prizeNum == 0 and GoldenDiamondCardModel.instance.isUser

	GameUtil.SetActive(self.markGain, isGinPrize)

	for _, effGo in pairs(self._playEffs or {}) do
		if effGo then
			UIEffectManager.instance:stopEffect(effGo)
		end
	end

	self._playEffs = {}

	if isGinPrize then
		for i = 1, 3 do
			self._playEffs[i] = UIEffectManager.instance:playEffect(self, "fx_ui_tequan/fx_ui_tequan_kuang.prefab", self._item[i], 0, 0, true, false, nil, function(target, eff)
				eff.effGo.transform:SetParent(self._item[i].transform)
				GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
				GameUtil.setLocalScale(eff.effGo.transform, 1.5, 1.5, 1)

				eff.hideEffWhileNotOnTop = true
			end)
		end
	end

	self:_setPrivilegeItems()

	if self._actId and self._actId > 0 then
		goutil.setActive(self._btnGet, true)
		goutil.setActive(self._bubbleGo, false)
		goutil.setActive(self.btnBuy.gameObject, false)
		goutil.setActive(self._tipCon1, false)
		goutil.setActive(self._tipCon2, true)

		local curGainFreeGolgenCard = FirstAnnualWelfareModel.instance:getGainFreeGoldenCard()

		self._txtbtnGet.text = curGainFreeGolgenCard and lang("体验中") or lang("领取")
	else
		goutil.setActive(self._tipCon2, false)
		goutil.setActive(self._tipCon1, true)
		goutil.setActive(self._btnGet, false)
		goutil.setActive(self._bubbleGo, isOnTrial or GoldenDiamondCardModel.instance.ableToRenew)
		goutil.setActive(self.btnBuy.gameObject, true)
	end
end

function NewhandprivilegeView:_updataShowBuyInfo()
	self._params = self._params or {}

	if self._source ~= NewhandwelfareEnum.PrivilegeViewSource_Regress then
		self._params.isReceive = FirstAnnualWelfareModel.instance:getGainFreeGoldenCard()
	end

	self._params.isReceive = self._params.isReceive == true
	self._params.supCount = checknumber(self._params.supCount)
	self.txtPrice.text = self._params and not self._params.isReceive and "可领取" or "体验中"

	if self._params == nil or checknumber(self._params.supCount) <= 0 then
		GameUtil.SetActive(self.timeShow, false)
	else
		GameUtil.SetActive(self.timeShow, true)

		self.txtDay.text = langPara("剩余有效期:%s天", self._params.supCount)
	end
end

function NewhandprivilegeView:_setPrivilegeItems()
	for i, item in ipairs(self._privilegeItems) do
		Framework.ButtonAdapter.Get(item.itemGo):RemoveClickListener()

		local cfg = NewhandwelfareConfig.instance:getGoldenDiamondCfg(i)
		local isUnlock = cfg.funcId <= 0 or FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)

		GameUtil.SetActive(item.goLock, false)
		Framework.ButtonAdapter.Get(item.itemGo):AddClickListener(function()
			if not isUnlock then
				FloatWordMgr.instance:show(FuncOpenModel.instance:getFuncLockDescription(cfg.funcId))

				return
			end

			if not string.nilorempty(cfg.jumpTo) then
				GotoMgr.gotoByString(cfg.jumpTo)

				if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
					self:close()
				end
			end
		end)
	end
end

function NewhandprivilegeView:_updataBackGoldCard(msg, isInfo)
	if isInfo or self._source ~= NewhandwelfareEnum.PrivilegeViewSource_Regress then
		return
	end

	self._params = self._params or {}
	self._params.isReceive = true
	self._params.supCount = msg and checknumber(msg.goldenDiamondCardDays) or self._params.supCount

	self:_updataShowBuyInfo()
end

function NewhandprivilegeView:onClickBtnGainPrize()
	if GoldenDiamondCardModel.instance.isUser and GoldenDiamondCardModel.instance.prizeNum == 1 then
		GoldenDiamondCardAgent.instance:sendPM_GoldenDiamondCardGainDailyPrizeReq()

		return
	end

	if GoldenDiamondCardModel.instance.prizeNum == 0 and GoldenDiamondCardModel.instance.isUser then
		FloatWordMgr.instance:show("今日礼包已领取")

		return
	end

	UIStateManager.instance:push(ViewName.GoldendiamondallView)
end

function NewhandprivilegeView:_onClickbtnGet()
	if self._actId and self._actId > 0 then
		local curGainFreeGolgenCard = FirstAnnualWelfareModel.instance:getGainFreeGoldenCard()

		if curGainFreeGolgenCard then
			FloatWordMgr.instance:show("特权已领取，体验中")
		else
			FirstAnnualWelfareController.instance:onSendFirstAnnualWelfareGainFreeGoldenCardReq(self._actId)
		end
	end
end

return NewhandprivilegeView
