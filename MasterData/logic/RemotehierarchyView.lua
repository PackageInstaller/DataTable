-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/RemotehierarchyView.lua

module("logic.extensions.gm.view.RemotehierarchyView", package.seeall)

local RemotehierarchyView = class("RemotehierarchyView", ViewComponent)

function RemotehierarchyView:ctor()
	RemotehierarchyView.super.ctor(self)
end

function RemotehierarchyView:unbindEvents()
	RemotehierarchyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function RemotehierarchyView:bindEvents()
	RemotehierarchyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function RemotehierarchyView:buildUI()
	RemotehierarchyView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function RemotehierarchyView:onExit()
	RemotehierarchyView.super.onExit(self)
end

function RemotehierarchyView:onEnter()
	RemotehierarchyView.super.onEnter(self)
end

function RemotehierarchyView:_onClickbtnClose()
	self:close()
end

return RemotehierarchyView
