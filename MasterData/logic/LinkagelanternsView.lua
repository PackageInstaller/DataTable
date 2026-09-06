-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageintroduction/view/LinkagelanternsView.lua

module("logic.extensions.linkageintroduction.view.LinkagelanternsView", package.seeall)

local LinkagelanternsView = class("LinkagelanternsView", ViewComponent)

function LinkagelanternsView:ctor()
	LinkagelanternsView.super.ctor(self)
end

function LinkagelanternsView:unbindEvents()
	LinkagelanternsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function LinkagelanternsView:bindEvents()
	LinkagelanternsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function LinkagelanternsView:buildUI()
	LinkagelanternsView.super.buildUI(self)

	self._txtTip = self:getTxt("txtTip")
	self._btnClose = self:getBtn("btnClose")
	self._cfg = LinkageConfig.instance:getCfgByTab(2, 1)
end

function LinkagelanternsView:onExit()
	LinkagelanternsView.super.onExit(self)
end

function LinkagelanternsView:onEnter()
	LinkagelanternsView.super.onEnter(self)

	self._txtTip.text = LinkageController.instance:isOffical() and self._cfg.descOfficial or self._cfg.desc
end

function LinkagelanternsView:_onClickClose()
	self:close()
end

return LinkagelanternsView
