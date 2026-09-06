-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/view/TunTianChallengeExtremeSureView.lua

module("logic.extensions.tuntianchallenge.view.TunTianChallengeExtremeSureView", package.seeall)

local TunTianChallengeExtremeSureView = class("TunTianChallengeExtremeSureView", ViewComponent)

function TunTianChallengeExtremeSureView:buildUI()
	TunTianChallengeExtremeSureView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._txtOldValue = goutil.findChildTextComponent(self.mainGO, "valueCol/txtOldValue")
	self._txtNewValue = goutil.findChildTextComponent(self.mainGO, "valueCol/txtNewValue")
end

function TunTianChallengeExtremeSureView:bindEvents()
	TunTianChallengeExtremeSureView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function TunTianChallengeExtremeSureView:unbindEvents()
	TunTianChallengeExtremeSureView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function TunTianChallengeExtremeSureView:onEnter()
	TunTianChallengeExtremeSureView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageType = checknumber(params[2])
	self._stageId = checknumber(params[3])
	self._oldValue = checknumber(params[4])
	self._newValue = checknumber(params[5])
	self._txtOldValue.text = self._oldValue
	self._txtNewValue.text = self._newValue

	self.addGEvent(self, GlobalNotify.TunTianExtremeClgUseNewStageScoreRes, self._tunTianExtremeClgUseNewStageScoreRes, self)
end

function TunTianChallengeExtremeSureView:onExit()
	TunTianChallengeExtremeSureView.super.onExit(self)
end

function TunTianChallengeExtremeSureView:_tunTianExtremeClgUseNewStageScoreRes(status)
	if status == 0 then
		local activityId = self._activityId
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = TunTianChallengeController.instance:getActivityType()

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
		end
	end

	self:close()
	BattleController.instance:endBattle()
end

function TunTianChallengeExtremeSureView:_onClickBtnClose()
	BattleController.instance:endBattle()
end

function TunTianChallengeExtremeSureView:_onClickBtnSure()
	TunTianChallengeController.instance:sendPM_TunTianExtremeClgUseNewStageScoreReq(self._activityId, self._stageType, self._stageId, true, self._newValue)
end

function TunTianChallengeExtremeSureView:_onClickBtnCancel()
	TunTianChallengeController.instance:sendPM_TunTianExtremeClgUseNewStageScoreReq(self._activityId, self._stageType, self._stageId, false, self._newValue)
end

return TunTianChallengeExtremeSureView
