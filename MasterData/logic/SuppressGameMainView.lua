-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/SuppressGameMainView.lua

module("logic.extensions.suppressgame.view.SuppressGameMainView", package.seeall)

local SuppressGameMainView = class("SuppressGameMainView", ViewComponent)

function SuppressGameMainView:buildUI()
	SuppressGameMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._gameCol = goutil.findChild(self.mainGO, "gameCol")
	self._gameCell = goutil.findChild(self.mainGO, "gameCol/gameCell")
	self._btnTask = goutil.findChild(self.mainGO, "btnTask")
	self._btnTaskRed = goutil.findChild(self.mainGO, "btnTask/redPoint")
	self._btnChallenge = goutil.findChild(self.mainGO, "btnChallenge")
	self._remain = goutil.findChild(self.mainGO, "btnChallenge/remain")
	self._txtBtnChallenge = goutil.findChildTextComponent(self.mainGO, "btnChallenge/txt")
	self._txtBtnChallengeRemain = goutil.findChildTextComponent(self.mainGO, "btnChallenge/remain/txtRemain")

	GameUtil.SetActive(self._gameCell, false)

	self._gameCellList = {}
	self._gameCellEffList = {}
	self._bgEff = nil
end

function SuppressGameMainView:bindEvents()
	SuppressGameMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
end

function SuppressGameMainView:unbindEvents()
	SuppressGameMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function SuppressGameMainView:onEnter()
	SuppressGameMainView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SuppressGame)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._sgActData = SuppressGameConfig.instance:getSgActData(self._activityId)
	self._sgTabCfg = SuppressGameConfig.instance:getSgTabCfg(self._activityId)

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.SuppressGameGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.SuppressGameStartGameRes, self._startTurnGames, self)
	GlobalDispatcher:addListener(GlobalNotify.SuppressGameEndGameRes, self._sendInfoReq, self)
	GlobalDispatcher:addListener(GlobalNotify.SuppressGameGetTaskInfoRes, self._onUpdateTaskRedPoint, self)
	self:_sendInfoReq()
end

function SuppressGameMainView:onExit()
	SuppressGameMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SuppressGameGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.SuppressGameStartGameRes, self._startTurnGames, self)
	GlobalDispatcher:removeListener(GlobalNotify.SuppressGameEndGameRes, self._sendInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.SuppressGameGetTaskInfoRes, self._onUpdateTaskRedPoint, self)
	self:_clearGameCells()
	UIEffectManager.instance:stopEffect(self._bgEff)
	removetimer(self._updateTime, self)
	removetimer(self._endTurnGames, self)
end

function SuppressGameMainView:_sendInfoReq()
	SuppressGameController.instance:onSendSuppressGameGetInfoReq(self._activityId)
	SuppressGameController.instance:onSendSuppressGameGetTaskInfoReq(self._activityId)
end

function SuppressGameMainView:_onSetUI()
	local storyId = self._sgActData.firstEnterStoryId

	if storyId ~= 0 then
		local key = "SuppressGame" .. "FirstEnter" .. "story" .. self._activityId
		local isNotFirst = GameUtil.getUserData(key)

		if not isNotFirst then
			GameUtil.saveUserData(key, true)
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SuppressGame, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtOpenTime then
		self._txtOpenTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	self:_createGameCol()
end

function SuppressGameMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function SuppressGameMainView:_onUpdateTaskRedPoint()
	local sgTabCfg = SuppressGameConfig.instance:getSgTabCfg(self._activityId)
	local isActive = false

	for gameId, sgTabData in ipairs(sgTabCfg) do
		local taskCfg = SuppressGameConfig.instance:getSgTaskCfg(sgTabData.taskPlanId)

		for taskId, data in ipairs(taskCfg) do
			local isHasGain = SuppressGameModel.instance:isTaskHasGainPrize(gameId, taskId)
			local isEnough = SuppressGameModel.instance:isTaskEnoughProgress(gameId, taskId)

			if not isHasGain and isEnough then
				isActive = true

				break
			end
		end
	end

	goutil.setActive(self._btnTaskRed, isActive)
end

function SuppressGameMainView:_onUpdateData()
	return
end

function SuppressGameMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateGameCol()
end

