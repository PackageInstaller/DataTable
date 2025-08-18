-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\TaskMixin.lua

local ResClientTaskGroup = require("ClientData/ResClientTaskGroup")
local ResTask = require("ClientData/ResTask")
local EventConst = require("EventConst")
local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local ResAdvanceTask = require("ClientData/ResAdvanceTask")
local ResAdvanceStep = require("ClientData/ResAdvanceStep")
local ResAdvanceMisc = require("ClientData/ResAdvanceMisc")
local AWARD_GET_CD = 5
local TaskMixin = {}

function TaskMixin:initTaskMixin(baseData, syncData)
	return
end

function TaskMixin:postinitTaskMixin(baseData, syncData)
	local serverTaskData = syncData.other.task

	self:_initTaskData(serverTaskData)
	self:_initClientTaskGroup()

	local advanceTaskData = syncData.other.advance

	self:_initAdvanceTask(advanceTaskData)
end

function TaskMixin:destroyTaskMixin()
	return
end

function TaskMixin:_initTaskData(svrTaskData)
	self.dailyTaskList = {}
	self.weeklyTaskList = {}
	self.newbieTaskList = {}
	self.taskIndexData = {}
	self.taskProgressData = {}
	self.taskStatusData = {}

	for index, dailyTasks in ipairs(svrTaskData.daily_task) do
		local taskData = dailyTasks.data
		local taskId = taskData.task_id

		table.insert(self.dailyTaskList, taskId)

		self.taskIndexData[taskId] = index - 1

		self:_updateTaskData(taskData)
	end

	for index, weekTasks in ipairs(svrTaskData.week_task) do
		local taskData = weekTasks.data
		local taskId = taskData.task_id

		table.insert(self.weeklyTaskList, taskId)

		self.taskIndexData[taskId] = index - 1

		self:_updateTaskData(taskData)
	end

	for index, newbieTasks in ipairs(svrTaskData.newbie_task) do
		local taskData = newbieTasks.data
		local taskId = taskData.task_id

		table.insert(self.newbieTaskList, taskId)

		self.taskIndexData[taskId] = index - 1

		self:_updateTaskData(taskData)
	end

	self:_refreshRedDotMain()

	self.taskDataInited = true
end

function TaskMixin:_initClientTaskGroup(...)
	self.parent2ChildrenDict = {}
	self.child2ParentDict = {}
	self.mainTaskClientInfo = {}

	for id, info in pairs(ResClientTaskGroup) do
		local parentTaskId = info.main_task
		local childTaskIdList = info.sub_task

		self.parent2ChildrenDict[parentTaskId] = childTaskIdList

		for _, childTaskId in ipairs(childTaskIdList) do
			self.child2ParentDict[childTaskId] = parentTaskId
		end

		if id == Const.DAILY_TASK_GROUPID then
			self.dailyMainTask = parentTaskId
		elseif id == Const.WEEKLY_TASK_GROUPID then
			self.weeklyMainTask = parentTaskId
		elseif id > 100 and id ~= 106 then
			if not self.newbieMainTasks then
				self.newbieMainTasks = {}
			end

			self.newbieMainTasks[id - 100] = parentTaskId
		end

		local parentTaskInfo = ResTask[parentTaskId]
		local resParam = parentTaskInfo.action_param

		if resParam ~= #childTaskIdList and id ~= 2 then
			-- block empty
		end

		self.mainTaskClientInfo[parentTaskId] = {
			heroId = info.hero_id,
			itemId = info.item_id,
			iconPath = info.big_icon_path,
			icon = info.big_icon,
			unlockDesc = info.unlock_desc
		}
	end

	self:_refreshRedDotMain(Const.TASK_TYPE.NEWBIE)
end

local function checkAwardCD(lastTick)
	if lastTick ~= nil and Time.time - lastTick < AWARD_GET_CD then
		return false
	end

	return true
end

function TaskMixin:getDailyTaskAward(taskId)
	if not checkAwardCD(self.lastGetDailyAwardTick) then
		return
	end

	local typeCode = Const.TASK_TYPE.DAILY
	local index = self.taskIndexData[taskId]

	if index >= 0 then
		RPC.taskGetAward(typeCode, index)

		self.lastGetDailyAwardTick = Time.time
	end
end

