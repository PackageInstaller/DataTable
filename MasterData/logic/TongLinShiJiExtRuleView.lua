-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiExtRuleView.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiExtRuleView", package.seeall)

local TongLinShiJiExtRuleView = class("TongLinShiJiExtRuleView", ViewComponent)

function TongLinShiJiExtRuleView:ctor()
	TongLinShiJiExtRuleView.super.ctor(self)
end

function TongLinShiJiExtRuleView:buildUI()
	TongLinShiJiExtRuleView.super.buildUI(self)

	self._txtRules = self:getTxt("ruleView/Viewport/Content/txtRules")
	self._btnClose = self:getGo("btnClose")
end

function TongLinShiJiExtRuleView:bindEvents()
	TongLinShiJiExtRuleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TongLinShiJiExtRuleView:unbindEvents()
	TongLinShiJiExtRuleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TongLinShiJiExtRuleView:onEnter()
	TongLinShiJiExtRuleView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._raceType = params[2]
	self._fmtIdx = checknumber(params[3])
	self._txtRules.text = TongLinShiJiConfig.instance:GetEtrRuleDetail(self._activityId, self._raceType, self._fmtIdx)
end

function TongLinShiJiExtRuleView:onExit()
	TongLinShiJiExtRuleView.super.onExit(self)
end

return TongLinShiJiExtRuleView
