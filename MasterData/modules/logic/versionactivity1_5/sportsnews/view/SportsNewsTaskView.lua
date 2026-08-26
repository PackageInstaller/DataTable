-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsTaskView.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTaskView", package.seeall)

local SportsNewsTaskView = class("SportsNewsTaskView", BaseView)

function SportsNewsTaskView:onInitView()
	self._scrolltablist = gohelper.findChildScrollRect(self.viewGO, "#scroll_tablist")
	self._simagepaperbg = gohelper.findChildSingleImage(self.viewGO, "#simage_paperbg")
	self._scrolltasklist = gohelper.findChildScrollRect(self.viewGO, "#scroll_tasklist")
	self._gotaskitemcontent = gohelper.findChild(self.viewGO, "#scroll_tasklist/Viewport/task")
	self._gotabitemcontent = gohelper.findChild(self.viewGO, "#scroll_tablist/Viewport/content")
	self._btnclosebtn = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closebtn")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SportsNewsTaskView:addEvents()
	self._btnclosebtn:AddClickListener(self._btnclosebtnOnClick, self)
	self._btnclose:AddClickListener(self._btnclosebtnOnClick, self)
end

function SportsNewsTaskView:removeEvents()
	self._btnclosebtn:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function SportsNewsTaskView:_btnclosebtnOnClick()
	self:closeThis()
end

function SportsNewsTaskView:_editableInitView()
	self._taskItems = {}
	self._taskDayTabs = {}
end

function SportsNewsTaskView:onDestroyView()
	for _, item in pairs(self._taskItems) do
		gohelper.setActive(item.go, true)
	end

	for _, item in pairs(self._taskDayTabs) do
		item:onDestroyView()
	end
end

function SportsNewsTaskView:onOpen()
	local openIndex = self.viewParam.index

	self.addEventCb(self, ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListInit, self.taskListInit, self)
	self.addEventCb(self, ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListUpdated, self.refreshUI, self)
	self.addEventCb(self, ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskDayChanged, self.refreshUI, self)
	self.addEventCb(self, ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListNeedClose, self.closeThis, self)
	ActivityWarmUpTaskController.instance:init(self.viewParam.actId, openIndex)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity106
	})
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	self.jumpTab = SportsNewsModel.instance:getJumpToTab(self.viewParam.actId)

	if self.jumpTab then
		ActivityWarmUpTaskListModel.instance:init(self.viewParam.actId)
		ActivityWarmUpTaskController.instance:changeSelectedDay(self.jumpTab)
	end
end

function SportsNewsTaskView:onClose()
	self.removeEventCb(self, ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListInit, self.taskListInit, self)
	self.removeEventCb(self, ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListUpdated, self.refreshUI, self)
	self.removeEventCb(self, ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskDayChanged, self.refreshUI, self)
	self.removeEventCb(self, ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListNeedClose, self.closeThis, self)
	ActivityWarmUpTaskController.instance:release()

	if self._taskItems then
		for _, item in pairs(self._taskItems) do
			item:onClose()
			TaskDispatcher.cancelTask(function()
				item:_playOpenInner()
			end)
		end
	end
end

function SportsNewsTaskView:onClickModalMask()
	self:closeThis()
end

function SportsNewsTaskView:refreshUI()
	self:refreshList()
	self:refreshTab()
end

function SportsNewsTaskView:taskListInit()
	if self._taskItems then
		for i, item in pairs(self._taskItems) do
			local time = (i - 1) * 0.06

			TaskDispatcher.runDelay(function()
				item:_playOpenInner()
			end, self, time)
		end
	end
end

function SportsNewsTaskView:refreshList()
	local dataList = ActivityWarmUpTaskListModel.instance:getList()
	local maxIndex = math.max(#dataList, #self._taskItems)

	for i = 1, maxIndex do
		local mo = dataList[i]
		local item = self:getOrCreateTaskItem(i)

		if mo then
			item:onUpdateMO(mo)
		else
			gohelper.setActive(item.go, false)
		end
	end
end

function SportsNewsTaskView:refreshTab()
	local totalDay = ActivityWarmUpModel.instance:getTotalContentDays()

	for i = 1, totalDay do
		local item = self:getOrCreateTaskDayTab(i)

		item:onRefresh()

		local hasReward = ActivityWarmUpTaskListModel.instance:dayHasReward(i)

		gohelper.setActive(item.goreddot, hasReward)
	end
end

function SportsNewsTaskView:getOrCreateTaskItem(index)
	local item = self._taskItems[index]

	if not item then
		item = self:getUserDataTb_()

		local path = self.viewContainer:getSetting().otherRes[1]
		local childGO = self:getResInst(path, self._gotaskitemcontent, "task_item" .. tostring(index))

		item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, SportsNewsTaskItem)

		item:initData(index, childGO, self)

		self._taskItems[index] = item
	end

	return item
end

function SportsNewsTaskView:getOrCreateTaskDayTab(index)
	local item = self._taskDayTabs[index]

	if not item then
		item = self:getUserDataTb_()

		local path = self.viewContainer:getSetting().otherRes[2]
		local childGO = self:getResInst(path, self._gotabitemcontent, "tab_item" .. tostring(index))

		item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, SportsNewsTaskPageTabItem)

		item:initData(index, childGO)

		self._taskDayTabs[index] = item
	end

	return item
end

return SportsNewsTaskView
