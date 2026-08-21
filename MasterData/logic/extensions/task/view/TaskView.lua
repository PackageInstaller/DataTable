-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskView.lua

module("logic.extensions.task.view.TaskView", package.seeall)

local M = class("TaskView", ViewComponent)
local timeInterval = 20

function M:buildUI()
	self._btnTodayTask = self:getBtn("right_tab_content_-242000516")
	self._btnWeekTask = self:getBtn("right_tab_content_-1578871314")
	self._btnExtraTask = self:getBtn("right_tab_content_1651451756")
	self._btnLimitTimeTask = self:getBtn("right_tab_content_-1691267181")
	self._txtLimitTime1 = self:getText("task_main_view_copy_-1187977297")
	self._txtLimitTime2 = self:getText("task_main_view_copy_-926291960")
	self._togDayTask = self:getUIComponent("right_tab_content_-242000516", UIComponentType.SpaceXToggle)
	self._panelGo1 = self:getGo("task_main_view_-1109592363")
	self._scoreScroll = LoopListHelper.New(self:getGo("task_main_view_-715583701"))

	self._scoreScroll:InitListView(0, self._updateScroeData, self)

	self._taskScorll1 = LoopListHelper.New(self:getGo("task_main_view_-366142472"))

	self._taskScorll1:InitListView(0, self._updateTask1Data, self)

	self._txtDoneNum = self:getText("task_main_view_-418970317")
	self._btnGetAll = self:getBtn("task_main_view_-842882604")
	self._txtScore = self:getText("task_main_view_-1410649820")
	self._imgScore = self:getImage("task_main_view_-2085608513")
	self._panelGo2 = self:getGo("task_main_view_-1628829401")
	self._taskScorll2 = LoopListHelper.New(self:getGo("task_main_view_-1752512532"))

	self._taskScorll2:InitListView(0, self._updateTask2Data, self)

	self._txtTime = self:getText("task_main_view_-1169544822")
	self._txtDoneNum2 = self:getText("task_main_view_-1016742040")
	self._btnGetAll2 = self:getBtn("task_main_view_-1526301330")
end

function M:destroyUI()
	self._btnTodayTask = nil
	self._btnWeekTask = nil
	self._btnExtraTask = nil
	self._btnLimitTimeTask = nil
	self._panelGo1 = nil

	self._scoreScroll:Dispose()

	self._scoreScroll = nil

	self._taskScorll1:Dispose()

	self._taskScorll1 = nil
	self._txtDoneNum = nil
	self._btnGetAll = nil
	self._panelGo2 = nil

	self._taskScorll2:Dispose()

	self._taskScorll2 = nil
	self._txtTime = nil
	self._txtDoneNum2 = nil
	self._btnGetAll2 = nil
	self._togDayTask = nil
	self._txtScore = nil
	self._imgScore = nil
end

function M:bindEvents()
	self._btnTodayTask:AddClickListener(self._onClickTodayTask, self)
	self._btnWeekTask:AddClickListener(self._onClickWeekTask, self)
	self._btnExtraTask:AddClickListener(self._onClickExtraTask, self)
	self._btnLimitTimeTask:AddClickListener(self._onClickLimitTimeTask, self)
	self._btnGetAll:AddClickListener(self._onClickGetAll, self)
	self._btnGetAll2:AddClickListener(self._onClickGetAll2, self)
	GlobalDispatcher:addEventListener(EventType.UPDATA_TASKS, self._onUpdateTask, self)
	GlobalDispatcher:addEventListener(EventType.TASK_TAKE_REWARD_SUC, self._onUpdateTaskReward, self)
	GlobalDispatcher:addEventListener(EventType.UPDATE_TASK_POINT_EVENT, self._onUpdateTaskPointList, self)
end

