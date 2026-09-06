-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternriddle/view/FindDifferenceGameView.lua

module("logic.extensions.lanternriddle.view.FindDifferenceGameView", package.seeall)

local FindDifferenceGameView = class("FindDifferenceGameView", MiyaFindFaultView)

function FindDifferenceGameView:_initGame()
	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])

	local stageCfgs = LanternRiddleConfig.instance:getLanternRiddleStageCfg(self._activityId)
	local stageCfg = stageCfgs[self._stageId]
	local pictureId = stageCfg.gameExtParam

	self._pictureCfg = LanternRiddleConfig.instance:getLanternRiddleFindDifferenceCfg(checknumber(pictureId))
	self._totalTime = self._pictureCfg.gameTime
	self._totalCount = self._pictureCfg.passNeedNum
	self._url = string.format("ui/views/timelimitedchallenge/findfault/diff%d.prefab", self._pictureCfg.pictureIdNew)
	self._tipCountdown = langPara("miya_findfault_countdown_tip", self._totalTime, self._totalCount)

	self._initBg:SetActive(true)
	getres(self._url, self._onResloadFinish, self)

	self._questionIds = nil
	self._answerIds = nil
	self._differentNum = nil
	self._tickedTime = 0
	self._findedCount = 0

	GlobalDispatcher:addListener(GlobalNotify.MiyaCountdownFinished, self._startGame, self)
	UIStateManager.instance:open(ViewName.MiyaCountdownView, self._tipCountdown, 3)
	self:_updateLeftTime()
	self:_updateLeftCount()
end

function FindDifferenceGameView:_endGame()
	removetimer(self._onTick, self)

	if self._isEndingGame then
		return
	end

	self._isEndingGame = true

	if self._totalCount == self._findedCount then
		FloatWordMgr.instance:show("恭喜通过！")
		LanternRiddleController.instance:sendPM_LanternRiddleEndGameReq(self._activityId, self._stageId, true)
		self:close()
	else
		FloatWordMgr.instance:show("请重新挑战")
		LanternRiddleController.instance:sendPM_LanternRiddleEndGameReq(self._activityId, self._stageId, false)
		self:close()
	end
end

return FindDifferenceGameView
