-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dreamteam/DreamTeamHudPosterView.lua

module("logic.extensions.operationsummary.view.dreamteam.DreamTeamHudPosterView", package.seeall)

local DreamTeamHudPosterView = class("DreamTeamHudPosterView", ViewComponent)

function DreamTeamHudPosterView:buildUI()
	DreamTeamHudPosterView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function DreamTeamHudPosterView:bindEvents()
	DreamTeamHudPosterView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function DreamTeamHudPosterView:unbindEvents()
	DreamTeamHudPosterView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

return DreamTeamHudPosterView
