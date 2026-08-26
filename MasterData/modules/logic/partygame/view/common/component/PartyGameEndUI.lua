-- chunkname: @modules/logic/partygame/view/common/component/PartyGameEndUI.lua

module("modules.logic.partygame.view.common.component.PartyGameEndUI", package.seeall)

local PartyGameEndUI = class("PartyGameEndUI", LuaCompBase)

function PartyGameEndUI:init(go)
	self._soloEnd = gohelper.findChild(go, "#go_solocomplete")
	self._teamEnd = gohelper.findChild(go, "#go_teamcomplete ")
	self._BlueWin = gohelper.findChild(go, "#go_teamcomplete /#go_bluewin")
	self._RedWind = gohelper.findChild(go, "#go_teamcomplete /#go_redwin")
	self._teamAnim = gohelper.findComponentAnim(self._teamEnd)

	gohelper.setActive(self._soloEnd, false)
	gohelper.setActive(self._teamEnd, false)
	gohelper.setActive(self._BlueWin, false)
	gohelper.setActive(self._RedWind, false)
end

function PartyGameEndUI:addEventListeners()
	PartyGameController.instance:registerCallback(PartyGameEvent.OnGameEnd, self._onGameEnd, self)
end

function PartyGameEndUI:removeEventListeners()
	PartyGameController.instance:unregisterCallback(PartyGameEvent.OnGameEnd, self._onGameEnd, self)
end

function PartyGameEndUI:_onGameEnd()
	AudioMgr.instance:trigger(AudioEnum3_4.PartyGame.gamestart)

	self._curGame = PartyGameController.instance:getCurPartyGame()
	self._isTeamType = self._curGame:isTeamType()

	gohelper.setActive(self._soloEnd, not self._isTeamType)
	gohelper.setActive(self._teamEnd, self._isTeamType)

	local delayTime = 1.4

	if self._isTeamType then
		local winTeam = self._curGame:getWinTeam()

		self._mainPlayerUid = self._curGame:getMainPlayerUid()

		local playerMo = PartyGameModel.instance:getPlayerMoByUid(self._mainPlayerUid)

		if winTeam == 3 and playerMo then
			winTeam = playerMo.tempType
		end

		gohelper.setActive(self._BlueWin, winTeam == PartyGameEnum.GamePlayerTeamType.Blue)
		gohelper.setActive(self._RedWind, winTeam == PartyGameEnum.GamePlayerTeamType.Red)

		delayTime = 0.5

		local key = winTeam == PartyGameEnum.GamePlayerTeamType.Blue and "bluewin" or "redwin"

		if self._teamAnim then
			self._teamAnim:Play(key)
		end
	end

	TaskDispatcher.runDelay(self._delayShowResultView, self, delayTime)
	UIBlockHelper.instance:startBlock("PartyGameEndUI", delayTime)
	PopupController.instance:setPause("PartyGameEndUI", true)

	if self._isTeamType then
		if self._curGame and self._curGame:getIsLocal() and not self._curGame:getIsTrial() then
			logNormal("PartyGameEndUI open PartyGameTeamResultGuideView")
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.PartyGameTeamResultGuideView)
		else
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.PartyGameTeamResultView)
		end
	elseif self._curGame and self._curGame:getIsLocal() and not self._curGame:getIsTrial() then
		logNormal("PartyGameEndUI open PartyGameSoloResultGuideView")
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.PartyGameSoloResultGuideView)
	else
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.PartyGameSoloResultView)
	end
end

function PartyGameEndUI:_delayShowResultView()
	PopupController.instance:setPause("PartyGameEndUI", false)
end

function PartyGameEndUI:onDestroy()
	PopupController.instance:setPause("PartyGameEndUI", false)
	TaskDispatcher.cancelTask(self._delayShowResultView, self)
end

return PartyGameEndUI