function TaskMixin:getAllDailyTask(taskIds)
	if not checkAwardCD(self.lastGetWeeklyAwardTick) then
		return
	end

	local indexList = {}

	for _, taskId in ipairs(taskIds) do
		local index = self.taskIndexData[taskId]

		if index >= 0 then
			table.insert(indexList, index)
		end
	end

	if #indexList > 0 then
		RPC.taskGetAllDailyAward(indexList)
	end
end

function TaskMixin:getWeeklyTaskAward(taskId)
	if not checkAwardCD(self.lastGetWeeklyAwardTick) then
		return
	end

	local typeCode = Const.TASK_TYPE.WEEKLY
	local index = self.taskIndexData[taskId]

	if index >= 0 then
		RPC.taskGetAward(typeCode, index)

		self.lastGetWeeklyAwardTick = Time.time
	end
end

function TaskMixin:getNewbieTaskAward(taskId)
	if not checkAwardCD(self.lastGetNewbieAwardTick) then
		return
	end

	local typeCode = Const.TASK_TYPE.NEWBIE
	local index = self.taskIndexData[taskId]

	if index >= 0 then
		RPC.taskGetAward(typeCode, index)

		self.lastGetNewbieAwardTick = Time.time
	end
end

function TaskMixin:onTaskGetAwardResp(typeCode, index)
	return
end

function TaskMixin:onTaskUpdateNotify(typeCode, task)
	self:_updateTaskData(task)
	self:refreshTaskDlgs(typeCode, false)
	self:_refreshRedDotMain(typeCode)

	if typeCode == Const.TASK_TYPE.DAILY then
		self.lastGetDailyAwardTick = nil
	elseif typeCode == Const.TASK_TYPE.WEEKLY then
		self.lastGetWeeklyAwardTick = nil
	else
		self.lastGetNewbieAwardTick = nil
	end
end

function TaskMixin:onTaskRefreshNotify(typeCode, task)
	local indexList

	if typeCode == Const.TASK_TYPE.DAILY then
		indexList = self.dailyTaskList
	elseif typeCode == Const.TASK_TYPE.WEEKLY then
		indexList = self.weeklyTaskList
	elseif typeCode == Const.TASK_TYPE.NEWBIE then
		indexList = self.newbieTaskList
	end

	for i, taskId in ipairs(indexList) do
		self.taskIndexData[taskId] = nil
	end

	indexList = {}

	for index, taskData in ipairs(task) do
		local taskId = taskData.task_id

		table.insert(indexList, taskId)

		self.taskIndexData[taskId] = index - 1

		self:_updateTaskData(taskData)
	end

	self:refreshTaskDlgs(typeCode, false)
	self:_refreshRedDotMain(typeCode)
end

function TaskMixin:onTaskAcceptNotify(typeCode, taskList)
	local indexList

	if typeCode == Const.TASK_TYPE.DAILY then
		indexList = self.dailyTaskList
	elseif typeCode == Const.TASK_TYPE.WEEKLY then
		indexList = self.weeklyTaskList
	elseif typeCode == Const.TASK_TYPE.NEWBIE then
		indexList = self.newbieTaskList
	end

	for i, task in ipairs(taskList) do
		local id = task.task_id

		table.insert(indexList, id)

		self.taskIndexData[id] = #indexList - 1

		self:_updateTaskData(task)
	end

	self:refreshTaskDlgs(typeCode, true)
	self:_refreshRedDotMain(typeCode)
end

function TaskMixin:_updateTaskData(taskData)
	local id = taskData.task_id
	local progress = taskData.value
	local status = taskData.status

	self.taskProgressData[id] = progress

	if self.taskDataInited then
		local oldStatus = self:getTaskStatus(id)

		if oldStatus ~= status then
			if status == Const.TASK_STATUS.COMPLETE then
				ConditionLimitManager.triggerTaskUnlock(id, Const.CONDITION_TASK_QUALIFY_UNLOCK)
			elseif status == Const.TASK_STATUS.AWARD_GOT then
				ConditionLimitManager.triggerTaskUnlock(id, Const.CONDITION_TASK_GOT_UNLOCK)
			end
		end

		if id == DrawCardConfig.NEWBIE_DRAWCARD_TASKID then
			self:refreshNewbiePoolReddot()
		end
	end

	self.taskStatusData[id] = status
end

function TaskMixin:getTaskStatus(taskId)
	return self.taskStatusData[taskId] or Const.TASK_STATUS.NOT_ACTIVE
end

