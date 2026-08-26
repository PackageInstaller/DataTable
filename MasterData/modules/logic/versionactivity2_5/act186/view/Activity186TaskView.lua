-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186TaskView.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186TaskView", package.seeall)

local Activity186TaskView = class("Activity186TaskView", BaseView)

function Activity186TaskView:onInitView()
	self.stageList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186TaskView:addEvents()
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.UpdateInfo, self.onUpdateInfo, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.UpdateTask, self.refreshTask, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.FinishTask, self.onFinishTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self.refreshTask, self)
end

function Activity186TaskView:removeEvents()
	return
end

function Activity186TaskView:_editableInitView()
	return
end

function Activity186TaskView:onUpdateInfo()
	self:refreshView()
end

function Activity186TaskView:onFinishTask()
	self:refreshTask()
end

function Activity186TaskView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function Activity186TaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_details_open)
	self:refreshParam()
	self:refreshView()
end

function Activity186TaskView:refreshParam()
	self.actId = self.viewParam.actId
	self.actMo = Activity186Model.instance:getById(self.actId)

	Activity186TaskListModel.instance:init(self.actId)
end

function Activity186TaskView:refreshView()
	self:refreshTask()
	self:refreshStageList()
end

function Activity186TaskView:refreshTask()
	Activity186TaskListModel.instance:refresh()
end

function Activity186TaskView:refreshStageList()
	for i = 1, 3 do
		local stage = self.stageList[i]

		if not stage then
			local go = gohelper.findChild(self.viewGO, "root/stageList/stage" .. i)

			stage = MonoHelper.addNoUpdateLuaComOnceToGo(go, Activity186StageItem)
			self.stageList[i] = stage
		end

		stage:onUpdateMO({
			id = i,
			actMo = self.actMo
		})
	end
end

function Activity186TaskView:onClose()
	return
end

function Activity186TaskView:onDestroyView()
	return
end

return Activity186TaskView
