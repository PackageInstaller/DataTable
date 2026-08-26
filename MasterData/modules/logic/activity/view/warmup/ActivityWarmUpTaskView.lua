-- chunkname: @modules/logic/activity/view/warmup/ActivityWarmUpTaskView.lua

module("modules.logic.activity.view.warmup.ActivityWarmUpTaskView", package.seeall)

local ActivityWarmUpTaskView = class("ActivityWarmUpTaskView", BaseView)

function ActivityWarmUpTaskView:onInitView()
	self._gotaskitemcontent = gohelper.findChild(self.viewGO, "#scroll_task/viewport/#go_taskitemcontent")
	self._godayitem = gohelper.findChild(self.viewGO, "#scroll_days/Viewport/Content/#go_dayitem")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityWarmUpTaskView:addEvents()
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnclose:AddClickListener(self._btncloseviewOnClick, self)
end

function ActivityWarmUpTaskView:removeEvents()
	self._btncloseview:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function ActivityWarmUpTaskView:_editableInitView()
	self._taskItems = {}
	self._taskDayTabs = {}
end

function ActivityWarmUpTaskView:onDestroyView()
	for _, item in pairs(self._taskItems) do
		gohelper.setActive(item.go, true)
	end

	for _, item in pairs(self._taskDayTabs) do
		item.btn:RemoveClickListener()
	end
end

function ActivityWarmUpTaskView:onOpen()
	local openIndex = self.viewParam.index

	self.addEventCb(self, ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListUpdated, self.refreshUI, self)
	self.addEventCb(self, ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskDayChanged, self.refreshUI, self)
	self.addEventCb(self, ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListNeedClose, self.closeThis, self)
	ActivityWarmUpTaskController.instance:init(self.viewParam.actId, openIndex)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity106
	})
end

function ActivityWarmUpTaskView:onClose()
	ActivityWarmUpTaskController.instance:release()
end

function ActivityWarmUpTaskView:_btncloseviewOnClick()
	self:closeThis()
end

function ActivityWarmUpTaskView:refreshUI()
	self:refreshList()
	self:refreshTab()
end

function ActivityWarmUpTaskView:refreshList()
	local dataList = ActivityWarmUpTaskListModel.instance:getList()
	local maxIndex = math.max(#dataList, #self._taskItems)

	for i = 1, maxIndex do
		local mo = dataList[i]
		local item = self:getOrCreateTaskItem(i)

		if mo then
			gohelper.setActive(item.go, true)
			item.component:onUpdateMO(mo)
		else
			gohelper.setActive(item.go, false)
		end
	end
end

function ActivityWarmUpTaskView:refreshTab()
	local totalDay = ActivityWarmUpModel.instance:getTotalContentDays()
	local curDay = ActivityWarmUpModel.instance:getCurrentDay()
	local selectedDay = ActivityWarmUpTaskListModel.instance:getSelectedDay()

	for i = 1, totalDay do
		local item = self:getOrCreateTaskDayTab(i)

		UISpriteSetMgr.instance:setActivityWarmUpSprite(item.imageChooseDay, "bg_rw" .. i)

		item.txtUnchooseDay.text = tostring(i)
		item.txtLockDay.text = tostring(i)

		if i <= curDay then
			gohelper.setActive(item.goLock, false)
			gohelper.setActive(item.goUnchoose, selectedDay ~= i)
			gohelper.setActive(item.goChoose, selectedDay == i)
		else
			gohelper.setActive(item.goLock, true)
		end

		local hasReward = ActivityWarmUpTaskListModel.instance:dayHasReward(i)

		gohelper.setActive(item.goreddot, hasReward)
	end
end

function ActivityWarmUpTaskView:getOrCreateTaskItem(index)
	local item = self._taskItems[index]

	if not item then
		item = self:getUserDataTb_()

		local path = self.viewContainer:getSetting().otherRes[1]
		local childGO = self:getResInst(path, self._gotaskitemcontent, "task_item" .. tostring(index))
		local contentItem = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, ActivityWarmUpTaskItem)

		contentItem:initData(index, childGO)

		item.go = childGO
		item.component = contentItem
		self._taskItems[index] = item
	end

	return item
end

function ActivityWarmUpTaskView:getOrCreateTaskDayTab(index)
	local item = self._taskDayTabs[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._godayitem, "tabday_" .. tostring(index))

		item.go = go
		item.goUnchoose = gohelper.findChild(go, "go_unselected")
		item.goChoose = gohelper.findChild(go, "go_selected")
		item.txtUnchooseDay = gohelper.findChildText(go, "go_unselected/txt_index")
		item.imageChooseDay = gohelper.findChildImage(go, "go_selected/img_index")
		item.goreddot = gohelper.findChild(go, "go_reddot")
		item.goLock = gohelper.findChild(go, "go_lock")
		item.txtLockDay = gohelper.findChildText(go, "go_lock/txt_index")
		item.btn = gohelper.findChildButtonWithAudio(go, "btn_click")

		item.btn:AddClickListener(ActivityWarmUpTaskView.onClickTabItem, {
			self = self,
			index = index
		})
		gohelper.setActive(item.go, true)

		self._taskDayTabs[index] = item
	end

	return item
end

function ActivityWarmUpTaskView.onClickTabItem(param)
	local index = param.index
	local selectedDay = ActivityWarmUpTaskListModel.instance:getSelectedDay()
	local curDay = ActivityWarmUpModel.instance:getCurrentDay()
	local orders = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if selectedDay ~= index and index <= curDay then
		ActivityWarmUpTaskController.instance:changeSelectedDay(index)
	end
end

return ActivityWarmUpTaskView
