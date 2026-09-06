-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGlorybreakthroughView.lua

module("logic.extensions.recastglory.view.RecastGlorybreakthroughView", package.seeall)

local RecastGlorybreakthroughView = class("RecastGlorybreakthroughView", ViewComponent)

function RecastGlorybreakthroughView:ctor()
	RecastGlorybreakthroughView.super.ctor(self)
end

function RecastGlorybreakthroughView:unbindEvents()
	RecastGlorybreakthroughView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShare)
end

function RecastGlorybreakthroughView:bindEvents()
	RecastGlorybreakthroughView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickShare, self)
end

function RecastGlorybreakthroughView:buildUI()
	RecastGlorybreakthroughView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnShare = self:getBtn("btnShare")
end

function RecastGlorybreakthroughView:onExit()
	RecastGlorybreakthroughView.super.onExit(self)
end

function RecastGlorybreakthroughView:onEnter()
	RecastGlorybreakthroughView.super.onEnter(self)
end

function RecastGlorybreakthroughView:_onClickShare()
	local bgImageName = "share_01"

	UIStateManager.instance:push(ViewName.ShareQRCode, bgImageName, url)
end

return RecastGlorybreakthroughView
