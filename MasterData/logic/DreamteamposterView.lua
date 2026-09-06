-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/grandceremony/DreamteamposterView.lua

module("logic.extensions.bonus.view.grandceremony.DreamteamposterView", package.seeall)

local DreamteamposterView = class("DreamteamposterView", SummarySubTabView)

function DreamteamposterView:ctor()
	DreamteamposterView.super.ctor(self)
end

function DreamteamposterView:unbindEvents()
	DreamteamposterView.super.unbindEvents(self)
end

function DreamteamposterView:bindEvents()
	DreamteamposterView.super.bindEvents(self)
end

function DreamteamposterView:buildUI()
	DreamteamposterView.super.buildUI(self)
end

function DreamteamposterView:buildBtnJump()
	self.btnJump[1] = self:getGo("btnGoto")

	for _, cfg in pairs(self._cfgs) do
		GameUtil.addClickHandler(self.btnJump[cfg.id], GameUtil.handler(self._onJump, self, cfg))
	end
end

function DreamteamposterView:onExit()
	DreamteamposterView.super.onExit(self)
end

function DreamteamposterView:onEnter()
	DreamteamposterView.super.onEnter(self)
end

function DreamteamposterView:thisViewName()
	return ViewName.DreamteamposterView
end

return DreamteamposterView
