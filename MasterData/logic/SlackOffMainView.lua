-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/view/SlackOffMainView.lua

module("logic.extensions.SlackOff.view.SlackOffMainView", package.seeall)

local SlackOffMainView = class("SlackOffMainView", ViewComponent)

function SlackOffMainView:ctor()
	SlackOffMainView.super.ctor(self)
end

function SlackOffMainView:buildUI()
	SlackOffMainView.super.buildUI(self)

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

function SlackOffMainView:bindEvents()
	SlackOffMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function SlackOffMainView:unbindEvents()
	SlackOffMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
end

function SlackOffMainView:onExit()
	SlackOffMainView.super.onExit(self)
	self._scrollerList:dispose()
end

function SlackOffMainView:onEnter()
	SlackOffMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SlackOffGameInfoRes, self._refresh, self)
	self:_initActivityId()
	self:_initActivityTime()
	self:_getViewConfigs()
	self:_loadStudents()

	self._effectMap = {}
	self._prizeBtnMap = {}

	SlackOffGameAgent.instance:sendPM_SlackOffGameInfoReq(self._activityId)
end

function SlackOffMainView:_initActivityId()
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.SlackOffGame)

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end
end

function SlackOffMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function SlackOffMainView:_getViewConfigs()
	self._activityCfg = SlackOffGameConfig.instance:getActivityCfgByActId(self._activityId)
	self._progPrzCfg = SlackOffGameConfig.instance:getProgressPrizeCfgByActId(self._activityId)
	self._studentCfgs = SlackOffGameConfig.instance:getStudentCfgsByActId(self._activityId)
end

function SlackOffMainView:_loadStudents()
	if not self._students or #self._students < #self._studentCfgs then
		self._students = {}

		for i, v in ipairs(self._studentCfgs) do
			local student = {}

			student.node = self:getGo("students/student_" .. i)
			student.txtProg = goutil.findChildTextComponent(student.node, "progress/txt")
			student.tagGo = goutil.findChild(student.node, "tag")
			student.txtProg.text = string.format("学习进度:%d/<color=#ab1010>%d</color>", 0, v.progress)

			goutil.setActive(student.tagGo, false)
			table.insert(self._students, student)
		end
	end
end

function SlackOffMainView:_refresh()
	self._info = SlackOffGameModel.instance:getActivityInfo(self._activityId)

	if not self._info then
		Debug.logError("SlackOffMainView:_refresh, self._info is nil")

		return
	end

	if not self._info.todayTimes then
		local todayTimes = 0
		local dailyGameTimes = self._activityCfg.dailyTimes

		self._canPlay = todayTimes < dailyGameTimes
		self._txtPlayTimes.text = string.format("今日剩余次数：%d/%d", dailyGameTimes - todayTimes, dailyGameTimes)

		goutil.setActive(self._rpBtnStart, self._canPlay)

		self._prog = 0

		if self._info.students then
			for i, v in ipairs(self._info.students) do
				self._prog = self._prog + v.progress
			end
		end

		SlackOffGameController.instance:setSliderValue(self._progBar, self._progText, self._progPrzCfg, self._prog)

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

			self:_refreshStudents()
			self._scrollerList:reloadData(self._progPrzCfg)
			self._scrollerList:MoveCellToCenter(self._progStep - 1)
		end
	end
end

function SlackOffMainView:_refreshStudents()
	if not self._info.students then
		for i, v in ipairs(self._studentCfgs) do
			local student = self._students[i]

			if self._info.students and self._info.students[i] then
				if not self._info.students[i].progress then
					local curProg = 0

					student.txtProg.text = string.format("学习进度:%d/%d", curProg, v.progress)
				end
			end
		end
	end
end

function SlackOffMainView:_updateCell(view, cell, data)
	self:_clearCell(cell)

	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local rp = goutil.findChild(cell, "redpoint")
	local got = goutil.findChild(cell, "got")
	local progress = goutil.findChildTextComponent(cell, "progress")
	local proxy = MaterialMgr.setCellByCfg(data.prize, item)

	if not self._info.gainedPrizeIds then
		local isGot = table.keyof(self._info.gainedPrizeIds, data.prizeId) or false
		local canGet = not isGot and data.progress <= self._prog

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

function SlackOffMainView:_clearCell(cell)
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

function SlackOffMainView:_loadEffect(root, rectTrans)
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

function SlackOffMainView:_unloadEffect(effect)
	if effect then
		UIEffectManager.instance:stopEffect(effect)

		effect = nil
	end
end

function SlackOffMainView:_onClickBtnTip()
	local cfg = SlackOffGameConfig.instance:getActivityCfgByActId(self._activityId)

	if cfg then
		local ruleInfos = SlackOffGameConfig.instance:getImgRuleInfosByKey(cfg.ruleKey or "")

		if ruleInfos then
			UIStateManager.instance:push(ViewName.SlackOffGameRuleView, ruleInfos, "游戏规则")
		end
	end
end

function SlackOffMainView:_onClickBtnPrize(prizeId)
	print("[YuTestPrint] =====>\t 领取奖励 id = ", prizeId)
	SlackOffGameAgent.instance:sendPM_SlackOffGameGainPrizeReq(self._activityId, prizeId)
end

function SlackOffMainView:_onClickBtnStart()
	if not self._canPlay then
		FloatWordMgr.instance:show("已达今日最大游玩次数")

		return
	end

	UIStateManager.instance:push(ViewName.SlackOffGameView, self._activityId)
end

return SlackOffMainView
