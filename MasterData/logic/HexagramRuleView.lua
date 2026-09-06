-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/HexagramRuleView.lua

module("logic.extensions.yirenpozhen.view.HexagramRuleView", package.seeall)

local HexagramRuleView = class("HexagramRuleView", ViewComponent)

function HexagramRuleView:ctor()
	HexagramRuleView.super.ctor(self)
end

function HexagramRuleView:buildUI()
	HexagramRuleView.super.buildUI(self)

	self._pos1 = {}

	for i = 1, 9 do
		table.insert(self._pos1, self:getGo("stand1/position/item" .. i))
	end

	self._pos2 = {}

	for i = 1, 9 do
		table.insert(self._pos2, self:getGo("stand2/position/item" .. i))
	end

	self._txtRule1 = self:getTxt("txtRule1")
	self._txtRule2 = self:getTxt("txtRule2")
	self._select = self:getGo("gua/select")
	self._close = self:getBtn("btnClose")
end

function HexagramRuleView:bindEvents()
	HexagramRuleView.super.bindEvents(self)
	self._close:AddClickListener(self.close, self)
end

function HexagramRuleView:unbindEvents()
	HexagramRuleView.super.unbindEvents(self)
	self._close:RemoveClickListener()
end

function HexagramRuleView:destroyUI()
	HexagramRuleView.super.destroyUI(self)
end

function HexagramRuleView:onEnter()
	HexagramRuleView.super.onEnter(self)

	local params = self._viewPresentor:getFirstParam()
	local creepsMasterId = params.creepsMasterId
	local cCfg = YirenPozhenConfig.instance:getTeamCfg(creepsMasterId)
	local ruleId = cCfg.ruleId
	local ruleCfg = YirenPozhenConfig.instance:getRuleCfg(ruleId)

	self._txtRule1.text = ruleCfg.desc1
	self._txtRule2.text = ruleCfg.desc2

	for i = 1, 9 do
		goutil.setActive(self._pos1[i], false)
	end

	for k, v in ipairs(ruleCfg.pos1) do
		goutil.setActive(self._pos1[v], true)
	end

	for i = 1, 9 do
		goutil.setActive(self._pos2[i], false)
	end

	for k, v in ipairs(ruleCfg.pos2 or {}) do
		goutil.setActive(self._pos2[v], true)
	end

	local diagramId = params.diagramId
	local per = 45

	GameUtil.setLocalRotation(self._select, 0, 0, -(diagramId - 1) * per)
end

function HexagramRuleView:onEnterFinished()
	HexagramRuleView.super.onEnterFinished(self)
end

function HexagramRuleView:onExit()
	HexagramRuleView.super.onExit(self)
end

function HexagramRuleView:onExitFinished()
	HexagramRuleView.super.onExitFinished(self)
end

return HexagramRuleView
