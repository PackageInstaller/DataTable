-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/actbp/Anniversary3ActBpTaskView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.actbp.Anniversary3ActBpTaskView", package.seeall)

local Anniversary3ActBpTaskView = class("Anniversary3ActBpTaskView", BaseView)

function Anniversary3ActBpTaskView:onInitView()
	self._gotaskview = gohelper.findChild(self.viewGO, "#go_taskview")
	self._gotaskitemroot = gohelper.findChild(self.viewGO, "#go_taskview/root/#go_taskitemroot")
	self._gotaskitem = gohelper.findChild(self.viewGO, "#go_taskview/root/#go_taskitemroot/Viewport/content/#go_taskitem")
	self._goreddot1 = gohelper.findChild(self.viewGO, "#go_taskview/root/redDot/#go_reddot1")
	self._goreddot2 = gohelper.findChild(self.viewGO, "#go_taskview/root/redDot/#go_reddot2")
	self._goreddot3 = gohelper.findChild(self.viewGO, "#go_taskview/root/redDot/#go_reddot3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Anniversary3ActBpTaskView:addEvents()
	return
end

function Anniversary3ActBpTaskView:removeEvents()
	return
end

function Anniversary3ActBpTaskView:_editableInitView()
	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3ActBp
	self._bpId = Anniversary3ActBpModel.instance:getCurBpId(self._actId)
	self._taskLoopType = Anniversary3ActBpEnum.TaskType.Weekly
	self._taskItems = self:getUserDataTb_()

	self:_initUI()
	self:_initReddot()
	self:_addSelfEvents()
end

function Anniversary3ActBpTaskView:_initReddot()
	RedDotController.instance:addRedDot(self._goreddot1, RedDotEnum.DotNode.V3a7Anniversary3ActBpSubTask, TaskEnum.TaskLoopType.Weekly)
	RedDotController.instance:addRedDot(self._goreddot2, RedDotEnum.DotNode.V3a7Anniversary3ActBpSubTask, TaskEnum.TaskLoopType.Permanent)
end

function Anniversary3ActBpTaskView:_initUI()
	gohelper.setActive(self._gotaskitem, false)

	self._gotoggleGroup = gohelper.findChild(self._gotaskview, "root/toggleGroup")
	self._toggleGroup = self._gotoggleGroup:GetComponent(typeof(UnityEngine.UI.ToggleGroup))
	self._toggleTabs = self:getUserDataTb_()

	for i = 1, self._gotoggleGroup.transform.childCount do
		self._toggleTabs[i] = self._toggleTabs[i] or {}

		local childTrs = self._gotoggleGroup.transform:GetChild(i - 1)

		self._toggleTabs[i].go = childTrs.gameObject
		self._toggleTabs[i].toggle = self._toggleTabs[i].go:GetComponent(typeof(UnityEngine.UI.Toggle))
		self._toggleTabs[i].toggleWrap = gohelper.onceAddComponent(self._toggleTabs[i].go, typeof(SLFramework.UGUI.ToggleWrap))

		self._toggleTabs[i].toggleWrap:AddOnValueChanged(self._onToggleValueChanged, self, i)
	end

	self:_onToggleValueChanged(1, true)
end

function Anniversary3ActBpTaskView:_onToggleValueChanged(toggleId, isOn)
	if not isOn then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_second_tabs_click)

	if toggleId == 1 then
		if not Anniversary3ActBpEnum.TaskType.Weekly then
			local loopType = TaskEnum.TaskLoopType.Permanent

			if self._taskLoopType == loopType then
				return
			end

			self._taskLoopType = loopType

			self:_refreshTaskItems()
		end
	end
end

function Anniversary3ActBpTaskView:_addSelfEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._onTaskUpdate, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._refresh, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnDeleteTask, self._onTaskDelete, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.onReceiveFinishReadTaskReply, self._refresh, self)
end

function Anniversary3ActBpTaskView:_removeSelfEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._onTaskUpdate, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._refresh, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnDeleteTask, self._onTaskDelete, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.onReceiveFinishReadTaskReply, self._refresh, self)
end

function Anniversary3ActBpTaskView:_onTaskUpdate(msg)
	self:_refresh()
end

function Anniversary3ActBpTaskView:_onTaskDelete(msg)
	self:_refresh()
end

function Anniversary3ActBpTaskView:onOpen()
	self:_refresh()
end

function Anniversary3ActBpTaskView:_refresh()
	self:_refreshTaskItems()
end

function Anniversary3ActBpTaskView:finishAllTask()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActBp)
end

function Anniversary3ActBpTaskView:_refreshTaskItems()
	local taskList = Anniversary3ActBpModel.instance:getAllTaskByType(self._taskLoopType, self._bpId, self._actId)

	if #taskList < #self._taskItems then
		for i = #taskList + 1, #self._taskItems do
			self._taskItems[i]:showItem(false)
		end
	end

	for index, task in ipairs(taskList) do
		if not self._taskItems[index] then
			self._taskItems[index] = Anniversary3ActBpTaskItem.New()

			local go = gohelper.cloneInPlace(self._gotaskitem)

			self._taskItems[index]:init(go)
		end

		self._taskItems[index]:showItem(true)
		self._taskItems[index]:refresh(task)
	end
end

function Anniversary3ActBpTaskView:onClose()
	return
end

function Anniversary3ActBpTaskView:onDestroyView()
	if self._toggleTabs then
		for _, tab in pairs(self._toggleTabs) do
			if tab.toggleWrap then
				tab.toggleWrap:RemoveOnValueChanged()
			end
		end

		self._toggleTabs = nil
	end

	if self._taskItems then
		for _, item in pairs(self._taskItems) do
			item:destroy()
		end

		self._taskItems = nil
	end

	self:_removeSelfEvents()
end

return Anniversary3ActBpTaskView
