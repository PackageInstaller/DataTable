-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationGameView.lua

module("logic.extensions.islandstation.view.IslandStationGameView", package.seeall)

local IslandStationGameView = class("IslandStationGameView", MiyaFindFaultView)

function IslandStationGameView:buildUI()
	IslandStationGameView.super.buildUI(self)

	self._txtLeftTimeTitle.text = "剩余时间："
	self._txtLeftCountTitle.text = "目标数量："
end

function IslandStationGameView:_initGame()
	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._difficulty = checknumber(params[3])
	self._pictureCfg = IslandStationController.instance:getRandomPictureCfg(self._difficulty)
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

function IslandStationGameView:_endGame()
	removetimer(self._onTick, self)

	if self._isEndingGame then
		return
	end

	self._isEndingGame = true

	if self._findedCount > 0 then
		TipsFacade.instance:openPopupWindow("提示", string.format("是否保存本次成绩\n本次成绩为：%d/%d", self._findedCount, self._totalCount), function()
			IslandStationController:sendPM_IslandStationEndGameReq(self._activityId, self._stageId, self._findedCount)
			self:close()
		end, function()
			self:close()
		end, "确定", "取消")
	else
		FloatWordMgr.instance:show("请重新挑战")
		self:close()
	end
end

return IslandStationGameView
