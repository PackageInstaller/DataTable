-- chunkname: @modules/logic/college/view/task/CollegeTaskView.lua

module("modules.logic.college.view.task.CollegeTaskView", package.seeall)

local CollegeTaskView = class("CollegeTaskView", BaseView)

function CollegeTaskView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeTaskView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function CollegeTaskView:_btnCloseOnClick()
	self:closeThis()
end

function CollegeTaskView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function CollegeTaskView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function CollegeTaskView:onOpen()
	CollegeTaskListModel.instance:initTaskList()
end

return CollegeTaskView
