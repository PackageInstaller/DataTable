-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/perfectrulemode/PerfectRuleModePassruleView.lua

module("logic.extensions.timelimitedchallenge.view.perfectrulemode.PerfectRuleModePassruleView", package.seeall)

local PerfectRuleModePassruleView = class("PerfectRuleModePassruleView", ViewComponent)

function PerfectRuleModePassruleView:unbindEvents()
	PerfectRuleModePassruleView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PerfectRuleModePassruleView:bindEvents()
	PerfectRuleModePassruleView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function PerfectRuleModePassruleView:onExit()
	PerfectRuleModePassruleView.super.onExit(self)
end

function PerfectRuleModePassruleView:buildUI()
	PerfectRuleModePassruleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._ruleDesc1 = self:getTxt("rule/rule1/txtDesc")
	self._ruleDesc2 = self:getTxt("rule/rule2/txtDesc")
end

function PerfectRuleModePassruleView:onEnter()
	PerfectRuleModePassruleView.super.onEnter(self)

	self._challengeId = checkint(self:getFirstParam())

	local curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId)
	local ruleId = checkint(curInfo.curRuleId)
	local ruleCfg = PerfectRuleModeConfig.instance:getRuleCfgById(self._challengeId, ruleId)

	self._ruleDesc1.text = ruleCfg.buffDes

	local str = "普通通关：击败敌阵\n完美通关：击败敌阵且"

	self._ruleDesc2.text = str .. ruleCfg.perfectDes
end

return PerfectRuleModePassruleView
