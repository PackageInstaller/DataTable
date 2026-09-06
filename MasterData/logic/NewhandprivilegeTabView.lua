-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandprivilegeTabView.lua

module("logic.extensions.newhandwelfare.view.NewhandprivilegeTabView", package.seeall)

local NewhandprivilegeTabView = class("NewhandprivilegeTabView", ViewComponent)

function NewhandprivilegeTabView:bindEvents()
	NewhandprivilegeTabView.super.bindEvents(self)
	self.btnGainPrize:AddClickListener(self.onClickBtnGainPrize, self)
	self.btnTip:AddClickListener(function()
		ViewMgr.instance:open(ViewName.RulesView, "goldendiamondcard")
	end, self)
	self._btnClose:AddClickListener(self.close, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickbtnJump, self)
end

function NewhandprivilegeTabView:unbindEvents()
	NewhandprivilegeTabView.super.unbindEvents(self)
	self.btnShowAll:RemoveClickListener()
	self.btnGainPrize:RemoveClickListener()
	self.btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()

	for i, item in ipairs(self._privilegeItems or {}) do
		if item and item.itemGo then
			Framework.ButtonAdapter.Get(item.itemGo):RemoveClickListener()
		end
	end

	GameUtil.rmClickHandler(self._btnJump)
end

function NewhandprivilegeTabView:onExit()
	NewhandprivilegeTabView.super.onExit(self)
	removetimer(self._onTicking, self)
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

function NewhandprivilegeTabView:buildUI()
	NewhandprivilegeTabView.super.buildUI(self)

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
	self._imgActive = self:getGo("card/imgActive")
	self._btnJump = self:getGo("card/btnJump/btn")
	self._btnJumpGo = self:getGo("card/btnJump")
	self._txtEndBtnJUmp = self:getGo("card/btnJump/txtEnd")
	self._txtLeftTime = self:getTxt("leftTime/txt")
end

function NewhandprivilegeTabView:onEnter()
	NewhandprivilegeTabView.super.onEnter(self)

	self._params = self:getFirstParam()
	self._actId = checknumber(self._params and self._params.actId)
	self._periodId = NewhandwelfareModel.instance:getPeriodId()

	if NewhandwelfareModel.instance:checkPriviligeWholeLifeDot() then
		NewhandwelfareModel.instance:recordPriviligeWholeLifeDot()
		GlobalDispatcher:dispatch(NewhandwelfareenterView.CheckRedDot)
	end

	self._isReceiveGoldCard = false
	self._goldCardSupCount = 0

	self.addGEvent(self, GlobalNotify.UpdateGoldenDiamondCardInfo, self.refreshView, self)
	self.addGEvent(self, NewhandwelfareController.NewHandWelfareGetInfoRes, self._updateTime, self)
	self:refreshView()
	RedPointController.instance:regRedPoint(self.redPoint, RedPointModel.ID_GOLDENDIAMONDCARD)

	self.effResPath = "fx_ui_mibaoshangcheng/fx_ui_mibaoshangchang_jinzuantequan.prefab"
	self._playEff = UIEffectManager.instance:playEffect(self, self.effResPath, nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function NewhandprivilegeTabView:refreshView()
	self:_updataShowBuyInfo()
	self:_updateTime()

	local isUser = GoldenDiamondCardModel.instance.isUser

	GameUtil.SetActive(self._imgActive, isUser)
	GameUtil.SetActive(self._btnJumpGo, not isUser)

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
end

function NewhandprivilegeTabView:_updataShowBuyInfo()
	local isUser = GoldenDiamondCardModel.instance.isUser

	GameUtil.SetActive(self.timeShow, isUser)

	if isUser then
		local leftTime = math.ceil((GoldenDiamondCardModel.instance.endTime / 1000 - ServerTime.now()) / 86400)

		self.txtDay.text = langPara("剩余有效期:%s天", leftTime)
	end
end

function NewhandprivilegeTabView:_setPrivilegeItems()
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

function NewhandprivilegeTabView:onClickBtnGainPrize()
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

function NewhandprivilegeTabView:_onClickbtnGet()
	if self._actId and self._actId > 0 then
		local curGainFreeGolgenCard = FirstAnnualWelfareModel.instance:getGainFreeGoldenCard()

		if curGainFreeGolgenCard then
			FloatWordMgr.instance:show("特权已领取，体验中")
		else
			FirstAnnualWelfareController.instance:onSendFirstAnnualWelfareGainFreeGoldenCardReq(self._actId)
		end
	end
end

function NewhandprivilegeTabView:_onClickbtnJump()
	GotoMgr.gotoByString("mibao#GoldenDiamondCard")
end

function NewhandprivilegeTabView:_updateTime()
	self._endTime = NewhandwelfareModel.instance:getNewHandPlayerEndTime()

	settimer(1, self._onTicking, self, true)
	self:_onTicking()
end

function NewhandprivilegeTabView:_onTicking()
	local leftTime = Mathf.Max(self._endTime - ServerTime.now(), 0)

	self._txtLeftTime.text = GameUtil.FormatTimeWordsNoSec(leftTime)

	if leftTime <= 0 then
		leftTime = 0

		removetimer(self._onTicking, self)
	end
end

return NewhandprivilegeTabView
