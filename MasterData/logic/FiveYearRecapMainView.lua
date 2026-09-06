-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/view/FiveYearRecapMainView.lua

module("logic.extensions.fiveyearrecap.view.FiveYearRecapMainView", package.seeall)

local FiveYearRecapMainView = class("FiveYearRecapMainView", TabFrameWorkShowMainView)

function FiveYearRecapMainView:ctor()
	FiveYearRecapMainView.super.ctor(self)
end

function FiveYearRecapMainView:buildUI()
	FiveYearRecapMainView.super.buildUI(self)
end

function FiveYearRecapMainView:onEnter()
	local param = self:getOpenParam() or {}

	self._activityId = checknumber(param[1])

	if self._activityId <= 0 then
		self._activityId = FiveYearRecapController.instance:getActivityId()
	end

	FiveYearRecapMainView.super.onEnter(self)
end

function FiveYearRecapMainView:_getDefaultFrameId()
	return TabFrameWorkEnum.FrameIds_FiveYearRecap
end

function FiveYearRecapMainView:_onAfterEnterFrame()
	FiveYearRecapController.instance:sendPM_FiveYearRecapGetInfoReq(self._activityId)
end

return FiveYearRecapMainView
