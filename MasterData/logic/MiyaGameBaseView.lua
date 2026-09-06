-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaGameBaseView.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaGameBaseView", package.seeall)

local MiyaGameBaseView = class("MiyaGameBaseView", ViewComponent)
local Time = UnityEngine.Time

function MiyaGameBaseView:ctor()
	MiyaGameBaseView.super.ctor(self)

	self._totalCount = 0
	self._totalTime = 0
end

function MiyaGameBaseView:unbindEvents()
	MiyaGameBaseView.super.unbindEvents(self)
end

function MiyaGameBaseView:bindEvents()
	MiyaGameBaseView.super.bindEvents(self)
end

function MiyaGameBaseView:onExit()
	MiyaGameBaseView.super.onExit(self)
	removetimer(self._onTick, self)
	GlobalDispatcher:removeListener(GlobalNotify.MiyaCountdownFinished, self._startGame, self)
end

function MiyaGameBaseView:buildUI()
	MiyaGameBaseView.super.buildUI(self)

	self._txtLeftTime = self:getTxt("txtLeftTime")
	self._txtLeftTimeTitle = self:getTxt("txtLeftTimeTitle")
	self._txtLeftCount = self:getTxt("txtLeftCount")
	self._txtLeftCountTitle = self:getTxt("txtLeftCountTitle")
	self._txtLeftTimeTitle.text = lang("miya_findfault_leftTime_title")
	self._txtLeftCountTitle.text = lang("miya_findfault_leftCount_title")
end

function MiyaGameBaseView:onEnter()
	MiyaGameBaseView.super.onEnter(self)

	self._isEndingGame = false

	self:_initGame()
end

function MiyaGameBaseView:_initGame()
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

function MiyaGameBaseView:_startGame()
	GlobalDispatcher:removeListener(GlobalNotify.MiyaCountdownFinished, self._startGame, self)
	settimer(0, self._onTick, self, true)
end

function MiyaGameBaseView:_onTick()
	self._tickedTime = self._tickedTime + Time.deltaTime

	self:_updateLeftTime()
end

function MiyaGameBaseView:_endGame(isWin)
	removetimer(self._onTick, self)

	if self._isEndingGame then
		return
	end

	self._isEndingGame = true

	MiyaGameController.instance:endGameReq(isWin, self._onEndGameRes, self, self._differentNum, self._questionIds, self._answerIds)
end

function MiyaGameBaseView:_onEndGameRes()
	self:close()
end

function MiyaGameBaseView:_updateLeftCount()
	self._txtLeftCount.text = string.format("%s/%s", self._findedCount, self._totalCount)

	if self._findedCount == self._totalCount then
		self:_endGame(true)
	end
end

function MiyaGameBaseView:_updateLeftTime()
	local leftTime = math.max(0, self._totalTime - self._tickedTime)

	self._txtLeftTime.text = string.format("%.2f", leftTime)

	if leftTime > 0 then
		-- block empty
	else
		self:_endGame()
	end
end

return MiyaGameBaseView