function TaskMixin:getTaskProcess(taskId)
	local nowProcess = self.taskProgressData[taskId] or 0
	local taskInfo = ResTask[taskId]

	if not taskInfo then
		return nowProcess, 1
	end

	local needFixType = self:_taskTypeNeedFix(taskInfo.action_type)
	local status = self:getTaskStatus(taskId)
	local totalProcess
	local isQualify = status == Const.TASK_STATUS.COMPLETE or status == Const.TASK_STATUS.AWARD_GOT

	if needFixType then
		totalProcess = 1

		if isQualify then
			nowProcess = 1
		else
			nowProcess = 0
		end
	else
		totalProcess = taskInfo.action_param or 1

		if isQualify then
			nowProcess = totalProcess
		end

		local displayOffset = taskInfo.display_offset

		if displayOffset and displayOffset > 0 then
			totalProcess = math.max(totalProcess - displayOffset, 0)
			nowProcess = math.max(nowProcess - displayOffset, 0)
		end
	end

	return nowProcess, totalProcess
end

function TaskMixin:isTaskAwardReady(taskId)
	if not self:getTaskClientVisible(taskId) then
		return false
	end

	local status = self:getTaskStatus(taskId)

	return status == Const.TASK_STATUS.COMPLETE
end

function TaskMixin:allNewbieTaskFinished()
	if not self.newbieMainTasks then
		return true
	end

	for i, mainTaskId in ipairs(self.newbieMainTasks) do
		if self:getTaskStatus(mainTaskId) ~= Const.TASK_STATUS.AWARD_GOT then
			return false
		end
	end

	return true
end

function TaskMixin:getTaskClientVisible(taskId)
	local taskInfo = ResTask[taskId]

	if not taskInfo then
		return false
	end

	local unlockLv = taskInfo.unlock_level
	local unlockStage = taskInfo.unlock_stage
	local lvReached = true

	if unlockLv then
		lvReached = unlockLv <= self:getLevel()
	end

	local stageReached = true

	if unlockStage then
		stageReached = self:mainStageStatePassed(unlockStage[1], unlockStage[2], unlockStage[3])
	end

	return lvReached and stageReached
end

local function _taskListSortFunc(a, b)
	local aInfo = ResTask[a]
	local bInfo = ResTask[b]

	return aInfo.action_param < bInfo.action_param
end

function TaskMixin:getTaskListByActionType(actionType)
	if not self.taskListByType then
		self.taskListByType = {}
	end

	if self.taskListByType[actionType] then
		return self.taskListByType[actionType]
	end

	local taskList = {}

	for taskId, taskInfo in pairs(ResTask) do
		if taskInfo.action_type == actionType then
			table.insert(taskList, taskId)
		end
	end

	table.sort(taskList, _taskListSortFunc)

	self.taskListByType[actionType] = taskList

	return taskList
end

function TaskMixin:getTaskListByTaskTypeAndActionType(taskType, actionType)
	local taskList = {}

	for taskId, taskInfo in pairs(ResTask) do
		if taskInfo.type == taskType and taskInfo.action_type == actionType then
			table.insert(taskList, taskId)
		end
	end

	table.sort(taskList, _taskListSortFunc)

	return taskList
end

