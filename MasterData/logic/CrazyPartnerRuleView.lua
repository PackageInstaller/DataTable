-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazyPartnerRuleView.lua

module("logic.extensions.crazypartner.view.CrazyPartnerRuleView", package.seeall)

local CrazyPartnerRuleView = class("CrazyPartnerRuleView", ViewComponent)

function CrazyPartnerRuleView:ctor()
	CrazyPartnerRuleView.super.ctor(self)
end

function CrazyPartnerRuleView:unbindEvents()
	CrazyPartnerRuleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CrazyPartnerRuleView:bindEvents()
	CrazyPartnerRuleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CrazyPartnerRuleView:buildUI()
	CrazyPartnerRuleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtRule = self:getTxt("txtRule")
	self._togSelect = self:getToggle("togSelect")
	self._standGo = self:getGo("stand")
end

function CrazyPartnerRuleView:onExit()
	CrazyPartnerRuleView.super.onExit(self)
	self:_saveToggleState()
end

function CrazyPartnerRuleView:onEnter()
	CrazyPartnerRuleView.super.onEnter(self)

	local fightInfo = CrazyPartnerModel.instance.fightInfo
	local creepConf = CrazyPartnerConfig.instance:getTeamConfs(fightInfo.currentCreepsMasterId)
	local buffConf = CrazyPartnerConfig.instance:getBuffConf(fightInfo.currentBuffId)

	self._txtTitle.text = creepConf.name

	local emptyStr = lang("无")

	self._txtRule.text = buffConf and (buffConf.desc or emptyStr) or emptyStr

	goutil.setActive(self._standGo, buffConf and buffConf.type == CrazyPartnerConfig.SequenceBuffType)

	self._togSelect.isOn = GameUtil.getUserDayData(CrazyPartnerConfig.RuleUserSetKey) == 1
end

function CrazyPartnerRuleView:_saveToggleState()
	GameUtil.saveUserDayData(CrazyPartnerConfig.RuleUserSetKey, (self._togSelect.isOn or nil) and 1)
end

return CrazyPartnerRuleView
