-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalMatchView.lua

module("logic.extensions.landlords.view.FalMatchView", package.seeall)

local FalMatchView = class("FalMatchView", ViewComponent)

function FalMatchView:buildUI()
	FalMatchView.super.buildUI(self)

	self._matching = goutil.findChild(self.mainGO, "matching")
	self._btnClose = goutil.findChild(self.mainGO, "matching/btnCancel")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "matching/txtTime")
	self._success = goutil.findChild(self.mainGO, "success")
end

function FalMatchView:bindEvents()
	FalMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function FalMatchView:unbindEvents()
	FalMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FalMatchView:onEnter()
	FalMatchView.super.onEnter(self)

	local params = self:getOpenParam()

	self._falGameMo = FightAgainstLandlordsController.instance:getFalGameMo()
	self._activityId = self._falGameMo:getActivityId()
	self._gameId = self._falGameMo:getGameId()

	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKCancelMatchRes, self._handleCancelMatchRes, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKNotifyDealCardRes, self._handleDealCardRes, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKMatchRes, self._handleMatchRes, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKNotifyMatchingOverTimeRes, self._handleMatchingOverTimeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKNotifyMatchFailRes, self._handleMatchFailRes, self)
	self:_startMatch()
	FightAgainstLandlordsController.instance:sendPM_LandlordsPKMatchReq(self._activityId, self._gameId)
end

function FalMatchView:onExit()
	FalMatchView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKCancelMatchRes, self._handleCancelMatchRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKNotifyDealCardRes, self._handleDealCardRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKMatchRes, self._handleMatchRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKNotifyMatchingOverTimeRes, self._handleMatchingOverTimeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKNotifyMatchFailRes, self._handleMatchFailRes, self)
	self:_stopMatch()
end

function FalMatchView:_startMatch()
	self._startMatchTime = UnityEngine.Time.realtimeSinceStartup

	GameUtil.SetActive(self._matching, true)
	GameUtil.SetActive(self._success, false)
	settimer(0.1, self._onMatchTicking, self)
end

function FalMatchView:_stopMatch()
	removetimer(self._onMatchTicking, self)
	removetimer(self._enterScence, self)
	removetimer(self._matchFailClose, self)
end

function FalMatchView:_onMatchTicking()
	self._deltaTime = UnityEngine.Time.realtimeSinceStartup - self._startMatchTime
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._deltaTime)
end

function FalMatchView:_matchSuccess()
	self:_stopMatch()
	GameUtil.SetActive(self._matching, false)
	GameUtil.SetActive(self._success, true)
	settimer(2, self._enterScence, self, false)
end

function FalMatchView:_enterScence()
	self:close()
	UIStateManager.instance:push(ViewName.FalGameScenceView)
end

function FalMatchView:_onClickBtnClose()
	FightAgainstLandlordsController.instance:sendPM_LandlordsPKCancelMatchReq()
end

function FalMatchView:_handleDealCardRes()
	self:_matchSuccess()
end

function FalMatchView:_handleCancelMatchRes()
	self:close()
end

function FalMatchView:_handleMatchRes(status, msg)
	if status == 0 then
		-- block empty
	else
		settimer(3, self._matchFailClose, self, false)
	end
end

function FalMatchView:_matchFailClose()
	FloatWordMgr.instance:show("上一局游戏进行中,请等待冷却")
	self:close()
end

function FalMatchView:_handleMatchingOverTimeRes()
	FloatWordMgr.instance:show("匹配超时")
	self:close()
end

function FalMatchView:_handleMatchFailRes()
	FloatWordMgr.instance:show("因某种原因匹配失败")
	self:close()
end

return FalMatchView