function TaskMixin:getFocusNewbieTask()
	if not self.newbieMainTasks then
		return
	end

	local inprocessList = {}
	local completeList = {}
	local inactiveList = {}
	local newbieMainTasks = self.newbieMainTasks

	for index, mainTaskId in ipairs(newbieMainTasks) do
		local status = self:getTaskStatus(mainTaskId)

		if status == Const.TASK_STATUS.IN_PROCESS then
			table.insert(inprocessList, mainTaskId)
		elseif status == Const.TASK_STATUS.COMPLETE then
			table.insert(completeList, mainTaskId)
		elseif status == Const.TASK_STATUS.NOT_ACTIVE then
			table.insert(inactiveList, mainTaskId)
		end
	end

	if #completeList > 0 then
		return completeList[1]
	elseif #inprocessList > 0 then
		return inprocessList[1]
	elseif #inactiveList > 0 then
		return inactiveList[1]
	else
		return newbieMainTasks[#newbieMainTasks]
	end
end

function TaskMixin:getSortedDailyTask()
	return self:_commonSortTaskList(self.parent2ChildrenDict[self.dailyMainTask], true)
end

function TaskMixin:getSortedWeeklyTask()
	return self:_commonSortTaskList(self.parent2ChildrenDict[self.weeklyMainTask], true)
end

function TaskMixin:getSortedNewbieTask(mainTask)
	return self:_commonSortTaskList(self.parent2ChildrenDict[mainTask])
end

function TaskMixin:refreshTaskDlgs(taskType, forceReset)
	if taskType == Const.TASK_TYPE.DAILY or taskType == Const.TASK_TYPE.WEEKLY then
		self:refreshAchieveDlgTask(forceReset)
	else
		self:refreshNewbieTaskDlg(forceReset)
		self:refreshAdvanceTaskDlg()
		EventCenter.sendEvent(EventConst.NEWBIE_TASK_UPDATE)
	end
end

function TaskMixin:refreshNewbieTaskDlg(forceReset)
	local dlg = UIManager.getUI("newbieTaskDlg", nil, false)

	if dlg then
		if forceReset then
			dlg:setNewbieTaskData()
		end

		dlg:refreshNewbieTask()
	end
end

function TaskMixin:refreshAchieveDlgTask(forceReset)
	local dlg = UIManager.getUI("achieveMainDlg", nil, false)

	if dlg then
		dlg:refreshTasks(forceReset)
	end
end

function TaskMixin:_refreshRedDotMain(typeCode)
	if not typeCode then
		self:_refreshRedDotDaily()
		self:_refreshRedDotWeekly()
		self:_refreshRedDotNewbie()
	end

	if typeCode == Const.TASK_TYPE.DAILY then
		self:_refreshRedDotDaily()
	elseif typeCode == Const.TASK_TYPE.WEEKLY then
		self:_refreshRedDotWeekly()
	elseif typeCode == Const.TASK_TYPE.NEWBIE then
		self:_refreshRedDotNewbie()
	end
end

function TaskMixin:_refreshRedDotDaily(...)
	local hasHint = false

	for i, taskId in ipairs(self.dailyTaskList) do
		hasHint = self:isTaskAwardReady(taskId)

		if hasHint then
			break
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_DAILY_TASK, hasHint)
end

function TaskMixin:_refreshRedDotWeekly(...)
	local hasHint = false

	for i, taskId in ipairs(self.weeklyTaskList) do
		hasHint = self:isTaskAwardReady(taskId)

		if hasHint then
			break
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_WEEKLY_TASK, hasHint)
end

function TaskMixin:_refreshRedDotNewbie(...)
	local hasHint = false
	local needCheckList = {}

	if self.newbieMainTasks then
		for i, mainTaskId in ipairs(self.newbieMainTasks) do
			local status = self:getTaskStatus(mainTaskId)

			if status ~= Const.TASK_STATUS.AWARD_GOT and status ~= Const.TASK_STATUS.NOT_ACTIVE then
				if status == Const.TASK_STATUS.COMPLETE then
					hasHint = true
				else
					local subTaskList = self.parent2ChildrenDict[mainTaskId]

					for i, subTaskId in ipairs(subTaskList) do
						hasHint = self:isTaskAwardReady(subTaskId)

						if hasHint then
							break
						end
					end
				end

				if hasHint then
					break
				end
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_NEWBIE_TASK, hasHint)
	self:checkAdvanceTaskRD()
end

function TaskMixin.taskSortFunc(a, b)
	return
end

function TaskMixin:_commonSortTaskList(taskList, clientCheckVisible)
	if not taskList or #taskList == 0 then
		return {}
	end

	local completeList = {}
	local inProcessList = {}
	local alreadyGotList = {}

	for _, taskId in ipairs(taskList) do
		if not clientCheckVisible or self:getTaskClientVisible(taskId) then
			local status = self:getTaskStatus(taskId)

			if status == Const.TASK_STATUS.COMPLETE then
				table.insert(completeList, taskId)
			elseif status == Const.TASK_STATUS.IN_PROCESS then
				table.insert(inProcessList, taskId)
			elseif status == Const.TASK_STATUS.AWARD_GOT then
				table.insert(alreadyGotList, taskId)
			end
		end
	end

	local sortedList = {}

	for _, stateList in ipairs({
		completeList,
		inProcessList,
		alreadyGotList
	}) do
		for i, taskId in ipairs(stateList) do
			table.insert(sortedList, taskId)
		end
	end

	return sortedList
end

function TaskMixin:_taskTypeNeedFix(actionType)
	if actionType == Const.ACTION_TYPE_STAGE_NUM then
		return true
	else
		return false
	end
