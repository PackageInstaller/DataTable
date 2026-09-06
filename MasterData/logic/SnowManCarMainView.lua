-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/snowmancar/view/SnowManCarMainView.lua

module("logic.extensions.snowmancar.view.SnowManCarMainView", package.seeall)

local SnowManCarMainView = class("SnowManCarMainView", ViewComponent)

function SnowManCarMainView:ctor()
	SnowManCarMainView.super.ctor(self)
end

function SnowManCarMainView:buildUI()
	SnowManCarMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnStart = self:getGo("btnStart")
	self._rpBtnStart = self:getGo("btnStart/redpoint")
	self._txtTime = self:getTxt("time/txt")
	self._txtPlayTimes = self:getTxt("playTimes/txt")
	self._progBar = self:getGo("progress/tableview/viewport/content/slider"):GetComponent("Slider")
	self._progText = self:getTxt("progress/total/txt")
	self._tableview = self:getGo("progress/tableview")
	self._tablecell = self:getGo("progress/tableview/tablecell")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._rectTrans = self._tableview:GetComponent(typeof(UnityEngine.RectTransform))
end

function SnowManCarMainView:bindEvents()
	SnowManCarMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function SnowManCarMainView:unbindEvents()
	SnowManCarMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
end

function SnowManCarMainView:onExit()
	SnowManCarMainView.super.onExit(self)
	self._scrollerList:dispose()
end

function SnowManCarMainView:onEnter()
	SnowManCarMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SnowmanCarInfoRes, self._refresh, self)
	self:_initActivityId()
	self:_initActivityTime()
	self:_getViewConfigs()

	self._effectMap = {}
	self._prizeBtnMap = {}

	SnowManCarAgent.instance:sendPM_SnowmanCarInfoReq(self._activityId)
end

function SnowManCarMainView:_initActivityId()
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.SnowManCar)

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end
end

function SnowManCarMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function SnowManCarMainView:_getViewConfigs()
	self._activityCfg = SnowManCarConfig.instance:getActivityCfgByActId(self._activityId)
	self._progPrzCfg = SnowManCarConfig.instance:getProgressPrizeCfgByActId(self._activityId)
end

function SnowManCarMainView:_refresh()
	self._info = SnowManCarModel.instance:getActivityInfo(self._activityId)

	if not self._info then
		Debug.logError("SnowManCarMainView:_refresh, self._info is nil")

		return
	end

	local todayTimes = self._info.todayTimes
	local dailyGameTimes = self._activityCfg.dailyGameTimes

	self._canPlay = todayTimes < dailyGameTimes
	self._txtPlayTimes.text = string.format("今日剩余次数：%d/%d", dailyGameTimes - todayTimes, dailyGameTimes)

	goutil.setActive(self._rpBtnStart, self._canPlay)
	SnowManCarController.instance:setSliderValue(self._progBar, self._progText, self._progPrzCfg, self._info.score)

	self._progStep = 1

	if not self._info.gainedPrizeIds then
		local gainedAllCanGainPrz = true

		for i, v in ipairs(self._info.gainedPrizeIds) do
			if i < v then
				gainedAllCanGainPrz = false
				self._progStep = i

				break
			end
		end

		if gainedAllCanGainPrz then
			self._progStep = #self._info.gainedPrizeIds + 1 or self._progStep
		end

		self._scrollerList:reloadData(self._progPrzCfg)
		self._scrollerList:MoveCellToCenter(self._progStep - 1)
	end
end

function SnowManCarMainView:_updateCell(view, cell, data)
	self:_clearCell(cell)

	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local rp = goutil.findChild(cell, "redpoint")
	local got = goutil.findChild(cell, "got")
	local progress = goutil.findChildTextComponent(cell, "progress")
	local proxy = MaterialMgr.setCellByCfg(data.prize, item)

	if not self._info.gainedPrizeIds then
		local isGot = table.keyof(self._info.gainedPrizeIds, data.prizeId) or false
		local canGet = not isGot and data.progress <= self._info.score

		self._prizeBtnMap[cell] = self._prizeBtnMap[cell] or goutil.findChild(cell, "btn")

		local btn = self._prizeBtnMap[cell]

		if canGet then
			self._effectMap[cell] = self:_loadEffect(effect, self._rectTrans)

			GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickBtnPrize, self, data.prizeId), self)
		end

		progress.text = tostring(data.progress)

		goutil.setActive(got, isGot)
		goutil.setActive(rp, canGet)
		goutil.setActive(btn, canGet)
	end
end

function SnowManCarMainView:_clearCell(cell)
	local got = goutil.findChild(cell, "got")
	local item = goutil.findChild(cell, "item")
	local rp = goutil.findChild(cell, "redpoint")

	if self._effectMap and self._effectMap[cell] then
		self:_unloadEffect(self._effectMap[cell])
	end

	GameUtil.rmClickHandler(self._prizeBtnMap[cell])
	goutil.setActive(rp, false)
	goutil.setActive(got, false)
	goutil.setActive(self._prizeBtnMap[cell], false)
	MaterialMgr.resetAll(item)
end

function SnowManCarMainView:_loadEffect(root, rectTrans)
	local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local effect

	effect = UIEffectManager.instance:playEffect(self, effectPath, root.transform, 0, 0, true, false, nil, function()
		if rectTrans then
			effect:setClipping(rectTrans)
		end
	end)

	effect:setParent(root.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	return effect
end

function SnowManCarMainView:_unloadEffect(effect)
	if effect then
		UIEffectManager.instance:stopEffect(effect)

		effect = nil
	end
end

function SnowManCarMainView:_onClickBtnTip()
	if not self._activityCfg.ruleKeyMain then
		local ruleKey = "snowmancar_rule"
		local ruleInfos = SnowManCarConfig.instance:getImgRuleInfosByKey(ruleKey)

		TipsFacade.instance:openImageRuleView(ruleInfos, "游戏规则")
	end
end

function SnowManCarMainView:_onClickBtnPrize(prizeId)
	print("[YuTestPrint] =====>\t 领取奖励 id = ", prizeId)
	SnowManCarAgent.instance:sendPM_SnowmanCarGainPrizeReq(self._activityId, prizeId)
end

function SnowManCarMainView:_onClickBtnStart()
	if not self._canPlay then
		FloatWordMgr.instance:show("已达今日最大游玩次数")

		return
	end

	UIStateManager.instance:push(ViewName.SnowManCarGameView, self._activityId)
end

return SnowManCarMainView
