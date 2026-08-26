-- chunkname: @modules/logic/versionactivity1_4/act134/view/Activity134TaskView.lua

module("modules.logic.versionactivity1_4.act134.view.Activity134TaskView", package.seeall)

local Activity134TaskView = class("Activity134TaskView", BaseView)

function Activity134TaskView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "main/#simage_bg")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "main/#scroll_view")
	self._gotaskitem = gohelper.findChild(self.viewGO, "main/#scroll_view/Viewport/Content/#go_taskitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "main/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity134TaskView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
end

function Activity134TaskView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
end

function Activity134TaskView:_btncloseOnClick()
	self:closeThis()
end

function Activity134TaskView:onClickModalMask()
	self:closeThis()
end

function Activity134TaskView:_editableInitView()
	return
end

function Activity134TaskView:onUpdateParam()
	return
end

function Activity134TaskView:onOpen()
	Activity134TaskListModel.instance:sortTaskMoList()
end

function Activity134TaskView:onClose()
	return
end

function Activity134TaskView:onDestroyView()
	return
end

function Activity134TaskView:refreshRight()
	Activity134TaskListModel.instance:sortTaskMoList(self.actId, self.tabIndex)
end

return Activity134TaskView