end

function TaskMixin:_initAdvanceTask(svrData)
	self.advanceTaskGroup = {}
	self.advanceTaskTypeDict = {}

	for groupId, groupData in pairs(ResAdvanceTask) do
		local groupInfo = {}

		groupInfo.taskStates = {}

		local tasksDictByType = {}

		for taskId, taskData in pairs(groupData) do
			local achieveType = taskData.action_type

			self.advanceTaskTypeDict[achieveType] = true

			if not tasksDictByType[achieveType] then
				tasksDictByType[achieveType] = {}
			end

			table.insert(tasksDictByType[achieveType], taskId)
		end

		for _, taskList in pairs(tasksDictByType) do
			table.sort(taskList)
		end

		groupInfo.tasksDictByType = tasksDictByType
		groupInfo.stepStatus = {}
		groupInfo.completeSetp = 0
		groupInfo.totalStep = 0
		groupInfo.score = 0
		groupInfo.boughtBP = false
		groupInfo.finish = false
		groupInfo.stepNormalGot = {}
		groupInfo.stepSuperGot = {}
		self.advanceTaskGroup[groupId] = groupInfo
	end

	self:updateAdvanceTaskStatus(nil, true)

	for _, item in ipairs(svrData.item) do
		local groupId = item.group_id
		local groupInfo = self.advanceTaskGroup[groupId]

		if not groupInfo then
			return
		end

		groupInfo.score = item.score
		groupInfo.boughtBP = item.is_super == 1
		groupInfo.finish = item.finish == 1

		local taskAwardGot = ClientUtils.getBitsListFromByteString(item.task_awarded.bits)

		for _, id in ipairs(taskAwardGot) do
			groupInfo.taskStates[id] = Const.TASK_STATUS.AWARD_GOT
		end

		local normalBPGot = ClientUtils.getBitsListFromByteString(item.step_normal_awarded.bits)

		for _, stepId in ipairs(normalBPGot) do
			groupInfo.stepNormalGot[stepId] = true
		end

		local superBPGot = ClientUtils.getBitsListFromByteString(item.step_super_awarded.bits)

		for _, stepId in ipairs(superBPGot) do
			groupInfo.stepSuperGot[stepId] = true
		end
	end

	for groupId, _ in pairs(ResAdvanceTask) do
		self:updateAdvanceStepStatus(groupId)
	end

	self.advanceSpecTask = {}

	for id, info in pairs(ResClientTaskGroup) do
		if id == 106 then
			local specTaskInfo = {}

			specTaskInfo.parentTaskId = info.main_task
			specTaskInfo.childTaskIdList = info.sub_task
			specTaskInfo.displayInfo = {
				heroId = info.hero_id,
				itemId = info.item_id,
				iconPath = info.big_icon_path,
				icon = info.big_icon,
				unlockDesc = info.unlock_desc
			}

			local parentTaskInfo = ResTask[specTaskInfo.parentTaskId]
			local resParam = parentTaskInfo.action_param

			if resParam ~= #specTaskInfo.childTaskIdList then
				-- block empty
			end

			self.advanceSpecTask[specTaskInfo.parentTaskId] = specTaskInfo

			break
		end
	end

	self:checkAdvanceTaskRD()
end

function TaskMixin:updateAdvanceTaskStatus(achieveType, forceUpdate)
	if not forceUpdate and not self.advanceTaskTypeDict[achieveType] then
		return
	end

	for groupId, groupInfo in pairs(self.advanceTaskGroup) do
		for taskId, taskData in pairs(ResAdvanceTask[groupId]) do
			if groupInfo.taskStates[taskId] ~= Const.TASK_STATUS.AWARD_GOT then
				local nowProcess = self:getAchieveProcessByType(taskData.action_type)

				if nowProcess < taskData.action_param then
					groupInfo.taskStates[taskId] = Const.TASK_STATUS.IN_PROCESS
				else
					groupInfo.taskStates[taskId] = Const.TASK_STATUS.COMPLETE
				end
			end
		end
	end

	if achieveType then
		self:checkAdvanceTaskRD()
	end
end

