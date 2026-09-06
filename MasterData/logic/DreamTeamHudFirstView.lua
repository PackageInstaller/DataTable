-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dreamteam/DreamTeamHudFirstView.lua

module("logic.extensions.operationsummary.view.dreamteam.DreamTeamHudFirstView", package.seeall)

local DreamTeamHudFirstView = class("DreamTeamHudFirstView", ViewComponent)

function DreamTeamHudFirstView:buildUI()
	DreamTeamHudFirstView.super.buildUI(self)

	self._btnGoto = self:getBtn("btnGoTo")
	self._btnSkillChange = self:getBtn("btnSkillChange")
	self._redPoint = self:getGo("btnGoTo/redPoint")
end

function DreamTeamHudFirstView:onEnter()
	DreamTeamHudFirstView.super.onEnter(self)
	goutil.setActive(self._redPoint, false)

	local cfg = self:getFirstParam()

	RedPointController.instance:regRedPoint(self._redPoint, unpack(cfg.redPointIds or {}))
end

function DreamTeamHudFirstView:onExit()
	DreamTeamHudFirstView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPoint)
end

function DreamTeamHudFirstView:bindEvents()
	DreamTeamHudFirstView.super.bindEvents(self)
	self._btnGoto:AddClickListener(self._onClickGoTo, self)
	self._btnSkillChange:AddClickListener(self._onClickSkillChange, self)
end

function DreamTeamHudFirstView:unbindEvents()
	DreamTeamHudFirstView.super.unbindEvents(self)
	self._btnGoto:RemoveClickListener()
	self._btnSkillChange:RemoveClickListener()
end

function DreamTeamHudFirstView:_onClickGoTo()
	GotoMgr.gotoByString("func#471")
end

function DreamTeamHudFirstView:_onClickSkillChange()
	GotoMgr.gotoByString("func#427#6")
end

return DreamTeamHudFirstView
