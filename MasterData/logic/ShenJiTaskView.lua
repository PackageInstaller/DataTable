-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiTaskView.lua

module("logic.extensions.shenjichallenge.view.ShenJiTaskView", package.seeall)

local ShenJiTaskView = class("ShenJiTaskView", EventtasksummaryView)

function ShenJiTaskView:ctor()
	ShenJiTaskView.super.ctor(self)
end

function ShenJiTaskView:buildUI()
	ShenJiTaskView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function ShenJiTaskView:bindEvents()
	ShenJiTaskView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ShenJiTaskView:unbindEvents()
	ShenJiTaskView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

return ShenJiTaskView
