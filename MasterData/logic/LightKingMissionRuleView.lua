-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingMissionRuleView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingMissionRuleView", package.seeall)

local LightKingMissionRuleView = class("LightKingMissionRuleView", ViewComponent)

function LightKingMissionRuleView:unbindEvents()
	LightKingMissionRuleView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function LightKingMissionRuleView:bindEvents()
	LightKingMissionRuleView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function LightKingMissionRuleView:buildUI()
	LightKingMissionRuleView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtRule = self:getTxt("effect/txtRule")
	self._txtClaim = self:getTxt("claim/txtClaim")
end

function LightKingMissionRuleView:onEnter()
	LightKingMissionRuleView.super.onEnter(self)

	local stageCfg = LightKingModel.instance:getCurStageCfg()

	self._txtRule.text = stageCfg.missionCondition
	self._txtClaim.text = stageCfg.WinDesc
end

return LightKingMissionRuleView