function SuppressGameMainView:_onUpdatePlaneUI()
	for _, data in ipairs(self._sgTabCfg) do
		local isGameHasSuppress = SuppressGameController.instance:_isGameHasSuppress(data.gameId)
		local storyId = data.storyId

		if storyId ~= 0 and isGameHasSuppress then
			local key = "SuppressGame" .. "SuccessSuppress" .. "story" .. self._activityId
			local isNotFirst = GameUtil.getUserData(key)

			if not isNotFirst then
				GameUtil.saveUserData(key, true)
				GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
			end
		end
	end

	local dailyGameTime = SuppressGameModel.instance:getDailyGameTime()
	local totalDailGameTime = SuppressGameConfig.instance:getSgDailyGameTime(self._activityId)
	local leftTime = Mathf.Clamp(totalDailGameTime - dailyGameTime, 0, totalDailGameTime)

	self._txtBtnChallengeRemain.text = string.format("今日剩余次数:%d", leftTime)

	GameUtil.SetActive(self._remain.gameObject, not SuppressGameController.instance:_isAllGameHasSuppress())

	local isNeedContinueGame = SuppressGameController.instance:_isNeedContinueGame()

	self._txtBtnChallenge.text = isNeedContinueGame and "继续压制" or "压制能力"

	local effParent = self.mainGO
	local pathName = "20220701/yazhililiang/fx_ui_yazhililiang"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function SuppressGameMainView:_createGameCol()
	for _, data in ipairs(self._sgTabCfg) do
		if not self._gameCellList[data.gameId] then
			self._gameCellList[data.gameId]._mainGo = self._gameCellList[data.gameId]._mainGo or goutil.findChild(self._gameCol, "gameCell_" .. data.gameId)
			self._gameCellList[data.gameId]._bg = goutil.findChild(self._gameCellList[data.gameId]._mainGo, "bg")
			self._gameCellList[data.gameId]._imgRed = goutil.findChild(self._gameCellList[data.gameId]._mainGo, "imgRed")
			self._gameCellList[data.gameId]._selectGo = goutil.findChild(self._gameCellList[data.gameId]._mainGo, "selectGo")
			self._gameCellList[data.gameId]._tipsRoot = goutil.findChild(self._gameCellList[data.gameId]._mainGo, "tipsRoot")
			self._gameCellList[data.gameId]._txtProgress = goutil.findChildTextComponent(self._gameCellList[data.gameId]._mainGo, "progress/txt")
			self._gameCellList[data.gameId]._successGo = goutil.findChild(self._gameCellList[data.gameId]._mainGo, "successGo")
			self._gameCellList[data.gameId] = self._gameCellList[data.gameId]
			self._gameCellList[data.gameId]._mainGo.name = string.format("gameCell_%d", data.gameId)

			GameUtil.SetActive(self._gameCellList[data.gameId]._mainGo, true)
		end
	end
end

function SuppressGameMainView:_onUpdateGameCol()
	for gameId, cell in ipairs(self._gameCellList) do
		local data = SuppressGameConfig.instance:getSgTabData(self._activityId, gameId)
		local curProgress = SuppressGameModel.instance:getGameProgress(gameId)
		local maxProgress = data.maxProgress

		cell._txtProgress.text = string.format("%d/%d", curProgress, maxProgress)

		local curGameId = SuppressGameModel.instance:getCurGameId()

		GameUtil.SetActive(cell._selectGo, curGameId == gameId)

		if SuppressGameController.instance:_isGameHasSuppress(gameId) then
			cell._txtProgress.text = "压制成功"

			local effParent = cell._mainGo
			local pathName = data.suppressEffPath

			UIEffectManager.instance:stopEffect(self._gameCellEffList[cell._mainGo])

			if effParent and not string.nilorempty(pathName) then
				local path = pathName .. ".prefab"

				local function finishHandler(handlerTarget, eff)
					return
				end

				local function loadedHandler(handlerTarget, eff)
					eff:setParent(effParent.transform)
					eff:setLocalPos(0, 0, 0)
					eff:setScale(1, 1, 1)

					eff.hideEffWhileNotOnTop = true
				end

				local handlerTarget

				self._gameCellEffList[cell._mainGo] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
			end
		end

		GameUtil.addClickHandler(cell._mainGo, GameUtil.handler(self._onClickGameCell, self, cell, data))
	end