function TaskMixin:updateAdvanceStepStatus(groupId)
	local groupBPClientData = ResAdvanceStep[groupId]

	if not groupBPClientData or not self.advanceTaskGroup[groupId] then
		return
	end

	local groupInfo = self.advanceTaskGroup[groupId]
	local totalStep = 0
	local completeSetp = 0
	local nowScore = self:calcAdvanceGroupScore(groupId)

	for stepId, info in pairs(groupBPClientData) do
		if nowScore >= info.score_need then
			groupInfo.stepStatus[stepId] = Const.TASK_STATUS.COMPLETE
			completeSetp = completeSetp + 1
		else
			groupInfo.stepStatus[stepId] = Const.TASK_STATUS.IN_PROCESS
		end

		totalStep = totalStep + 1
	end

	groupInfo.score = nowScore
	groupInfo.completeSetp = completeSetp
	groupInfo.totalStep = totalStep
end

function TaskMixin:calcAdvanceGroupScore(groupId)
	if not self.advanceTaskGroup or not self.advanceTaskGroup[groupId] or not self.advanceTaskGroup[groupId].taskStates then
		return 0
	end

	local score = 0

	for taskId, states in pairs(self.advanceTaskGroup[groupId].taskStates) do
		if states == Const.TASK_STATUS.AWARD_GOT then
			score = score + ResAdvanceTask[groupId][taskId].score
		end
	end

	return score
end

function TaskMixin:allAdvanceTaskFinished()
	for groupId, groupInfo in pairs(self.advanceTaskGroup) do
		for taskId, taskStatus in pairs(groupInfo.taskStates) do
			if taskStatus ~= Const.TASK_STATUS.AWARD_GOT then
				return false
			end
		end

		if not groupInfo.finish then
			return false
		end

		if not groupInfo.boughtBP then
			return false
		end

		for stepId, _ in pairs(groupInfo.stepStatus) do
			if not groupInfo.stepSuperGot[stepId] then
				return false
			end
		end
	end

	for _, specTaskInfo in pairs(self.advanceSpecTask) do
		local specMainTaskId = specTaskInfo.parentTaskId

		if self:getTaskStatus(specMainTaskId) ~= Const.TASK_STATUS.AWARD_GOT then
			return false
		end
	end

	return true
end

function TaskMixin:getFocusAdvanceGroup()
	for _, specTaskInfo in pairs(self.advanceSpecTask) do
		local specMainTaskId = specTaskInfo.parentTaskId

		if self:getTaskStatus(specMainTaskId) ~= Const.TASK_STATUS.AWARD_GOT then
			return false, specMainTaskId
		end
	end

	for groupId, groupInfo in ipairs(self.advanceTaskGroup) do
		if not self:advanceGroupUnlock(groupId) and self.advanceTaskGroup[groupId - 1] then
			return true, groupId - 1
		end

		for stepId, _ in pairs(groupInfo.stepStatus) do
			if not groupInfo.stepNormalGot[stepId] then
				return true, groupId
			end
		end
	end

	return true, #self.advanceTaskGroup
end

function TaskMixin:advanceGroupUnlock(groupId)
	local miscInfo = ResAdvanceMisc[groupId]

	if not miscInfo or not miscInfo.unlock_group then
		return true
	end

	local unlockGroupId = miscInfo.unlock_group

	return self:advanceGroupFinished(unlockGroupId)
end

function TaskMixin:advanceGroupFinished(groupId)
	if not self.advanceTaskGroup[groupId] then
		return false
	end

	return self.advanceTaskGroup[groupId].finish or false
end

function TaskMixin:getSortedAdvSpecTaskList(taskId)
	if not self.advanceSpecTask or not self.advanceSpecTask[taskId] then
		return
	end

	return self:_commonSortTaskList(self.advanceSpecTask[taskId].childTaskIdList)
end

