-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/TaskModel.lua

module("logic.extensions.task.model.TaskModel", package.seeall)

local TaskModel = class("TaskModel", BaseListModel)
local json = require("cjson")

function TaskModel:ctor()
	TaskModel.super.ctor(self)

	self.isTesting = nil
	self.isReady = nil

	self:_weakRefTable()
end

function TaskModel:_weakRefTable()
	self._taskes = {}
	self._finishTaskes = {}
	self._unavailableTaskes = {}

	local metaTable = {
		__mode = "k"
	}

	setmetatable(self._taskes, metaTable)
	setmetatable(self._finishTaskes, metaTable)
	setmetatable(self._unavailableTaskes, metaTable)
end

function TaskModel:onReset()
	TaskModel.super.onReset(self)
	self:clearTaskes()
end

function TaskModel:clearTaskes()
	self.isTesting = nil
	self.isReady = nil

	self:_weakRefTable()
end

function TaskModel:startTestTask(taskId)
	self:_weakRefTable()

	self.isTesting = true

	local taskIns = TaskFactory.createTask(taskId)

	if taskIns then
		local stepIns = TaskStepFactory.createTaskStep(taskIns:firstStepId(), taskIns)

		if stepIns then
			stepIns:setState(TaskConst.TSTEP_S_UNAVAILABLE)

			self._unavailableTaskes[taskId] = taskIns
			taskIns.currStep = stepIns
		end
	end
end

function TaskModel:onTaskListRespond(taskList, avaliabletasks, everDoneOneShotTasks)
	self:_onServerTaskesList(taskList)
	self:_checkTaskesFinished(everDoneOneShotTasks)
	self:_checkMainTaskes()
	self:_checkTaskesUnAccepted(avaliabletasks)
end

