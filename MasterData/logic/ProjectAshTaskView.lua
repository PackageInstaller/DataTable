-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/view/ProjectAshTaskView.lua

module("logic.extensions.projectash.view.ProjectAshTaskView", package.seeall)

local ProjectAshTaskView = class("ProjectAshTaskView", EventtasksummaryView)

function ProjectAshTaskView:ctor()
	ProjectAshTaskView.super.ctor(self)
end

function ProjectAshTaskView:buildUI()
	ProjectAshTaskView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function ProjectAshTaskView:bindEvents()
	ProjectAshTaskView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function ProjectAshTaskView:unbindEvents()
	ProjectAshTaskView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

return ProjectAshTaskView
