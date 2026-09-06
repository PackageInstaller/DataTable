-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpFmtExtisonView.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpFmtExtisonView", package.seeall)

local MagicSchoolPvpFmtExtisonView = class("MagicSchoolPvpFmtExtisonView", ViewComponent)

function MagicSchoolPvpFmtExtisonView:buildUI()
	MagicSchoolPvpFmtExtisonView.super.buildUI(self)

	self._leftTimeGo = self:getGo("leftTime")
	self._txtLeftTime = self:getTxt("leftTime/txt")
end

function MagicSchoolPvpFmtExtisonView:bindEvents()
	MagicSchoolPvpFmtExtisonView.super.bindEvents(self)
end

function MagicSchoolPvpFmtExtisonView:unbindEvents()
	MagicSchoolPvpFmtExtisonView.super.unbindEvents(self)
end

function MagicSchoolPvpFmtExtisonView:onEnter()
	MagicSchoolPvpFmtExtisonView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo:getActivityId()
	self._subMo = MagicSchoolPvPController.instance:getSubMo(self._activityId)
	self._isBattle = self._customFmtMo:isBattle()

	if self._isBattle then
		GameUtil.SetActive(self._leftTimeGo, true)
		settimer(0.1, self._onTicking, self, true)
		self:_onTicking()
	else
		GameUtil.SetActive(self._leftTimeGo, false)
	end
end

function MagicSchoolPvpFmtExtisonView:onExit()
	MagicSchoolPvpFmtExtisonView.super.onExit(self)
	removetimer(self._onTicking, self)
end

function MagicSchoolPvpFmtExtisonView:_onTicking()
	self._serverTime = ServerTime.now()

	local endTime = self._subMo:getPeriodTimeStamp(MagicSchoolPvPEnum.PeriodType_Boss)

	self._readyLeftTime = Mathf.Max(0, endTime - self._serverTime)
	self._txtLeftTime.text = string.format("准备倒计时：%d秒", self._readyLeftTime)
end

return MagicSchoolPvpFmtExtisonView