function M:unbindEvents()
	self._btnTodayTask:RemoveClickListener()
	self._btnWeekTask:RemoveClickListener()
	self._btnExtraTask:RemoveClickListener()
	self._btnLimitTimeTask:RemoveClickListener()
	self._btnGetAll:RemoveClickListener()
	self._btnGetAll2:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.UPDATA_TASKS, self._onUpdateTask, self)
	GlobalDispatcher:removeEventListener(EventType.TASK_TAKE_REWARD_SUC, self._onUpdateTaskReward, self)
	GlobalDispatcher:removeEventListener(EventType.UPDATE_TASK_POINT_EVENT, self._onUpdateTaskPointList, self)
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Task)

	self._remainSeconds = false

	TaskModel.instance:initPointDatByCfg()

	self._selectTaskType = TaskEnum.TaskType.Daily
	self._curTaskList = false

	self:_initLimitTask()
end

function M:onEnterFinished()
	return
end

function M:onExit()
	self._togDayTask.IsOn = true

	self._scoreScroll:ClearCells()
	self._taskScorll1:ClearCells()
	self._taskScorll2:ClearCells()

	self._selectTaskType = false
	self._curTaskList = false

	TaskModel.instance:clearCache()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Task)
	self:_stopCounter()
end

function M:_onUpdateTaskReward(key, bubbleType)
	return
end

