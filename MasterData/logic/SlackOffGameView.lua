-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/view/SlackOffGameView.lua

module("logic.extensions.slackoffgame.view.SlackOffGameView", package.seeall)

local SlackOffGameView = class("SlackOffGameView", ViewComponent)

function SlackOffGameView:ctor()
	SlackOffGameView.super.ctor(self)
end

function SlackOffGameView:buildUI()
	SlackOffGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtIntro = self:getGo("intro/txt"):GetComponent("Text")
	self._countdownTime = self:getTxt("countdown/txt")
end

function SlackOffGameView:bindEvents()
	SlackOffGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function SlackOffGameView:unbindEvents()
	SlackOffGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SlackOffGameView:onExit()
	SlackOffGameView.super.onExit(self)

	if self._teacher then
		self._teacher:onExit()
	end

	if self._students then
		for _, student in ipairs(self._students) do
			student:onExit()
		end
	end

	removetimer(self._updateGameTime, self)
	removetimer(self._startGameCountDown, self)
end

function SlackOffGameView:onEnter()
	SlackOffGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SlackOffGameStartRes, self._openCountDownMask, self)
	self.addGEvent(self, GlobalNotify.SlackOffGameEndRes, self.close, self)

	self._activityId = self:getFirstParam() or 442001

	print("[YuTestPrint] =====>\t self._activityId = ", self._activityId)
	self:_loadGame()

	local key = string.format("SlackOffGameViewIsFirstTimeOpen_%d_test4", self._activityId)

	local function firstTimeCallback()
		self:_showRuleView()
	end

	GameUtil.doCallbackWhenFirst(key, firstTimeCallback, function()
		self:_sendGameStartReq()
	end)
end

function SlackOffGameView:_loadGame()
	self:_getGameConfig()
	self:_initStudents()
	self:_initTeacher()

	self._score = 0

	if self._activityCfg then
		self._gameTime = self._activityCfg.gameSec or 300
	end

	self._countdownTime.text = self._gameTime .. "秒"
	self._txtIntro.text = SlackOffGameConfig.instance:getGameIntroContent(self._activityId)
end

function SlackOffGameView:_getGameConfig()
	self._activityCfg = SlackOffGameConfig.instance:getActivityCfgByActId(self._activityId)
	self._studentCfgs = SlackOffGameConfig.instance:getStudentCfgsByActId(self._activityId)
end

function SlackOffGameView:_initStudents()
	self._students = {}

	if self._studentCfgs then
		for i, cfg in ipairs(self._studentCfgs) do
			local node = self:getGo("students/student_" .. i)
			local student = GameUtil.AddLuaOnce(node, SlackOffGameStudentMo)

			student:onEnter(cfg, self._activityCfg.targets)
			table.insert(self._students, student)
		end
	end
end

function SlackOffGameView:_initTeacher()
	local go = self:getGo("teacher")

	self._teacher = GameUtil.AddLuaOnce(go, SlackOffGameTeacherMo)

	if self._activityCfg then
		if not self._activityCfg.intervalTime then
			local intervalTime = {
				6,
				8
			}

			if self._activityCfg then
				if not self._activityCfg.duration then
					local duration = {
						2,
						3
					}

					if self._activityCfg then
						if not self._activityCfg.scaleTimes then
							local scaleTimes = 0.2

							if self._activityCfg then
								if not self._activityCfg.scaleVec3 then
									local scaleVec3 = {
										1.3,
										1.3,
										1
									}

									if self._activityCfg then
										if not self._activityCfg.shakeVec3 then
											local shakeVec3 = {
												5,
												0,
												0
											}

											self._teacher:onEnter(intervalTime, duration, scaleTimes, scaleVec3, shakeVec3)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function SlackOffGameView:_openCountDownMask()
	UIStateManager.instance:open(ViewName.SuppressGameStartMask, self._readyStartGame, self)
end

function SlackOffGameView:_readyStartGame()
	self._countDown = 2

	GameUtil.SetActive(self._gameMask, true)
	GameUtil.SetActive(self._startMask, false)
	removetimer(self._startGameCountDown, self)
	settimer(1, self._startGameCountDown, self, true)
end

function SlackOffGameView:_startGameCountDown()
	if self._countDown <= 1 then
		removetimer(self._startGameCountDown, self)
		self:_startGame()

		return
	end

	self._countDown = self._countDown - 1
end

function SlackOffGameView:_startGame()
	print("[YuTestPrint] =====>\t 【摸鱼模拟器】游戏开始")

	self._curGameTime = self._gameTime

	self._teacher:startWork()
	settimer(1, self._updateGameTime, self, true)
end

function SlackOffGameView:_updateGameTime()
	if self._curGameTime < 1 then
		print("[YuTestPrint] =====>\t 游戏剩余时间耗尽，游戏结束！")

		self._countdownTime.text = "0秒"

		self:_endGame()

		return
	end

	self._curGameTime = self._curGameTime - 1
	self._countdownTime.text = math.ceil(self._curGameTime) .. "秒"

	for _, student in ipairs(self._students) do
		student:update()
	end
end

function SlackOffGameView:_pauseGame()
	print("[YuTestPrint] =====>\t 【摸鱼模拟器】游戏暂停")
	removetimer(self._updateGameTime, self)
end

function SlackOffGameView:_resumeGame()
	print("[YuTestPrint] =====>\t 【摸鱼模拟器】游戏继续")
	settimer(1, self._updateGameTime, self)
end

function SlackOffGameView:_endGame()
	self._teacher:endWork()
	removetimer(self._updateGameTime, self)
	removetimer(self._startGameCountDown, self)

	local studenInfos = {}

	for _, student in ipairs(self._students) do
		local info = student:getInfo()

		table.insert(studenInfos, info)
	end

	UIStateManager.instance:push(ViewName.SlackOffResultView, self._activityId, studenInfos)
end

function SlackOffGameView:_showRuleView()
	local cfg = SlackOffGameConfig.instance:getActivityCfgByActId(self._activityId)

	if cfg then
		local ruleInfos = SlackOffGameConfig.instance:getImgRuleInfosByKey(cfg.ruleKey or "")

		if ruleInfos then
			UIStateManager.instance:push(ViewName.SlackOffGameRuleView, ruleInfos, "游戏规则", self._activityId)
		end
	end
end

function SlackOffGameView:_onClickBtnTip()
	self:_showRuleView()
end

function SlackOffGameView:_onClickBtnClose()
	self:_pauseGame()

	local function okFunc()
		SlackOffGameController.instance:sendGameEndReq(self._activityId, false, {})
		self:close()
	end

	local function cencelFunc()
		self:_resumeGame()
	end

	TipsFacade.instance:openPopupWindow("提示", "是否要退出游戏，现阶段退出不获得任何进度", okFunc, cencelFunc, "确定", "取消")
end

function SlackOffGameView:_sendGameStartReq()
	SlackOffGameController.instance:sendGameStartReq(self._activityId)
end

function SlackOffGameView:_sendGameEndReq()
	return
end

return SlackOffGameView
