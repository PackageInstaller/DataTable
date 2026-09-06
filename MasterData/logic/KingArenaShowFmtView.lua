-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/fmt/KingArenaShowFmtView.lua

module("logic.extensions.kingarena.view.fmt.KingArenaShowFmtView", package.seeall)

local KingArenaShowFmtView = class("KingArenaShowFmtView", ViewComponent)

function KingArenaShowFmtView:ctor()
	KingArenaShowFmtView.super.ctor(self)
end

function KingArenaShowFmtView:bindEvents()
	KingArenaShowFmtView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function KingArenaShowFmtView:unbindEvents()
	KingArenaShowFmtView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function KingArenaShowFmtView:buildUI()
	KingArenaShowFmtView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
end

function KingArenaShowFmtView:destroyUI()
	KingArenaShowFmtView.super.destroyUI(self)
end

function KingArenaShowFmtView:onEnter()
	KingArenaShowFmtView.super.onEnter(self)
end

function KingArenaShowFmtView:onExit()
	KingArenaShowFmtView.super.onExit(self)
end

function KingArenaShowFmtView:_onClickClose()
	self:close()
end

return KingArenaShowFmtView