function M:_onUpdateTask(key, resetPos)
	local tabId = TaskModel.instance:getTabIdByType(self._selectTaskType)
	local hasRewardBox = self._selectTaskType == TaskEnum.TaskType.Daily or TaskEnum.TaskType.Weekly == self._selectTaskType

	if hasRewardBox then
		goutil.setActive(self._panelGo1, true)
		goutil.setActive(self._panelGo2, false)
	else
		goutil.setActive(self._panelGo1, false)
		goutil.setActive(self._panelGo2, true)
	end

	if tabId then
		self._curTaskList = TaskModel.instance:getTaskList(tabId)

		local tempList = self:_getCanRewardTask()

		if hasRewardBox then
			goutil.setActive(self._btnGetAll.gameObject, #tempList > 0)

			if resetPos then
				self._taskScorll1:ClearCells()
			end

			if self._curTaskList then
				local len = #self._curTaskList

				self._taskScorll1:SetListItemCount(len, resetPos)
			end

			if not resetPos then
				self._taskScorll1:RefreshAllShownItem()
			end

			local count = TaskUtil.getFinishCount(self._curTaskList)

			self._txtDoneNum.text = string.format("%s/%s", count, #self._curTaskList)
			self._curPointList = TaskModel.instance:getPointList(tabId)

			if self._curPointList then
				if resetPos then
					self._scoreScroll:ClearCells()
				end

				local boxLen = #self._curPointList

				self._scoreScroll:SetListItemCount(boxLen, resetPos)

				if not resetPos then
					self._scoreScroll:RefreshAllShownItem()
				end

				self._txtScore.text = TaskModel.instance:getCurPoint(tabId)
			end
		else
			local offsetTime = false

			goutil.setActive(self._btnGetAll2.gameObject, #tempList > 0)

			if self._selectTaskType == TaskEnum.TaskType.Challenge then
				offsetTime = self:_getNextMonthFirstDay()
			elseif self._selectTaskType == TaskEnum.TaskType.Limited then
				local canOnLine = false
				local tabCo = TaskConfig.instance:getTaskLabelCO(tabId)

				if tabCo then
					offsetTime, canOnLine = self:_getLimitTime(tabCo)
				end

				self._limitTaskTime = offsetTime

				goutil.setActive(self._btnLimitTimeTask.gameObject, canOnLine)

				if not canOnLine then
					self:_onClickTodayTask()

					self._togDayTask.IsOn = true
				end
			end

			if offsetTime then
				self._remainSeconds = tonumber(offsetTime)

				self:_startCounter()
				self:_updateTimeView()
			end

			local count = TaskUtil.getFinishCount(self._curTaskList)

			self._txtDoneNum2.text = string.format("完成任务:%s", count)

			if self._curTaskList then
				if resetPos then
					self._taskScorll2:ClearCells()
				end

				local len = #self._curTaskList

				self._taskScorll2:SetListItemCount(len, resetPos)
			end

			if not resetPos then
				self._taskScorll2:RefreshAllShownItem()
			end
		end
	else
		printWarn("cloud not found task tabid with type:", self._selectTaskType)
	end
end

function M:_initLimitTask()
	local canOnLine = false
	local tabId = TaskModel.instance:getTabIdByType(TaskEnum.TaskType.Limited)
	local tabCo = TaskConfig.instance:getTaskLabelCO(tabId)

	if tabCo then
		self._limitTaskTime, canOnLine = self:_getLimitTime(tabCo)
	end

	goutil.setActive(self._btnLimitTimeTask.gameObject, canOnLine)

	if canOnLine and self._limitTaskTime then
		self:_startCounter()
		self:_updateTimeView()
	end
end

function M:_onClickTodayTask()
	self._selectTaskType = TaskEnum.TaskType.Daily

	self:_onUpdateTask(nil, true)
end

function M:_onClickWeekTask()
	self._selectTaskType = TaskEnum.TaskType.Weekly

	self:_onUpdateTask(nil, true)
end

function M:_onClickExtraTask()
	self._selectTaskType = TaskEnum.TaskType.Challenge

	self:_onUpdateTask(nil, true)
end

function M:_onClickLimitTimeTask()
	self._selectTaskType = TaskEnum.TaskType.Limited

	self:_onUpdateTask(nil, true)
end

function M:_onClickGetAll()
	self:_oneKeyGetAll()
end

function M:_onClickGetAll2()
	self:_oneKeyGetAll()
end

function M:_oneKeyGetAll()
	local tempList = self:_getCanRewardTask()

	if #tempList > 0 then
		-- block empty
	else
		FloatWordMgr.instance:show(lang("tip_task_no_finish_data"))
	end

	if self:_checkBackpackLimit() then
		local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_warehouse_undercapacity"))

		dialog:setConfirmButtonText(lang("tip_common_sure"))
	end
end

function M:_getCanRewardTask()
	local tempList = {}

	if self._curTaskList then
		for index, taskMo in ipairs(self._curTaskList) do
			if taskMo:canGetReward() and not taskMo:getIsFinish() then
				table.insert(tempList, taskMo:getTaskId())
			end
		end
	end

	return tempList
end

function M:_updateScroeData(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._scoreScroll:NewListViewItem("score_item")

	if self._curPointList then
		local itemData = self._curPointList[curIndex]

		if itemData then
			local preFinish = false
			local isLast = curIndex == #self._curPointList

			if curIndex > 1 then
				local data = self._curPointList[curIndex - 1]

				if data:getFinish() or data:canGetReward() then
					preFinish = true
				end
			end

			local shower = Astral.LuaComponentContainer.Add(item.gameObject, TaskPointItem)

			shower:setCellData(itemData, curIndex, preFinish, isLast)
			shower:setClickCallBack(self._clickScoreItem, self)
		end
	end

	return item
end

function M:_clickScoreItem(data)
	if data:canGetReward() and not data:getFinish() then
		-- block empty
	end
end

function M:_onUpdateTaskPointList(evt)
	local tabId = TaskModel.instance:getTabIdByType(self._selectTaskType)

	self._curPointList = TaskModel.instance:getPointList(tabId)

	if self._curPointList then
		local boxLen = #self._curPointList

		self._scoreScroll:SetListItemCount(boxLen, false)
		self._scoreScroll:RefreshAllShownItem()
	end
end

function M:_updateTask1Data(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._taskScorll1:NewListViewItem("task_item1_copy")

	if self._curTaskList then
		local itemData = self._curTaskList[curIndex]

		if itemData then
			local shower = Astral.LuaComponentContainer.Add(item.gameObject, TaskItem1)

			shower:setCellData(itemData, curIndex)
			shower:setGotoClick(self._clickGoto, self)
		end
	end

	return item
end

function M:_updateTask2Data(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._taskScorll2:NewListViewItem("task_item2_copy")

	if self._curTaskList then
		local itemData = self._curTaskList[curIndex]

		if itemData then
			local shower = Astral.LuaComponentContainer.Add(item.gameObject, TaskItem2)

			shower:setCellData(itemData, curIndex)
			shower:setGotoClick(self._clickGoto, self)
		end
	end

	return item
end

function M:_clickGoto()
	return
end

function M:_getNextMonthFirstDay()
	local nowData = ServerTime.nowDate()
	local curTimeTs = ServerTime.now()
	local month = nowData.month + 1

	if nowData.day == 1 and nowData.hour < 5 then
		month = nowData.month
	end

	local nextMonthFirstDayTS = os.time({
		hour = 5,
		min = 0,
		sec = 0,
		day = 1,
		year = nowData.year,
		month = month
	})
	local offset = nextMonthFirstDayTS - curTimeTs

	return offset
end

function M:_getLimitTime(labelCo)
	local canOnLine = false
	local beginT = false
	local endT = false
	local startTime = labelCo.startTime
	local endTime = labelCo.endTime
	local offsetTime = false

	if not string.nilorempty(startTime) then
		beginT = TimeUtil.instance:dateStr2TimeStamp(startTime)
	end

	if not string.nilorempty(endTime) then
		endT = TimeUtil.instance:dateStr2TimeStamp(endTime)
	end

	if beginT then
		if endT then
			if endT > ServerTime.now() and beginT <= ServerTime.now() then
				canOnLine = true
				offsetTime = endT - ServerTime.now()
			end
		elseif beginT <= ServerTime.now() then
			canOnLine = true
		end
	elseif endT then
		if endT > ServerTime.now() then
			canOnLine = true
			offsetTime = endT - ServerTime.now()
		end
	else
		canOnLine = true
	end

	return offsetTime, canOnLine
end

function M:_startCounter()
	if not self._remainSeconds and not self._limitTaskTime then
		return
	end

	if self._isStartCount then
		return
	end

	self:_stopCounter()

	self._isStartCount = true

	Scheduler.addListener(1, self._onSecond, self, true)
end

function M:_stopCounter()
	if not self._isStartCount then
		return
	end

	self._isStartCount = false

	Scheduler.removeListener(self._onSecond, self)
end

function M:_updateTimeView()
	if self._remainSeconds then
		local content = string.format("<color=%s>%s</color>后刷新", self:_getTimeColor(self._remainSeconds), TextFormatter.formatFullTime(self._remainSeconds, true))

		self._txtTime.text = content
	end

	if self._limitTaskTime then
		local tabTime = string.format("剩余%s", TextFormatter.formatFullTime(self._limitTaskTime, true))

		self._txtLimitTime1.text = tabTime
		self._txtLimitTime2.text = tabTime
	end
end

function M:_getTimeColor(secound)
	if secound then
		return secound > 3600 and "#FFFFFF" or "#ff3e48"
	end

	return "#FFFFFF"
end

function M:_onSecond()
	if self._remainSeconds then
		self._remainSeconds = self._remainSeconds - 1

		self:_updateTimeView()

		if self._remainSeconds <= 0 then
			if not self._limitTaskTime or self._limitTaskTime <= 0 then
				self:_stopCounter()
			end

			self._txtTime.text = ""
		end
	end

	if self._limitTaskTime then
		self._limitTaskTime = self._limitTaskTime - 1

		self:_updateTimeView()

		if self._limitTaskTime <= 0 then
			if not self._remainSeconds or self._remainSeconds <= 0 then
				self:_stopCounter()
			end

			goutil.setActive(self._btnLimitTimeTask.gameObject, false)
			self:_onClickTodayTask()

			self._togDayTask.IsOn = true
			self._limitTaskTime = false
		end
	end
end

function M:_checkBackpackLimit()
	local equipMaxCount = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.EquipItemType, "EquipmentBackpackCapacity")
	local curEquipCount = ItemModel.instance:getItemCountByTS(GameEnum.ItemTypeEnum.EquipItemType, 0)
	local echoMaxCount = PlayerModel.instance:getBackpackLimit(GameEnum.ItemTypeEnum.EchoItemType, "EchoItemBackpackCapacity")
	local curEchoCount = ItemModel.instance:getItemCountByTS(GameEnum.ItemTypeEnum.EchoItemType, 0)

	if equipMaxCount <= curEquipCount or echoMaxCount <= curEchoCount then
		return true
	end

	return false
end

return M