function TaskMixin:getSortedAdvanceTaskList(groupId)
	local groupInfo = self.advanceTaskGroup[groupId]
	local taskStates = groupInfo.taskStates
	local taskListDict = groupInfo.tasksDictByType
	local resultTaskList = {}

	for _, tList in pairs(taskListDict) do
		local findOne = false

		for i, taskId in ipairs(tList) do
			local status = taskStates[taskId]

			if status ~= Const.TASK_STATUS.AWARD_GOT then
				findOne = true

				table.insert(resultTaskList, taskId)

				break
			end
		end

		if not findOne then
			table.insert(resultTaskList, tList[#tList])
		end
	end

	local gotList = {}

	for _, targetStatus in ipairs({
		Const.TASK_STATUS.COMPLETE,
		Const.TASK_STATUS.IN_PROCESS,
		Const.TASK_STATUS.AWARD_GOT
	}) do
		for _, taskId in ipairs(resultTaskList) do
			if taskStates[taskId] == targetStatus then
				table.insert(gotList, taskId)
			end
		end
	end

	return gotList
end

function TaskMixin:onAdvanceGetTaskAwardResp(groupId, taskId, finish)
	if not self.advanceTaskGroup[groupId] then
		return
	end

	local groupInfo = self.advanceTaskGroup[groupId]

	groupInfo.finish = finish == 1
	groupInfo.taskStates[taskId] = Const.TASK_STATUS.AWARD_GOT

	self:updateAdvanceStepStatus(groupId)
	self:checkAdvanceTaskRD()
	self:refreshAdvanceTaskDlg()
end

function TaskMixin:onAdvanceGetStepAwardResp(groupId, step, isSuper)
	if not self.advanceTaskGroup[groupId] then
		return
	end

	local groupInfo = self.advanceTaskGroup[groupId]

	if isSuper == 1 then
		groupInfo.stepSuperGot[step] = true
	else
		groupInfo.stepNormalGot[step] = true
	end

	self:checkAdvanceTaskRD()
	self:refreshAdvanceTaskDlg()
end

function TaskMixin:onAdvanceRechargeNotify(groupId, isSuper)
	if not self.advanceTaskGroup[groupId] then
		return
	end

	local groupInfo = self.advanceTaskGroup[groupId]

	groupInfo.boughtBP = isSuper == 1

	self:checkAdvanceTaskRD()
	self:refreshAdvanceTaskDlg()

	local confirmDlg = UIManager.getUI("advanceBPConfirmDlg", nil, false)

	if confirmDlg then
		confirmDlg:setVisible(false)
	end
end

function TaskMixin:refreshAdvanceTaskDlg()
	EventCenter.sendEvent(EventConst.NEWBIE_TASK_UPDATE)

	local dlg = UIManager.getUI("advanceTaskDlg", nil, false)

	if dlg then
		dlg:refreshCurGroupInfo()
	end
end

function TaskMixin:checkAdvanceTaskRD()
	local hasHintSpecTask = self:checkAdvanceSpecTaskRD()
	local hasHintAdvanceTask = self:checkAdvanceGroupRD()

	RedDotManager.setKeyState(UIConst.RD_HINT_ADVANCE_TASK, hasHintSpecTask or hasHintAdvanceTask)
end

function TaskMixin:checkAdvanceSpecTaskRD()
	if not self.advanceSpecTask then
		return false
	end

	for mainTaskId, _ in pairs(self.advanceSpecTask) do
		if self:checkAdvanceSpecTaskRDById(mainTaskId) then
			return true
		end
	end

	return false
end

function TaskMixin:checkAdvanceSpecTaskRDById(taskId)
	local taskInfo = self.advanceSpecTask[taskId]

	if not taskInfo or not taskInfo.childTaskIdList then
		return false
	end

	local status = self:getTaskStatus(taskId)

	if status ~= Const.TASK_STATUS.AWARD_GOT and status ~= Const.TASK_STATUS.NOT_ACTIVE then
		if status == Const.TASK_STATUS.COMPLETE then
			return true
		else
			for i, subTaskId in ipairs(taskInfo.childTaskIdList) do
				if self:isTaskAwardReady(subTaskId) then
					return true
				end
			end
		end
	end

	return false
end

function TaskMixin:checkAdvanceGroupRD()
	if not self.advanceTaskGroup then
		return false
	end

	for groupId, _ in pairs(self.advanceTaskGroup) do
		if self:checkAdvanceGroupRDById(groupId) then
			return true
		end
	end

	return false
end

function TaskMixin:checkAdvanceGroupRDById(groupId)
	local groupInfo = self.advanceTaskGroup[groupId]

	if not groupInfo then
		return false
	end

	if not self:advanceGroupUnlock(groupId) then
		return false
	end

	for taskId, state in pairs(groupInfo.taskStates) do
		if state == Const.TASK_STATUS.COMPLETE then
			return true
		end
	end

	local boughtBP = groupInfo.boughtBP

	for stepId, state in pairs(groupInfo.stepStatus) do
		if state == Const.TASK_STATUS.COMPLETE then
			if not groupInfo.stepNormalGot[stepId] then
				return true
			end

			if boughtBP and not groupInfo.stepSuperGot[stepId] then
				return true
			end
		end
	end

	return false
end

return TaskMixin
