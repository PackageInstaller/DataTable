-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partyprize/view/PartyPrizeView.lua

module("logic.extensions.partyprize.view.PartyPrizeView", package.seeall)

local PartyPrizeView = class("PartyPrizeView", ViewComponent)

function PartyPrizeView:ctor()
	PartyPrizeView.super.ctor(self)

	self._signinCells = nil
	self._welfareCells = nil
	self._specialCell = nil
	self._btnClose = nil
	self._timeTxt = nil
	self._isLock = true
end

function PartyPrizeView:unbindEvents()
	PartyPrizeView.super.unbindEvents(self)

	for i = 1, #self._signinCells do
		GameUtil.rmClickHandler(self._signinCells[i].cell)
	end

	for i = 1, #self._welfareCells do
		GameUtil.rmClickHandler(self._welfareCells[i].btnGift)
		GameUtil.rmClickHandler(self._welfareCells[i].btnJump)
	end

	GameUtil.rmClickHandler(self._specialCell.btnReceive)
	GameUtil.rmClickHandler(self._btnClose)
end

function PartyPrizeView:bindEvents()
	PartyPrizeView.super.bindEvents(self)

	for i = 1, #self._signinCells do
		GameUtil.addClickHandler(self._signinCells[i].cell, GameUtil.handler(self.onClickSignin, self, i))
	end

	for i = 1, #self._welfareCells do
		GameUtil.addClickHandler(self._welfareCells[i].btnGift, GameUtil.handler(self.onClickGift, self, i))
		GameUtil.addClickHandler(self._welfareCells[i].btnJump, GameUtil.handler(self.onClickJump, self, i))
	end

	GameUtil.addClickHandler(self._specialCell.btnReceive, self.onClickReceive, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PartyPrizeView:onClickSignin(i)
	if self._isLock then
		return
	end

	local isEndSignin = PartyPrizeModel.instance:isEndSignin()

	if not isEndSignin and PartyPrizeModel.instance:checkCanGainPrize(i) then
		PartyPrizeController.instance:gainPrize(i)
	else
		local cfg = PartyPrizeConfig.instance:getCheckInCfg(i)

		CommonTipsMgr.instance:openTipsByConfStr(self._signinCells[i].cell, cfg.reward)
	end
end

function PartyPrizeView:onClickJump(i)
	local cfg = PartyPrizeConfig.instance:getDailyPrizeCfg(i)

	if GameUtil.checkIsInTimePeriod(cfg.actStartTime, cfg.actEndTime) then
		GotoMgr.gotoByString(cfg.actKey)
	else
		FloatWordMgr.instance:show(cfg.offlineTip)
	end
end

function PartyPrizeView:onClickGift(i)
	if self._isLock then
		return
	end

	if PartyPrizeModel.instance:checkCanGainDailyPrize(i) then
		PartyPrizeController.instance:gainDailyPrize(i)
	end
end

function PartyPrizeView:onClickReceive()
	if self._isLock then
		return
	end

	if PartyPrizeModel.instance:checkCanGainAccumulate() then
		PartyPrizeController.instance:gainAccumulatePrize()
	elseif PartyPrizeModel.instance:hasGainAccumulate() then
		FloatWordMgr.instance:show("已领取")
	else
		FloatWordMgr.instance:show("达到条件后可领")
	end
end

function PartyPrizeView:buildUI()
	PartyPrizeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._signinCells = {}

	for i = 1, 7 do
		self._signinCells[i] = {}
		self._signinCells[i].cell = self:getGo("signinCells/cell" .. i)
		self._signinCells[i].markHasGain = self:getGo("signinCells/cell" .. i .. "/markHasGain")
		self._signinCells[i].icon = self:getGo("signinCells/cell" .. i .. "/icon")
		self._signinCells[i].effParent = self:getGo("signinCells/cell" .. i .. "/eff")
	end

	self._welfareCells = {}

	for j = 1, 7 do
		self._welfareCells[j] = {}
		self._welfareCells[j].btnJump = self:getBtn("welfareCells/cell" .. j .. "/btnJump")
		self._welfareCells[j].txtTime = goutil.findChildTextComponent(self.mainGO, "welfareCells/cell" .. j .. "/btnJump/txtTime")
		self._welfareCells[j].btnGift = self:getBtn("welfareCells/cell" .. j .. "/btnGift")
		self._welfareCells[j].redPoint = self:getGo("welfareCells/cell" .. j .. "/btnGift/redPoint")
	end

	self._specialCell = {}
	self._specialCell.btnReceive = self:getBtn("specialCell/btnReceive")
	self._specialCell.btnReceiveText = goutil.findChildTextComponent(self.mainGO, "specialCell/btnReceive/Text")
	self._specialCell.receive = self:getGo("specialCell/receive")
	self._specialCell.txtCondition1 = goutil.findChildTextComponent(self.mainGO, "specialCell/txtCondition1")
	self._specialCell.txtCondition2 = goutil.findChildTextComponent(self.mainGO, "specialCell/txtCondition2")
	self._specialCell.receiveCondition1 = self:getGo("specialCell/txtCondition1/reach")
	self._specialCell.receiveCondition2 = self:getGo("specialCell/txtCondition2/reach")
	self._timeTxt = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
	self._markEndSignin = self:getGo("tag")
end

function PartyPrizeView:onExit()
	for i = 1, 7 do
		MaterialMgr:clearIcon(self._signinCells[i].icon)
		self:_clearEff(i)
	end

	removetimer(self._calculationSurplusTime, self)
	PartyPrizeController.instance:unregisterNotify(PartyPrizeController.DATA_CHANGE, self.updatePanel, self)
	GlobalDispatcher:removeListener(ClockMgr.TickDailyRefresh, self._onFiveClockRefresh, self)
	PartyPrizeView.super.onExit(self)
end

function PartyPrizeView:onEnter()
	PartyPrizeView.super.onEnter(self)

	self._isLock = true

	GlobalDispatcher:addListener(ClockMgr.TickDailyRefresh, self._onFiveClockRefresh, self)
	PartyPrizeController.instance:registerNotify(PartyPrizeController.DATA_CHANGE, self.updatePanel, self)
	PartyPrizeController.instance:getInfo()
	self:_calculationSurplusTime()
	settimer(1, self._calculationSurplusTime, self, true)
end

function PartyPrizeView:_onFiveClockRefresh()
	self._isLock = true

	PartyPrizeController.instance:getInfo()
end

function PartyPrizeView:_calculationSurplusTime()
	local timeEnd = GameUtil.string2time(PartyPrizeConfig.instance:getEndTime())

	self.supTime = timeEnd - ServerTime.now()
	self.supTime = self.supTime - 1

	if self.supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timeTxt.text = "活动结束"

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self.supTime)

	self._timeTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
