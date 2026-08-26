-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryTaskView.lua

module("modules.logic.necrologiststory.view.NecrologistStoryTaskView", package.seeall)

local NecrologistStoryTaskView = class("NecrologistStoryTaskView", BaseView)

function NecrologistStoryTaskView:onInitView()
	self.simage_Photo = gohelper.findChildSingleImage(self.viewGO, "left/#simage_Photo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NecrologistStoryTaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.updateTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.updateTask, self)
end

function NecrologistStoryTaskView:removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.updateTask, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.updateTask, self)
end

function NecrologistStoryTaskView:_editableInitView()
	return
end

function NecrologistStoryTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_mail_open_1)

	self.roleStoryId = self.viewParam.roleStoryId

	local cfg = RoleStoryConfig.instance:getStoryById(self.roleStoryId)

	self.simage_Photo:LoadImage(ResUrl.getRoleStoryPhotoIcon(cfg.photo))
	self:refreshTask(true)
end

function NecrologistStoryTaskView:onClose()
	return
end

function NecrologistStoryTaskView:updateTask()
	TaskDispatcher.cancelTask(self.refreshTask, self)
	TaskDispatcher.runDelay(self.refreshTask, self, 0.2)
end

function NecrologistStoryTaskView:refreshTask(open)
	NecrologistStoryTaskListModel.instance:refreshList(self.roleStoryId)
end

function NecrologistStoryTaskView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTask, self)
	self.simage_Photo:UnLoadImage()
end

return NecrologistStoryTaskView
