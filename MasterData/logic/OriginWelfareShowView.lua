-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originwelfare/view/OriginWelfareShowView.lua

module("logic.extensions.originwelfare.view.OriginWelfareShowView", package.seeall)

local OriginWelfareShowView = class("OriginWelfareShowView", ViewComponent)

function OriginWelfareShowView:ctor()
	OriginWelfareShowView.super.ctor(self)
end

function OriginWelfareShowView:unbindEvents()
	OriginWelfareShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriginWelfareShowView:bindEvents()
	OriginWelfareShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriginWelfareShowView:buildUI()
	OriginWelfareShowView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._txtDesc = self:getTxt("desc/txtDesc")
end

function OriginWelfareShowView:onExit()
	OriginWelfareShowView.super.onExit(self)
end

function OriginWelfareShowView:onEnter()
	OriginWelfareShowView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 538001
	end

	self._actCfg = OriginWelfareConfig.instance:getActCfg(self._activityId)
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

return OriginWelfareShowView