end

function PartyPrizeView:_createEff(id)
	local cell = self._signinCells[id]

	if cell.eff then
		return
	end

	local effPath = "20211126/qiandao/fx_ui_qiandao_lingqu.prefab"

	cell.eff = UIEffectManager.instance:playEffect(self, effPath, cell.effParent, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(cell.effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function PartyPrizeView:_clearEff(id)
	local cell = self._signinCells[id]

	if cell.eff then
		UIEffectManager.instance:stopEffect(cell.eff)

		cell.eff = nil
	end
end

function PartyPrizeView:updatePanel()
	local cfg

	for i = 1, 7 do
		cfg = PartyPrizeConfig.instance:getCheckInCfg(i)

		goutil.setActive(self._signinCells[i].markHasGain, PartyPrizeModel.instance:hasGainPrizeDays(i))
		MaterialMgr.clearIcon(self._signinCells[i].icon)
		MaterialMgr.updateItemByStr(self._signinCells[i].icon, cfg.reward)

		if PartyPrizeModel.instance:checkCanGainPrize(i) then
			self:_createEff(i)
		else
			self:_clearEff(i)
		end
	end

	for j = 1, 7 do
		cfg = PartyPrizeConfig.instance:getDailyPrizeCfg(j)

		local dateStart = GameUtil.string2date(cfg.actStartTime, true)
		local dateEnd = GameUtil.string2date(cfg.actEndTime, true)

		self._welfareCells[j].txtTime.text = string.format("%d.%d-%d.%d", dateStart.month, dateStart.day, dateEnd.month, dateEnd.day)

		goutil.setActive(self._welfareCells[j].redPoint, PartyPrizeModel.instance:checkCanGainDailyPrize(j))
	end

	cfg = PartyPrizeConfig.instance:getCfg()

	local days = PartyPrizeModel.instance:countGainPrizeDays()
	local accumulateDays = cfg.accumulateDays

	self._specialCell.txtCondition1.text = string.format("累计签到%d天：<color=#eb4642>%d/%d</color>", accumulateDays, days, accumulateDays)

	local timeStart = GameUtil.string2date(cfg.accumulateStartTime, true)
	local timeEnd = GameUtil.string2date(cfg.accumulateEndTime, true)

	self._specialCell.txtCondition2.text = string.format("%d.%d %d:%02d-%d.%d %d:%02d登录", timeStart.month, timeStart.day, timeStart.hour, timeStart.min, timeEnd.month, timeEnd.day, timeEnd.hour, timeEnd.min)

	GameUtil.setBtnState(self._specialCell.btnReceive, self._specialCell.btnReceiveText, not PartyPrizeModel.instance:checkCanGainAccumulate())
	goutil.setActive(self._specialCell.receive, PartyPrizeModel.instance:hasGainAccumulate())
	goutil.setActive(self._specialCell.receiveCondition1, PartyPrizeModel.instance:checkCanGainAccumulateCondition())
	goutil.setActive(self._specialCell.receiveCondition2, PartyPrizeModel.instance:checkCanGainAccumulateNow())
	goutil.setActive(self._markEndSignin, PartyPrizeModel.instance:isEndSignin())

	self._isLock = false
end

return PartyPrizeView