end

function SuppressGameMainView:_clearGameCells()
	for gameId, cell in pairs(self._gameCellList) do
		GameUtil.rmClickHandler(cell._mainGo)
		UIEffectManager.instance:stopEffect(self._gameCellEffList[cell._mainGo])

		self._gameCellEffList[cell._mainGo] = nil
	end
end

function SuppressGameMainView:_onClickGameCell(cell, data)
	self:showTabAt(cell._tipsRoot, ViewName.SuppressGameTipsView, data.content)
end

function SuppressGameMainView:_startTurnGames()
	if not self._isNeedAnim then
		self:_endTurnGames()

		return
	end

	ViewBlockMgr.instance:blockClick(true, self)

	local targetGameId = SuppressGameModel.instance:getCurGameId()
	local targetIdx = 0

	self._animGameCellList = {}

	for gameId, cell in ipairs(self._gameCellList) do
		local isHasSuppress = SuppressGameController.instance:_isGameHasSuppress(gameId)

		if not isHasSuppress then
			table.insert(self._animGameCellList, cell)

			if targetGameId == gameId then
				targetIdx = #self._animGameCellList
			end
		end
	end

	self._interval = 0.01
	self._sumInr = 0
	self._startInr = 0.05
	self._endInr = 0.35
	self._limitInr = 0
	self._cellCount = #self._animGameCellList
	self._curStepCount = -1
	self._totalStepCount = 15 - 15 % self._cellCount + targetIdx - 1

	removetimer(self._updateTime, self)
	settimer(self._interval, self._updateTime, self, true)
end

function SuppressGameMainView:_updateTime()
	self._sumInr = self._sumInr + self._interval

	if self._sumInr < self._limitInr then
		return
	end

	self._sumInr = 0
	self._curStepCount = self._curStepCount + 1

	local stepIdx = self._curStepCount % self._cellCount + 1
	local t = self._curStepCount / self._totalStepCount - 0.5

	self._limitInr = Mathf.SmoothStep(self._startInr, self._endInr, t)

	for idx, cell in ipairs(self._animGameCellList) do
		GameUtil.SetActive(cell._selectGo, stepIdx == idx)
	end

	if self._curStepCount >= self._totalStepCount then
		removetimer(self._updateTime, self)

		self._animGameCellList = {}

		self:_readyEndTurnGames()

		return
	end
end

function SuppressGameMainView:_readyEndTurnGames()
	self._lightTimes = 0
	self._totalLightTimes = 3
	self._isLight = false

	removetimer(self._lightCell, self)
	settimer(0.3, self._lightCell, self, true)
end

function SuppressGameMainView:_lightCell()
	local cell = self._gameCellList[SuppressGameModel.instance:getCurGameId()]

	GameUtil.SetActive(cell._selectGo, self._isLight)

	self._isLight = not self._isLight
	self._lightTimes = self._lightTimes + 1

	if self._lightTimes > self._totalLightTimes then
		removetimer(self._lightCell, self)
		self:_endTurnGames()
	end
end

function SuppressGameMainView:_endTurnGames()
	ViewBlockMgr.instance:blockClick(false, self)
	SuppressGameController.instance:_enterGame()
end

function SuppressGameMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("suppressgame_rule")
end

function SuppressGameMainView:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.SuppressGameTaskView)
end

function SuppressGameMainView:_onClickBtnChallenge()
	if SuppressGameController.instance:_isAllGameHasSuppress() then
		FloatWordMgr.instance:show("恭喜你，已压制成功~")

		return
	end

	self._isNeedAnim = not SuppressGameController.instance:_isNeedContinueGame()

	local leftCount = #self._gameCellList

	for gameId, cell in ipairs(self._gameCellList) do
		local isHasSuppress = SuppressGameController.instance:_isGameHasSuppress(gameId)

		if isHasSuppress then
			leftCount = leftCount - 1
		end
	end

	if self._isNeedAnim and leftCount == 1 then
		self._isNeedAnim = false
	end

	SuppressGameController.instance:onSendSuppressGameStartGameReq(self._activityId)
end

return SuppressGameMainView
