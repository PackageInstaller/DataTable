-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/view/DivineCiYuanTrailView.lua

module("logic.extensions.divineciyuan.view.DivineCiYuanTrailView", package.seeall)

local DivineCiYuanTrailView = class("DivineCiYuanTrailView", ViewComponent)

function DivineCiYuanTrailView:ctor()
	DivineCiYuanTrailView.super.ctor(self)
end

function DivineCiYuanTrailView:unbindEvents()
	DivineCiYuanTrailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineCiYuanTrailView:bindEvents()
	DivineCiYuanTrailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineCiYuanTrailView:buildUI()
	DivineCiYuanTrailView.super.buildUI(self)

	self._pass1 = self:getGo("trail_1/pass")
	self._pass2 = self:getGo("trail_2/pass")
	self._btnClose = self:getBtn("btnClose")
	self._txtProgress1 = self:getTxt("trail_1/txtProgress")
	self._txtProgress2 = self:getTxt("trail_2/txtProgress")
end

function DivineCiYuanTrailView:onExit()
	DivineCiYuanTrailView.super.onExit(self)
end

function DivineCiYuanTrailView:onEnter()
	DivineCiYuanTrailView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DivineCiYuan)

	local isPopTrailView = GameUtil.getUserData(ViewName.DivineCiYuanTrailView .. self._activityId)

	if not isPopTrailView then
		GameUtil.saveUserData(ViewName.DivineCiYuanTrailView .. self._activityId, true)
	end

	local signCfg = DivineCiYuanConfig.instance:getUniversalAllSignCfg(self._activityId)
	local signProgress, allSignProgress = 0, 0

	for tabId, cfg in ipairs(signCfg) do
		local signDay = DivineCiYuanController.instance:getSignInfo(self._activityId, tabId)

		signProgress = signProgress + signDay
		allSignProgress = allSignProgress + #cfg
	end

	local challengeCfg = DivineCiYuanConfig.instance:getUniversalAllStageCfg(self._activityId)
	local challengeProgress, allChallengeProgress = 0, 0

	for tabId, cfg in ipairs(challengeCfg) do
		local progress = DivineCiYuanController.instance:getUniversalChallengeProgress(self._activityId, tabId)

		challengeProgress = challengeProgress + progress
		allChallengeProgress = allChallengeProgress + #cfg
	end

	self._txtProgress1.text = string.format("(<color=#20b376>%d</color>/%d)", signProgress, allSignProgress)
	self._txtProgress2.text = string.format("(<color=#20b376>%d</color>/%d)", challengeProgress, allChallengeProgress)

	GameUtil.SetActive(self._pass1, allSignProgress <= signProgress)
	GameUtil.SetActive(self._pass2, allChallengeProgress <= challengeProgress)
end

return DivineCiYuanTrailView
