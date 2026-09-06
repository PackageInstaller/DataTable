-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/eternalchallenge/EternalChallengeTaskFrameView.lua

module("logic.extensions.eventtasksummary.view.tab.eternalchallenge.EternalChallengeTaskFrameView", package.seeall)

local EternalChallengeTaskFrameView = class("EternalChallengeTaskFrameView", EventTaskTabFrameView)

function EternalChallengeTaskFrameView:ctor()
	return
end

function EternalChallengeTaskFrameView:buildUI()
	EternalChallengeTaskFrameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._con = goutil.findChild(self.mainGO, "con")
end

function EternalChallengeTaskFrameView:bindEvents()
	EternalChallengeTaskFrameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function EternalChallengeTaskFrameView:unbindEvents()
	EternalChallengeTaskFrameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
end

function EternalChallengeTaskFrameView:onEnter()
	EternalChallengeTaskFrameView.super.onEnter(self)
end

function EternalChallengeTaskFrameView:onExit()
	EternalChallengeTaskFrameView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function EternalChallengeTaskFrameView:_onSetUI()
	EternalChallengeTaskFrameView.super._onSetUI(self)

	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
end

function EternalChallengeTaskFrameView:_getRaceId()
	return EternalChallengeController.instance:getRaceId(self._activityId)
end

function EternalChallengeTaskFrameView:_getSkinId()
	return EternalChallengeController.instance:getSkinId(self._activityId)
end

function EternalChallengeTaskFrameView:_onClickBtnTip()
	local key = EternalChallengeConfig.instance:getEcClientCommonValue(self._activityId, "ETERNALCHALLENGE_RULE_TASK_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

return EternalChallengeTaskFrameView
