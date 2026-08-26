-- chunkname: @modules/logic/season/view3_0/Season3_0TaskView.lua

module("modules.logic.season.view3_0.Season3_0TaskView", package.seeall)

local Season3_0TaskView = class("Season3_0TaskView", BaseView)

function Season3_0TaskView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goScroll = gohelper.findChild(self.viewGO, "#scroll_tasklist")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_tasklist/Viewport/Content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0TaskView:addEvents()
	return
end

function Season3_0TaskView:removeEvents()
	return
end

function Season3_0TaskView:_editableInitView()
	self._simagebg:LoadImage(SeasonViewHelper.getSeasonIcon("full/bg1.png"))
end

function Season3_0TaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.updateTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.updateTask, self)
	self:refreshTask(true)
end

function Season3_0TaskView:onClose()
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.updateTask, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.updateTask, self)
end

function Season3_0TaskView:updateTask()
	TaskDispatcher.cancelTask(self.refreshTask, self)
	TaskDispatcher.runDelay(self.refreshTask, self, 0.2)
end

function Season3_0TaskView:refreshTask(open)
	Activity104TaskListModel.instance:refreshList()
end

function Season3_0TaskView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTask, self)
	self._simagebg:UnLoadImage()
end

return Season3_0TaskView