function TaskModel:getCurrentTriggerTask()
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v then
			local currStep = v.currStep

			if currStep then
				local state = currStep:getState()

				if state == TaskConst.TSTEP_S_ACCEPTED or TaskConst.TSTEP_S_COMPELETED then
					steps[#steps + 1] = currStep
				end
			end
		end
	end

	for k, v in pairs(self._unavailableTaskes) do
		if v and self:shouldTaskTrigger(v, true) and v.currStep and v.currStep:shouldTrigger() then
			steps[#steps + 1] = v.currStep
		end
	end

	table.sort(steps, TaskComp.compSteps)

	return steps
end

function TaskModel:getCurrentTriggerTaskShowedOnUI()
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v and self:isTaskNeedShowedOnUI(v) then
			local currStep = v.currStep

			if currStep then
				local state = currStep:getState()

				if state == TaskConst.TSTEP_S_ACCEPTED or TaskConst.TSTEP_S_COMPELETED then
					steps[#steps + 1] = currStep
				end
			end
		end
	end

	for k, v in pairs(self._unavailableTaskes) do
		if v and (self:isPreShowTaskesFinished(v.taskCo) or self:isTaskNeedShowedOnUI(v) and self:shouldTaskTrigger(v, true) and v.currStep and v.currStep:shouldTrigger() or v:isTaskNeedShowedOnUIWhileNoTrigger()) then
			steps[#steps + 1] = v.currStep
		end
	end

	table.sort(steps, TaskComp.compSteps)

	return steps
end

function TaskModel:getCurrentTriggerTaskesByType(taskType)
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v and v:getTaskType() == taskType and self:isTaskNeedShowedOnUI(v) then
			local currStep = v.currStep

			if currStep then
				local state = currStep:getState()

				if state == TaskConst.TSTEP_S_ACCEPTED or TaskConst.TSTEP_S_COMPELETED then
					steps[#steps + 1] = currStep
				end
			end
		end
	end

	for k, v in pairs(self._unavailableTaskes) do
		if v and v:getTaskType() == taskType and (self:isPreShowTaskesFinished(v.taskCo) or self:isTaskNeedShowedOnUI(v) and self:shouldTaskTrigger(v, true) and v.currStep and v.currStep:shouldTrigger() or v:isTaskNeedShowedOnUIWhileNoTrigger()) then
			steps[#steps + 1] = v.currStep
		end
	end

	table.sort(steps, TaskComp.compSteps)

	return steps
end

function TaskModel:getTaskesRelateToCopyId(copyId)
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v and v.currStep and v.currStep:isRelateToCopyId(copyId) then
			steps[#steps + 1] = v.currStep
		end
	end

	for k, v in pairs(self._unavailableTaskes) do
		if v and self:shouldTaskTrigger(v) and v.currStep and v.currStep:shouldTrigger() and v.currStep:isRelateToCopyId(copyId) then
			steps[#steps + 1] = v.currStep
		end
	end

	return steps
end

function TaskModel:getCompeleteTaskesRelateToCopyId(copyId, stageId)
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v and v:getTaskType() == GameEnum.TaskType.Main and v.currStep and v.currStep:isRelateToCopyId(copyId, stageId) then
			steps[#steps + 1] = v.currStep
		end
	end

	return steps
end

function TaskModel:getCompeleteTaskesRelateToSCCopyId(activityId, typeId, chapterId)
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v and v:getTaskType() == GameEnum.TaskType.Festival and v.currStep and v.currStep:isRelateToSCCopyId(activityId, typeId, chapterId) then
			steps[#steps + 1] = v.currStep
		end
	end

	return steps
end

function TaskModel:getTaskesRelateToItemId(itemId)
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v and v.currStep and v.currStep:isRelateToItemId(itemId) then
			steps[#steps + 1] = v.currStep
		end
	end

	for k, v in pairs(self._unavailableTaskes) do
		if v and self:shouldTaskTrigger(v) and v.currStep and v.currStep:shouldTrigger() and (v.currStep:isRelateToItemId(itemId) or v:isTriggerWithItemId(itemId)) then
			steps[#steps + 1] = v.currStep
		end
	end

	return steps
end

function TaskModel:getTaskesRelateToNpc(npcId, noSorted)
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v and v.currStep and v.currStep:isRelateToNpc(npcId) then
			steps[#steps + 1] = v.currStep
		end
	end

	for k, v in pairs(self._unavailableTaskes) do
		if v and self:shouldTaskTrigger(v) and v.currStep and v.currStep:shouldTrigger() and v.currStep:isRelateToNpc(npcId) then
			steps[#steps + 1] = v.currStep
		end
	end

	if not noSorted then
		table.sort(steps, TaskComp.compSteps)
	end

	return steps
end

function TaskModel:getTaskesRelateToMonster(mstId)
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v and v.currStep and v.currStep:isRelateToMonster(mstId) then
			steps[#steps + 1] = v.currStep
		end
	end

	for k, v in pairs(self._unavailableTaskes) do
		if v and self:shouldTaskTrigger(v) and v.currStep and v.currStep:shouldTrigger() and v.currStep:isRelateToMonster(mstId) then
			steps[#steps + 1] = v.currStep
		end
	end

	return steps
end

function TaskModel:isTriggerUsing(sceneId, triggerId)
	for k, v in pairs(self._taskes) do
		if v and v.currStep and v.currStep:isTriggerUsing(sceneId, triggerId) then
			return true
		end
	end

	for k, v in pairs(self._unavailableTaskes) do
		if v and self:shouldTaskTrigger(v) and v.currStep and v.currStep:shouldTrigger() and v.currStep:isTriggerUsing(sceneId, triggerId) then
			return true
		end
	end
end

function TaskModel:getTaskesMonsters()
	local mstsMap

	for k, v in pairs(self._taskes) do
		if v and v.currStep and not v.currStep:isCompeleted() then
			local msts = v.currStep:getMonsters()

			if msts then
				for i = 1, #msts do
					mstsMap = mstsMap or {}
					mstsMap[msts[i]] = true
				end
			end
		end
	end

	for k, v in pairs(self._unavailableTaskes) do
		if v and self:shouldTaskTrigger(v) and v.currStep and v.currStep:shouldTrigger() then
			local msts = v.currStep:getMonsters()

			if msts then
				for i = 1, #msts do
					mstsMap = mstsMap or {}
					mstsMap[msts[i]] = true
				end
			end
		end
	end

	return mstsMap
end

function TaskModel:getTaskesRelateToScene(sceneId)
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v and v.currStep and v.currStep:isRelateToScene(sceneId) then
			steps[#steps + 1] = v.currStep
		end
	end

	for k, v in pairs(self._unavailableTaskes) do
		if v and self:shouldTaskTrigger(v) and v.currStep and v.currStep:shouldTrigger() and (v.currStep:isRelateToScene(sceneId) or v:isTriggerInScene(sceneId)) then
			steps[#steps + 1] = v.currStep
		end
	end

	table.sort(steps, TaskComp.compSteps)

	return steps
end

function TaskModel:getTaskesRelateToMofang()
	local steps = {}

	for k, v in pairs(self._unavailableTaskes) do
		if v and self:shouldTaskTrigger(v) and v.currStep and v.currStep:shouldTrigger() and v:isTriggerWithMofang() then
			steps[#steps + 1] = v.currStep
		end
	end

	table.sort(steps, TaskComp.compSteps)

	return steps
end

function TaskModel:getTaskesRelateToMaxFP()
	local steps = {}

	for k, v in pairs(self._unavailableTaskes) do
		if v and self:shouldTaskTrigger(v) and v.currStep and v.currStep:shouldTrigger() and v:isTriggerWithMaxFP() then
			steps[#steps + 1] = v.currStep
		end
	end

	table.sort(steps, TaskComp.compSteps)

	return steps
end

function TaskModel:getTaskesRelateToHidePlayers()
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v and v.currStep and v.currStep:isHideOthersPlayers() then
			steps[#steps + 1] = v.currStep
		end
	end

	return steps
end

function TaskModel:getTaskesRelateToPve(pveId)
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v and v.currStep and v.currStep:isRelateToPve(pveId) then
			steps[#steps + 1] = v.currStep
		end
	end

	return steps
end

function TaskModel:getTaskesRelateToChallengeId(challengeId)
	local steps = {}

	for k, v in pairs(self._taskes) do
		if v and v.currStep and v.currStep:isRelateToChallenge(challengeId) then
			steps[#steps + 1] = v.currStep
		end
	end

	return steps
end

function TaskModel:tickTaskesOpens()
	if self._unavailableTaskes then
		for k, v in pairs(self._unavailableTaskes) do
			local task = v

			if not task.isTimeOk then
				if task:openHours() > 0 and task:isTimeOpen() then
					task.isTimeOk = true

					GlobalDispatcher:dispatch(GlobalNotify.TaskDataUpdate, task:getTaskId())
				end
			elseif not task.sendAcceptTask and task:openHours() > 0 and self:shouldTaskTrigger(task, true) then
				TaskController.instance:startAutoAccpeptedAction(task.currStep)
			end
		end
	end
end

function TaskModel:tickTaskesClosed()
	if self._taskes then
		local outtimeTaskes

		for k, v in pairs(self._taskes) do
			if not v:isInPeriod() then
				outtimeTaskes = outtimeTaskes or {}

				table.insert(outtimeTaskes, v)
			end
		end

		if outtimeTaskes then
			for i = 1, #outtimeTaskes do
				local taskId = outtimeTaskes[i]:getTaskId()

				self._taskes[taskId] = nil

				self:_checkTaskUnAccepted(outtimeTaskes[i].taskCo)
				GlobalDispatcher:dispatch(GlobalNotify.TaskDataUpdate, taskId)
			end
		end
	end
end

function TaskModel:hasTaskesAutoCompelete()
	local taskes = self:getCurrentTriggerTask()

	if not taskes or #taskes == 0 then
		return
	end

	for i = 1, #taskes do
		if taskes[i]:isCompeleted() and not taskes[i]:forbidAutoCommit() and taskes[i]:getCommitNpcId() == 0 then
			return true
		end
	end
end

function TaskModel:hasTaskesPureStoryCopy(copyId, levelId)
	local taskes = self:getCurrentTriggerTask()

	if not taskes or #taskes == 0 then
		return
	end

	for i = 1, #taskes do
		local tgts = taskes[i].targets

		for j = 1, #tgts do
			if tgts[j].target.copyId == copyId and tgts[j].target.levelId == levelId then
				return true
			end
		end
	end
end

function TaskModel:getTaskesRelateToSceneWithNpcs(sceneId)
	local npcIds = {}
	local npcIdsMap = {}

	for k, v in pairs(self._taskes) do
		if v and v.currStep then
			self:_addNpcIdRelativeToSceneWithTaskStep(v.currStep, sceneId, npcIds, npcIdsMap)
		end
	end

	for k, v in pairs(self._unavailableTaskes) do
		if v and self:shouldTaskTrigger(v) and v.currStep and v.currStep:shouldTrigger() then
			self:_addNpcIdRelativeToSceneWithTaskStep(v.currStep, sceneId, npcIds, npcIdsMap)
		end
	end

	return npcIds
end

function TaskModel:_addNpcIdRelativeToSceneWithTaskStep(currStep, sceneId, npcIds, npcIdsMap)
	local npcAllIds = currStep:getAllRelateToNpcIds()

	if npcAllIds then
		local count = #npcAllIds

		for i = 1, count do
			local npcId = npcAllIds[i]

			if npcId and npcId ~= 0 then
				local npcCo = SceneConfig.instance:getNpcCo(npcId)

				if npcCo and npcCo.sceneId == sceneId and not npcIdsMap[npcId] then
					npcIdsMap[npcId] = true
					npcIds[#npcIds + 1] = npcId
				end
			end
		end
	end
end

function TaskModel:getInnerEvolvePveId(target)
	local taskStep = target.taskStep
	local tgtPve = taskStep:getTargetByType(TaskConst.TSTEP_TARGET_PVE)

	if tgtPve and tgtPve.index < target.index then
		return tgtPve:getPveId()
	end

	local task = taskStep.task
	local pveId
	local allSteps = TaskConfig.instance:getAllTaskStepCoes(task:getTaskId())

	for i = 1, #allSteps do
		if allSteps[i].stepId == taskStep:getStepId() then
			break
		end

		local stepIns = TaskStepFactory.createTaskStep(allSteps[i].stepId, task)

		tgtPve = stepIns:getTargetByType(TaskConst.TSTEP_TARGET_PVE)

		if tgtPve and tgtPve.index < target.index then
			pveId = tgtPve:getPveId()
		end
	end

	return pveId
end

function TaskModel:isPveNeedEvolve(pveId)
	local taskId, stepId = TaskConfig.instance:getWuShenShouTaskId(pveId)
	local allSteps = TaskConfig.instance:getAllTaskStepCoes(taskId)
	local taskIns = TaskFactory.createTask(taskId)

	for i = 1, #allSteps do
		if stepId <= allSteps[i].stepId then
			local stepIns = TaskStepFactory.createTaskStep(allSteps[i].stepId, taskIns)
			local tgtPve = stepIns:getTargetByType(TaskConst.TSTEP_TARGET_INNEREVOLVE)

			if tgtPve then
				return true
			end
		end
	end
end

function TaskModel:shouldTaskTrigger(task, checkTrigger)
	if self.isTesting then
		return true
	end

	local taskCo = task.taskCo

	if taskCo.taskStarterState == TaskConst.TASK_S_OFFLINE then
		return
	end

	if task.trigger and checkTrigger and not task:isTriggered() then
		return nil
	end

	if not task:isTimeOpen() then
		return
	end

	return self:isPreTaskesFinished(taskCo)
end

function TaskModel:shouldTaskTriggerByTaskId(taskId)
	if self.isTesting then
		return true
	end

	local task = self:getUnavailableTaskes(taskId)

	if task then
		return self:shouldTaskTrigger(task, true)
	end

	return nil
end

function TaskModel:isPreTaskesFinished(taskCo)
	if self.isTesting then
		return true
	end

	if taskCo.preTaskIds then
		local count = #taskCo.preTaskIds

		for i = 1, count do
			local taskId = taskCo.preTaskIds[i]

			if not self._finishTaskes[taskId] then
				return
			end
		end
	end

	return true
end

function TaskModel:getUnFinishedPreTaskes(taskCo)
	if taskCo.preTaskIds then
		local count = #taskCo.preTaskIds
		local taskes

		for i = 1, count do
			local taskId = taskCo.preTaskIds[i]

			if not self._finishTaskes[taskId] then
				taskes = taskes or {}

				table.insert(taskes, taskId)
			end
		end

		return taskes
	end
end

function TaskModel:isPreHideTaskesFinished(taskCo)
	if self.isTesting then
		return true
	end

	if taskCo.hidePreTaskes then
		local count = #taskCo.hidePreTaskes

		for i = 1, count do
			local taskId = taskCo.hidePreTaskes[i]

			if not self._finishTaskes[taskId] then
				return
			end
		end
	end

	return true
end

function TaskModel:isPreShowTaskesFinished(taskCo)
	if self.isTesting then
		return true
	end

	if taskCo.showPreTaskes then
		local count = #taskCo.showPreTaskes

		if count > 0 then
			for i = 1, count do
				local taskId = taskCo.showPreTaskes[i]

				if not self._finishTaskes[taskId] then
					return
				end
			end

			return true
		end
	end
end

function TaskModel:isTaskNeedShowedOnUI(task)
	return self:isTaskNeedShowedOnUIByTaskCo(task.taskCo)
end

function TaskModel:isTaskNeedShowedOnUIByTaskCo(taskCo)
	if taskCo.taskStarterState ~= TaskConst.TASK_S_ONLINE then
		return
	end

	if self.isTesting then
		return true
	end

	if not self:isPreTaskesFinished(taskCo) then
		return
	end

	if not self:isPreHideTaskesFinished(taskCo) then
		return
	end

	return true
end

function TaskModel:getUnavailableTaskes(taskId)
	return self._unavailableTaskes[taskId]
end

function TaskModel:acceptTask(usrTask)
	local task = self:addTask(usrTask)
	local taskStep = task.currStep

	if taskStep then
		if taskStep:isCompeleted() then
			taskStep:setState(TaskConst.TSTEP_S_COMPELETED)
		else
			taskStep:setState(TaskConst.TSTEP_S_ACCEPTED)
		end
	end

	return task
end

function TaskModel:finishTask(taskId)
	if not self._finishTaskes[taskId] then
		local task = self._taskes[taskId]
		local currStep = task and task.currStep
		local nextStepId = currStep and currStep:getNextStepId()

		if nextStepId then
			local nextStep = TaskStepFactory.createTaskStep(nextStepId, task)

			if nextStep:isCompeleted() then
				nextStep:setState(TaskConst.TSTEP_S_COMPELETED)
			else
				nextStep:setState(TaskConst.TSTEP_S_ACCEPTED)
			end

			task.currStep = nextStep

			return nextStep
		else
			self:finishTaskAllStep(taskId)
		end
	end
end

function TaskModel:finishTaskAllStep(taskId)
	if self._finishTaskes[taskId] then
		return
	end

	local task = self._taskes[taskId]
	local currStep = task and task.currStep

	if currStep then
		currStep:setState(TaskConst.TSTEP_S_FINISHED)
	end

	self._taskes[taskId] = nil
	self._finishTaskes[taskId] = true
	self._unavailableTaskes[taskId] = nil
end

function TaskModel:getCurrStepOfTask(taskId)
	if self._taskes[taskId] then
		return self._taskes[taskId].currStep
	end

	return nil
end

function TaskModel:isTaskFinished(taskId)
	if self._finishTaskes[taskId] then
		return true
	end

	return nil
end

function TaskModel:isTaskStepFinished(taskId, stepId)
	if self:isTaskFinished(taskId) then
		return true
	end

	local task = self._taskes[taskId]

	if not task or not task.currStep then
		return false
	end

	return stepId < task.currStep:getStepId()
end

function TaskModel:isTaskStepDoing(taskId, stepId)
	if self._taskes[taskId] then
		if not self._taskes[taskId].currStep then
			return false
		else
			return stepId == self._taskes[taskId].currStep:getStepId()
		end
	end

	return false
end

function TaskModel:isTaskStepComelete(taskId, stepId)
	if self:isTaskStepFinished(taskId, stepId) then
		return true
	end

	local task = self._taskes[taskId]

	if not task or not task.currStep then
		return false
	end

	if stepId == task.currStep:getStepId() then
		return task.currStep:isCompeleted()
	end

	return false
end

function TaskModel:isTaskStepTargetComelete(taskId, stepId, tgtType)
	if self:isTaskStepFinished(taskId, stepId) then
		return true
	end

	local task = self._taskes[taskId]

	if not task or not task.currStep then
		return false
	end

	if stepId == task.currStep:getStepId() then
		local target = task.currStep:getTargetByType(tgtType)

		if not target then
			return true
		end

		return target:isCompeleted()
	end
end

function TaskModel:isTaskNeedTrigger(taskCo)
	return (not taskCo.trigger or #taskCo.trigger <= 0 or nil) and taskCo.preTaskIds and #taskCo.preTaskIds > 0
end

function TaskModel:isTaskAccpeted(taskId)
	return self._taskes[taskId]
end

function TaskModel:isTaskStepAccpeted(taskId, stepId)
	if self:isTaskStepFinished(taskId, stepId) then
		return true
	end

	local task = self._taskes[taskId]

	if task then
		if task.currStep then
			return task.currStep:getStepId() == stepId
		end
	else
		return not self._unavailableTaskes[taskId]
	end
end

function TaskModel:isTaskAccpetable(taskId)
	local task = self._unavailableTaskes[taskId]

	if task then
		return task.acceptedAvailable
	end
end

function TaskModel:getTaskes()
	return self._taskes
end

function TaskModel:getTaskById(taskId)
	return self._taskes[taskId]
end

function TaskModel:getAllUnavailableTaskes()
	return self._unavailableTaskes
end

function TaskModel:addTask(task)
	if task.state == TaskConst.TASK_S_FINISHED then
		return self:_onTaskFinished(task)
	elseif task.state == TaskConst.TASK_S_DOING then
		return self:_onTaskDoing(task)
	elseif task.state == TaskConst.TASK_S_DELETE then
		return self:_onTaskDelete(task)
	elseif task.state == TaskConst.TASK_S_UNAVAILABLE then
		return self:_onTaskUnAvaiable(task)
	end
end

function TaskModel:_onTaskFinished(task)
	self:_onTaskFinishedById(task.taskId)
end

function TaskModel:_onTaskFinishedById(taskId)
	self._finishTaskes[taskId] = true
	self._taskes[taskId] = nil
	self._unavailableTaskes[taskId] = nil
end

function TaskModel:_onTaskDelete(task)
	local taskId = task.taskId

	self._finishTaskes[taskId] = nil
	self._taskes[taskId] = nil
	self._unavailableTaskes[taskId] = nil

	local taskCo = TaskConfig.instance:getTaskCo(taskId)

	self:_checkTaskUnAccepted(taskCo)

	local taskIns = self._unavailableTaskes[taskId]

	if taskIns then
		taskIns.acceptedAvailable = true
	end
end

function TaskModel:_onTaskUnAvaiable(task)
	local taskId = task.taskId

	self._finishTaskes[taskId] = nil
	self._taskes[taskId] = nil
	self._unavailableTaskes[taskId] = nil

	local taskCo = TaskConfig.instance:getTaskCo(taskId)

	self:_checkTaskUnAccepted(taskCo)
end

function TaskModel:_onTaskDoing(task)
	local taskId = task.taskId

	if task.curStepId then
		local taskIns = self:getUnavailableTaskes(taskId)

		if not taskIns then
			taskIns = self._taskes[taskId] or TaskFactory.createTask(taskId)
		else
			self._unavailableTaskes[taskId] = nil
		end

		if taskIns then
			local stepIns = taskIns.currStep

			if not stepIns or stepIns:getStepId() ~= task.curStepId then
				stepIns = TaskStepFactory.createTaskStep(task.curStepId, taskIns)
			end

			if stepIns then
				self:_updateTask(task, taskIns, stepIns)

				self._taskes[taskId] = taskIns

				return taskIns
			else
				self._finishTaskes[taskId] = true
				self._taskes[taskId] = nil
				self._unavailableTaskes[taskId] = nil
			end
		end

		return taskIns
	else
		self._finishTaskes[taskId] = true
		self._taskes[taskId] = nil
		self._unavailableTaskes[taskId] = nil
	end
end

function TaskModel:_updateTask(task, taskIns, stepIns)
	if stepIns then
		taskIns.currStep = stepIns

		taskIns:setTimes(task.times)
		taskIns:setAcceptTime(task.acceptTime)
		taskIns:setFinishTime(task.finishTime)
		self:_updateTaskStepTarget(task, stepIns)
	end
end

function TaskModel:_updateTaskStepTarget(usrTask, stepIns)
	if usrTask.extraData then
		local len = #usrTask.extraData

		for i = 1, len do
			local tgt = stepIns:getTarget(i - 1)

			if tgt then
				local data = json.decode(usrTask.extraData[i])

				if data then
					if data.f and data.f ~= 0 then
						tgt:compelete()
					elseif data.c then
						tgt:setProgress(data.c)
					end
				end
			end
		end
	end
end

function TaskModel:_onServerTaskesList(taskes)
	self.isReady = true

	for i = 1, #taskes do
		self:addTask(taskes[i])

		local taskStep = self:getCurrStepOfTask(taskes[i].taskId)

		if taskStep then
			if taskStep:isCompeleted() then
				taskStep:setState(TaskConst.TSTEP_S_COMPELETED)
			else
				taskStep:setState(TaskConst.TSTEP_S_ACCEPTED)

				local performing = taskStep.acceptedPerformed

				if performing then
					performing.hasPerformed = true
				end
			end
		end
	end
end

function TaskModel:_checkTaskesUnAccepted(avaliabletasks)
	local taskes = TaskConfig.instance:getTaskes()

	for k, v in pairs(taskes) do
		if k ~= "dataList" then
			self:_checkTaskUnAccepted(v)
		end
	end

	if avaliabletasks then
		local cnt = #avaliabletasks

		for i = 1, cnt do
			local task = self._unavailableTaskes[avaliabletasks[i]]

			if task then
				task.acceptedAvailable = true
			end
		end
	end
end

function TaskModel:_checkTaskesFinished(everDoneOneShotTasks)
	if not everDoneOneShotTasks then
		return
	end

	for i = 1, #everDoneOneShotTasks do
		self:_onTaskFinishedById(everDoneOneShotTasks[i])
	end
end

function TaskModel:_checkMainTaskes()
	local mainTaskes = self:getCurrentTriggerTaskesByType(GameEnum.TaskType.Main)

	if mainTaskes and #mainTaskes > 0 then
		local mainTask = mainTaskes[1]

		self:_finishPreTaskes(mainTask.task.taskCo)
	end
end

function TaskModel:_finishPreTaskes(taskId)
	local taskCo = TaskConfig.instance:getTaskCo(taskId)

	if taskCo and taskCo.preTaskIds and #taskCo.preTaskIds > 0 then
		for i = 1, #taskCo.preTaskIds do
			self:_onTaskFinishedById(taskCo.preTaskIds[i])
			self:_finishPreTaskes(taskCo.preTaskIds[i])
		end
	end
end

function TaskModel:_checkTaskUnAccepted(taskCo)
	local taskId = taskCo.taskId

	if not self._finishTaskes[taskId] and not self._taskes[taskId] then
		local task = TaskFactory.createTask(taskId)

		if task then
			local stepStart = TaskConfig.instance:getStepStart(taskCo.taskId)
			local taskStep = TaskStepFactory.createTaskStep(stepStart, task)

			if taskStep then
				task.currStep = taskStep

				taskStep:setState(TaskConst.TSTEP_S_UNAVAILABLE)

				self._unavailableTaskes[taskId] = task
				task.isTimeOk = task:isTimeOpen()
			end
		end
	end
end

TaskModel.instance = TaskModel.New()

return TaskModel
