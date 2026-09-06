-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhotbloodmmclg/view/OriginHotBloodMMClgFmtView.lua

module("logic.extensions.originhotbloodmmclg.view.OriginHotBloodMMClgFmtView", package.seeall)

local OriginHotBloodMMClgFmtView = class("OriginHotBloodMMClgFmtView", ViewComponent)

function OriginHotBloodMMClgFmtView:ctor()
	OriginHotBloodMMClgFmtView.super.ctor(self)
end

function OriginHotBloodMMClgFmtView:unbindEvents()
	OriginHotBloodMMClgFmtView.super.unbindEvents(self)
end

function OriginHotBloodMMClgFmtView:bindEvents()
	OriginHotBloodMMClgFmtView.super.bindEvents(self)
end

function OriginHotBloodMMClgFmtView:buildUI()
	OriginHotBloodMMClgFmtView.super.buildUI(self)

	self._txtTips = self:getTxt("maskInfo/txtTips")
end

function OriginHotBloodMMClgFmtView:onExit()
	OriginHotBloodMMClgFmtView.super.onExit(self)
end

function OriginHotBloodMMClgFmtView:onEnter()
	OriginHotBloodMMClgFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo:getActivityId()
	self._stageId = self._fmtMo:getStageId()
end

return OriginHotBloodMMClgFmtView
