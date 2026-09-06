-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/controller/TaskController.lua

module("logic.extensions.task.controller.TaskController", package.seeall)

local TaskController = class("TaskController", BaseController)

function TaskController:onInit()
	TaskController.super.onInit(self)
	self.registerNotify(self, GlobalNotify.EnterSceneTrigger, self._onEnterSceneTrigger, self)
	self.registerNotify(self, GlobalNotify.LeaveSceneTrigger, self._onLeaveSceneTrigger, self)
	self.registerNotify(self, GlobalNotify.TaskPerformUIClose, self._onTaskPerformUIClose, self)
	self.registerNotify(self, GlobalNotify.OnMofangLvUp, self._onMofangLvUp, self)
	self.registerNotify(self, GlobalNotify.ColorfulEggsData, self._onColorfulEggsData, self)
	self.registerNotify(self, GlobalNotify.PlayerStrengthChange, self._onPlayerStrengthChange, self)
	self.registerNotify(self, GlobalNotify.StartStory, self._onStoryStarted, self)
	self.registerNotify(self, GlobalNotify.EndStory, self._onStoryEnded, self)
	self.registerLocalNotify(self, TaskConst.ON_TASK_DIALOG_SURE, self._onTaskDialogSure, self)
	self.registerLocalNotify(self, TaskConst.ON_TASK_DIALOG_CANCEL, self._onTaskDialogCancel, self)
	self.registerLocalNotify(self, TaskConst.ON_TASK_COLLECT_BREAK, self._onTaskCollectBreak, self)
	self.registerLocalNotify(self, TaskConst.ON_TASK_COLLECT_FINISH, self._onTaskCollectFinish, self)
	self.registerLocalNotify(self, TaskConst.ON_TASK_USEITEM_BREAK, self._onTaskUseItemBreak, self)
	self.registerLocalNotify(self, TaskConst.ON_TASK_USEITEM_FINISH, self._onTaskUseItemFinish, self)
	self.registerNotify(self, GlobalNotify.OnViewOpenStart, self._onViewOpenStart, self)
	self.registerNotify(self, GlobalNotify.OnViewClose, self._onViewClosed, self)
	self.registerNotify(self, GlobalNotify.MainPlayerPos, self._onMainPlayerPosChange, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._resetDailyTaskes, self)

	self._runningAction = nil
	self._performeding = nil
	self._uiActionTarget = nil
	self._collectingTask = nil
	self._useItemTask = nil
	self.isDoingTaskCompUI = nil

	settimer(0.0333, self._tickTaskes, self, true)

	self._currCityScene = nil
	self._autoActionTaskId = nil
	self._checkForbidAutoCommit = nil
	self._checkForbidAutoTask = nil
	self._isPause = nil
	self._enterFirstly = true
end

function TaskController:onReset()
	self.isDoingTaskCompUI = nil
	self._runningPveBattle = nil
	self._checkForbidAutoTask = nil
	self._checkForbidAutoCommit = nil
	self._performeding = nil
	self._collectingTask = nil
	self._uiActionTarget = nil
	self._useItemTask = nil
	self._autoActionTaskId = nil
	self._isPause = nil
	self._toHandleTaskIds = nil
	self._pauseTask = nil
	self._innerPause = nil
	self._runningAutoPath = nil
	self._enterFirstly = true
	self._openTaskCompOnSceneLoaded = nil
	self._compTaskStepOnExitScene = nil
	self.isFirstTaskDoing = nil
	self._escortCallBack = nil

	self:stopAction()
end

function TaskController:foreceClearState()
	self._escortCallBack = nil

	self:_doResume()
end

function TaskController:isUIInteractiveTargetStory(storyId, storyIndex)
	if not self._uiActionTarget then
		return
	end

	local target = self._uiActionTarget.target

	return target.chatStoryId == storyId and target.storyIndex == storyIndex
end

function TaskController:hasDoFirstTaskTarget()
	local chatperCo = TaskConfig.instance:getChapterCo(1)
	local taskId = chatperCo.taskes[1]

	if TaskModel.instance:isTaskStepFinished(taskId, 1) then
		return true
	end

	local task = TaskModel.instance:getTaskById(taskId)

	if not task then
		task = TaskModel.instance:getUnavailableTaskes(taskId)

		if task then
			return false
		end
	end

	if task and task.currStep then
		local tgt = task.currStep:getTarget(0)

		if not tgt:isCompeleted() then
			return false
		end
	end

	return true
end

function TaskController:hasTaskesAutoCompelete()
	if TaskModel.instance:hasTaskesAutoCompelete() then
		return true
	end

	if self._openTaskCompOnSceneLoaded then
		return true
	end
end

function TaskController:pause()
	self._isPause = true
	self._escortCallBack = nil

	self:_doPause()
end

function TaskController:_doPause()
	local mainPlayer

	if SceneMainPlayer.instance then
		mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	end

	if mainPlayer then
		mainPlayer:pauseAllActions()
	end

	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.joystick then
		currScene.joystick:setEnable(false)
	end

	if self._runningAction then
		GlobalDispatcher:dispatch(GlobalNotify.EndAutoPath)
	end
end

function TaskController:isPause()
	return self._isPause
end

function TaskController:resume()
	self._isPause = nil

	if not self._innerPause then
		self:_doResume()
	end
end

function TaskController:resetInnerPause()
	self._innerPause = nil

	if not self._isPause then
		self:_doResume()
	end
end

function TaskController:_doResume()
	GlobalDispatcher:dispatch(GlobalNotify.EndAutoPath)

	local mainPlayer

	if SceneMainPlayer.instance then
		mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	end

	if mainPlayer and not mainPlayer:isFrozenMove() then
		mainPlayer:resumeAllActions()
	end

	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene.joystick then
		currScene.joystick:setEnable(true)
	end

	if self._pauseTask then
		self:startCheckAutoCommit()
		self:startCheckAutoTask()

		local taskStep = self._pauseTask

		self._pauseTask = nil

		self:startAutoAction(taskStep)
		self:endCheckAutoCommit()
		self:endCheckAutoTask()
	elseif self._runningAutoPath and self._runningAction and not self._runningAction:isFinished() then
		GlobalDispatcher:dispatch(GlobalNotify.StartAutoPath)
	end
end

function TaskController:_tickTaskes()
	TaskModel.instance:tickTaskesOpens()
	TaskModel.instance:tickTaskesClosed()

	local runningAction = self._runningAction

	if runningAction and not self._isPause and not self._innerPause and not self._openTaskCompOnSceneLoaded and not self.isDoingTaskCompUI then
		if runningAction:isBreaked() then
			self._runningAction = nil
			self._runningAutoPath = nil

			GlobalDispatcher:dispatch(GlobalNotify.EndAutoPath)
		elseif not runningAction.isRunning then
			runningAction:runAction()

			if runningAction:isFinished() and runningAction.isRunning then
				local pveTarget = self._runningPveBattle

				self:stopAction()

				self._runningPveBattle = pveTarget
			end
		else
			runningAction:tick()

			if runningAction:isFinished() and runningAction.isRunning then
				local pveTarget = self._runningPveBattle

				self:stopAction()

				self._runningPveBattle = pveTarget
			end
		end
	end
end

function TaskController:stopAction()
	if self._runningAction then
		GlobalDispatcher:dispatch(GlobalNotify.EndAutoPath)
		self._runningAction:stopAction()

		self._runningAction = nil
		self._runningAutoPath = nil
	end

	self._runningPveBattle = nil
	self._escortCallBack = nil
end

function TaskController:startTestTask(taskId)
	self:onReset()
	TaskModel.instance:startTestTask(taskId)

	local taskStep = TaskModel.instance:getUnavailableTaskes(taskId).currStep

	self:_ensureTaskNpcAndTriggerCreated()
	self:startAutoAction(taskStep)
	self:notify(GlobalNotify.TaskDataUpdate, taskId)
end

function TaskController:triggerTask(taskStep)
	if not TaskModel.instance:shouldTaskTrigger(taskStep.task) then
		return
	end

	if taskStep.task.triggerdPerformed then
		self:_startPerformed(taskStep.task.triggerdPerformed)
	else
		self:startAutoAction(taskStep)
	end
end

function TaskController:onTaskTriggerNotify(taskIds)
	if taskIds then
		local cnt = #taskIds
		local task

		for i = 1, cnt do
			task = TaskModel.instance:getUnavailableTaskes(taskIds[i])

			if task then
				task.acceptedAvailable = true
			end

			self:notify(GlobalNotify.TaskDataUpdate, taskIds[i])
		end
	end
end

function TaskController:onTaskListRespond(taskes, avaliabletasks, everDoneOneShotTasks)
	TaskModel.instance:onTaskListRespond(taskes, avaliabletasks, everDoneOneShotTasks)
	self:_ensureTaskNpcAndTriggerCreated()
	GlobalDispatcher:dispatch(GlobalNotify.TaskDataReady)
end

function TaskController:_ensureTaskNpcAndTriggerCreated()
	if self._currCityScene and self._currCityScene.isReady then
		self:onSceneLoadedFinish(self._currCityScene:getSceneType(), self._currCityScene:getSceneId())
	else
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene.isReady then
			self:onSceneLoadedFinish(scene:getSceneType(), scene:getSceneId())
		end
	end
end

function TaskController:requestAcceptTask(taskStep)
	local task = taskStep.task

	if taskStep:getStepId() == task:firstStepId() then
		if TaskModel.instance.isTesting then
			self:onAccpetTask({
				times = 0,
				taskId = taskStep:getTaskId(),
				curStepId = taskStep:getStepId(),
				state = TaskConst.TSTEP_S_ACCEPTED
			})
		else
			task.sendAcceptTask = true

			TaskAgent.instance:sendOpenTaskStarterReq(task:getTaskId())
		end
	end
end

function TaskController:onAccpetTask(task)
	local taskId = task.taskId
	local currStep = TaskModel.instance:getCurrStepOfTask(task.taskId)

	if currStep and currStep:getStepId() == task.curStepId then
		currStep = nil
	elseif currStep then
		currStep:setState(TaskConst.TSTEP_S_FINISHED)
	end

	local taskIns = TaskModel.instance:acceptTask(task)

	if taskIns then
		local taskStep = taskIns.currStep

		self:_removeUnTriggeredSceneTrigger(taskStep)
		self:_hidePlayersOnTaskAccepted(taskStep)
		self:_createGoingTaskTargetSceneTrigger(taskStep)

		if taskStep then
			local stepId = taskStep:getStepId()

			if stepId ~= taskIns:firstStepId() then
				local preStep = TaskStepFactory.createTaskStep(stepId - 1, taskIns)

				self:_openTaskCompeleteView(preStep)
			end
		end

		if taskStep.acceptedPerformed then
			self:_startPerformed(taskStep.acceptedPerformed)
		else
			self:startAutoAction(taskStep)
		end

		self:localNotify(TaskConst.ON_TASK_STATE, taskId)
		self:notify(GlobalNotify.TaskDataUpdate, taskId)
	end

	if currStep then
		self:_clearTaskNpcsRelateToTaskStep(currStep)
		self:_showPlayersRelateToTaskStep(currStep)
		self:_removeGoingTaskStepBarrieres(currStep)
		self:_removeGoingTaskStepDyanamicNpcs(currStep)
		self:_removeFollowNpcs(currStep)
	end

	self:_handleTaskNpcsOnThisScene()
	self:_handleFollowNpcsOnThisScene()
end

function TaskController:requestCompeleteTaskById(taskId, stepId)
	local task = TaskModel.instance:getTaskById(taskId)

	if task and task.currStep and task.currStep:getStepId() == stepId then
		self:requestCompeleteTask(task.currStep)
	end
end

function TaskController:requestCompeleteTask(taskStep)
	if TaskModel.instance.isTesting then
		taskStep:setState(TaskConst.TSTEP_S_COMPELETED)
		self:onCompeleteTask(taskStep)
	elseif taskStep.finishedPerformed and not taskStep.finishedPerformed.hasPerformed then
		self:_startPerformed(taskStep.finishedPerformed)
	elseif not taskStep:jumpCompeleteUI() and not taskStep.hasSentFinishProto and (taskStep:getCommitNpcId() ~= 0 or taskStep:forbidAutoCommit()) then
		taskStep.hasSentFinishProto = true

		TaskAgent.instance:sendFinishTaskStepReq(taskStep:getTaskId(), taskStep:getStepId())
	end
end

function TaskController:finishTask(taskId)
	local taskStep = TaskModel.instance:getCurrStepOfTask(taskId)

	TaskModel.instance:finishTask(taskId)
	self:_handleTaskInFinished(taskStep)
	self:notify(GlobalNotify.TaskDataUpdate, taskId)
end

function TaskController:finishTaskAllStep(taskId)
	local taskStep = TaskModel.instance:getCurrStepOfTask(taskId)

	TaskModel.instance:finishTaskAllStep(taskId)
	self:_handleTaskInFinished(taskStep)
	self:notify(GlobalNotify.TaskDataUpdate, taskId)
end

function TaskController:_handleTaskInFinished(taskStep)
	if taskStep then
		self:_clearTaskNpcsRelateToTaskStep(taskStep)
		self:_showPlayersRelateToTaskStep(taskStep)
		self:_removeGoingTaskStepBarrieres(taskStep)
		self:_removeGoingTaskStepDyanamicNpcs(taskStep)
		self:_removeFollowNpcs(taskStep)
	end

	self:_handleTaskNpcsOnThisScene()
	self:_handleFollowNpcsOnThisScene()
	self:_openTaskCompeleteView(taskStep)
end

function TaskController:deletaTask(taskId)
	local taskStep = TaskModel.instance:getCurrStepOfTask(taskId)

	TaskModel.instance:finishTask(taskId)
	self:notify(GlobalNotify.TaskDataUpdate, taskId)
	self:_clearTaskNpcsRelateToTaskStep(taskStep)
	self:_showPlayersRelateToTaskStep(taskStep)
	self:_removeGoingTaskStepBarrieres(taskStep)
	self:_removeGoingTaskStepDyanamicNpcs(taskStep)
	self:_removeFollowNpcs(taskStep)
	self:_handleTaskNpcsOnThisScene()
	self:_handleFollowNpcsOnThisScene()
end

function TaskController:onCompeleteTask(taskStep)
	taskStep:setState(TaskConst.TSTEP_S_FINISHED)

	if taskStep.finishedPerformed and not taskStep.finishedPerformed.hasPerformed then
		self:_startPerformed(taskStep.finishedPerformed)
	else
		self:_doFinishTask(taskStep)
	end
end

function TaskController:requestCompeleteTaskTarget(taskStep, target)
	if not taskStep:isTargetRunnable(target) then
		return
	end

	local task = taskStep.task

	if not TaskModel.instance.isTesting then
		if target.finishedPerformed and not target.finishedPerformed.hasPerformed then
			self:_startPerformed(target.finishedPerformed)
		elseif target:isCompeleted() then
			self:startCheckAutoCommit()
			self:startCheckAutoTask()
			self:startAutoAction(taskStep)
			self:endCheckAutoCommit()
			self:endCheckAutoTask()
		elseif not target.sendCompeleted then
			target.sendCompeleted = true

			TaskAgent.instance:sendRunTaskStepReq(task:getTaskId(), taskStep:getStepId(), target.index, target:getTargetsExtraData())
		end
	else
		target:setProgress(target:getProgress() + 1)
		self:startCheckAutoCommit()
		self:startCheckAutoTask()
		self:onTaskDataUpdate({
			times = 0,
			taskId = taskStep:getTaskId(),
			curStepId = taskStep:getStepId(),
			state = TaskConst.TSTEP_S_ACCEPTED,
			extraData = taskStep:getTargetsExtraData()
		}, taskStep:getStepId(), target.index)

		if taskStep:getState() == TaskConst.TSTEP_S_FINISHED then
			local nextStepId = taskStep:getNextStepId()

			if nextStepId then
				self:onTaskDataUpdate({
					times = 0,
					taskId = taskStep:getTaskId(),
					curStepId = nextStepId,
					state = TaskConst.TSTEP_S_ACCEPTED
				})
			end
		end

		self:endCheckAutoCommit()
		self:endCheckAutoTask()
	end
end

function TaskController:_preHandlerCompeleteTaskTarget(taskStep, tgt)
	local performing = tgt:getDoingPerformed()

	if performing and not performing.hasPerformed then
		self:_startPerformed(performing)
		tgt:prepareCompeleteOnce()
		self:notify(GlobalNotify.TaskDataUpdate, taskStep:getTaskId())
	else
		self:requestCompeleteTaskTarget(taskStep, tgt)
	end
end

function TaskController:onTaskDataUpdate(usrTask, stepId, targetIdx)
	local taskId = usrTask.taskId

	if stepId and targetIdx and targetIdx >= 0 then
		local taskStep = TaskModel.instance:getCurrStepOfTask(taskId)

		TaskModel.instance:addTask(usrTask)

		if taskStep and taskStep:getStepId() == stepId then
			local target = taskStep:getTarget(targetIdx)

			if target then
				self:_removeGoingTaskTargetSceneTrigger(target)

				local stepCompelete = taskStep:isCompeleted()

				if not stepCompelete then
					self:startAutoAction(taskStep)
					self:localNotify(TaskConst.ON_TASK_PROGRESS, taskStep:getTaskId())

					return
				elseif TaskModel.instance.isTesting then
					self:onCompeleteTask(taskStep)

					return
				else
					taskStep:setState(TaskConst.TSTEP_S_COMPELETED)
					self:startAutoAction(taskStep)
					self:notify(GlobalNotify.TaskDataUpdate, taskStep:getTaskId())
				end
			else
				self:onCompeleteTask(taskStep)

				return
			end
		end

		self:_handleTaskNpcsOnThisScene()
		self:_handleFollowNpcsOnThisScene()
	else
		self:onAccpetTask(usrTask)
	end
end

function TaskController:_startPerformed(performed)
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	if SceneFacade.instance:isInBattleScene() then
		return
	end

	if self._isPause or self._innerPause then
		return
	end

	if not self:hasDoFirstTaskTarget() and StoryModel.instance:getCurStory() then
		return
	end

	self:stopAction()

	self._performeding = performed
	self._performeding.hasPerformed = true

	if performed.method == TaskConst.PM_STORY then
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, performed.storyId)
	elseif performed.method == TaskConst.PM_DIALOG then
		self:_openTaskDialog()
	elseif performed.method == TaskConst.PM_UI then
		self:_openTaskPerformUI()
	elseif performed.method == TaskConst.PM_PETBATTLE then
		TaskFacade.instance:requestEvEBattle(performed.eveBattleIdA or 0, performed.eveBattleIdB or 0)
	elseif performed.method == TaskConst.PM_ANIMATION then
		AnimationPlayer.play(performed.animName, self._onAnimPlayFinish, self._onAnimPlayStart, self)
	elseif performed.method == TaskConst.PM_EVOLVE then
		GlobalModel.instance:setUIInteractable(false)
		AnimatorEffect.instance:onPlayEffect(performed.formPetId, performed.toPetId, performed.animName, function()
			if self._performeding and self._performeding.method == TaskConst.PM_EVOLVE then
				GlobalModel.instance:setUIInteractable(true)
				self:_onPerformingFinish()
				PetDisplayController.instance:checkAndOpenDisplay()
			end
		end)
	elseif performed.method == TaskConst.PM_VIDEO then
		VideoFacade.instance:play(performed.videoName, self._onVideoPlayFinish, self)
	end
end

function TaskController:getPerformed()
	return self._performeding
end

function TaskController:_onPerformingFinish()
	local performeding = self._performeding

	self._performeding = nil

	local needCheckAutoCo, performedTask

	if performeding.performedType == TaskConst.PERFORMED_TRIGERED then
		performedTask = performeding.task.currStep
		performeding.task.currStep.task.acceptedAvailable = true
	elseif performeding.performedType == TaskConst.PERFORMED_ACCEPTED then
		performedTask = performeding.taskStep
		needCheckAutoCo = true
	elseif performeding.performedType == TaskConst.PERFORMED_FINISHED then
		performedTask = performeding.taskStep

		if performeding.method == TaskConst.PM_STORY then
			self:_clearTaskNpcsRelateToTaskStep(performedTask)
			self:_showPlayersRelateToTaskStep(performedTask)
			self:_removeGoingTaskStepBarrieres(performedTask)
			self:_removeGoingTaskStepDyanamicNpcs(performedTask)
			self:_removeFollowNpcs(performedTask)
		end

		local target = performeding.target

		if target then
			self:requestCompeleteTaskTarget(target.taskStep, target)

			return
		end
	elseif performeding.performedType == TaskConst.PERFORMED_CHATNPC then
		local target = performeding.target

		if target and target:isCompeleted() then
			self:_preHandlerCompeleteTaskTarget(performeding.taskStep, target)
		else
			self:_handleSelectNpcOnAccepted(performeding.taskStep, performeding.npcId)
		end
	elseif performeding.performedType == TaskConst.PERFORMED_SEACHZONE or performeding.performedType == TaskConst.PERFORMED_USERACTION then
		local target = performeding.target

		self:requestCompeleteTaskTarget(target.taskStep, target)
	elseif performeding.performedType == TaskConst.PERFORMED_BATTLERELTFAILED or performeding.performedType == TaskConst.PERFORMED_BATTLERELTSUCCESS then
		self._runningPveBattle = performeding.target
		self._toHandleTaskIds = {}
		self._toHandleTaskIds[self._runningPveBattle.taskStep:getTaskId()] = true

		self:_handleAutoActionOnSceneLoaded()

		return
	end

	if performedTask then
		if needCheckAutoCo then
			self:startCheckAutoTask()
		end

		self:startAutoAction(performedTask)

		if needCheckAutoCo then
			self:endCheckAutoTask()
		end
	end
end

function TaskController:recordTaskUpdateOnBattle(taskId)
	if SceneMgr.instance.isGogingToEnterBattleScene then
		self._toHandleTaskIds = self._toHandleTaskIds or {}
		self._toHandleTaskIds[taskId] = true
	end
end

function TaskController:startCheckAutoCommit()
	self._checkForbidAutoCommit = true
end

function TaskController:endCheckAutoCommit()
	self._checkForbidAutoCommit = nil
end

function TaskController:startCheckAutoTask()
	self._checkForbidAutoTask = true
end

function TaskController:endCheckAutoTask()
	self._checkForbidAutoTask = nil
end

function TaskController:isForbidAutoTask(taskStep)
	if taskStep.task:getTaskType() == GameEnum.TaskType.ColorfulEggs and taskStep:forbidAutoTask() then
		return true
	end

	if not self._checkForbidAutoTask or not taskStep:forbidAutoTask() then
		return
	end

	local tgtCnt = taskStep:getTargetNum()

	if tgtCnt <= 1 then
		return true
	end

	if taskStep:orderingTargets() then
		local tgt = taskStep.targets[1]

		if tgt:isCompeleted() then
			return
		end

		return true
	end

	for i = 1, tgtCnt do
		local tgt = taskStep.targets[i]

		if tgt:isCompeleted() then
			return
		end

		if tgt:getProgress() ~= 0 then
			return
		end
	end

	return true
end

function TaskController:startAutoAction(taskStep, isForce)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if not mainPlayer then
		return
	end

	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	if SceneFacade.instance:isInBattleScene() then
		return
	end

	if self._performeding then
		return
	end

	if self._runningAction ~= nil and self._runningAction.taskStep == taskStep then
		return
	end

	self:stopAction()

	self._autoActionTaskId = taskStep:getTaskId()

	if not isForce and (self._isPause or self._innerPause) then
		self._pauseTask = taskStep

		return
	end

	mainPlayer:handleQueryFindWay()

	local state = taskStep:getState()

	if state == TaskConst.TSTEP_S_UNAVAILABLE then
		self:startAutoAccpeptedAction(taskStep)
	elseif state == TaskConst.TSTEP_S_COMPELETED then
		self:_startAutoCommitedAction(taskStep)
	elseif state == TaskConst.TSTEP_S_ACCEPTED then
		self:_startAutoCommpeletedAction(taskStep)
	elseif state == TaskConst.TSTEP_S_FINISHED then
		self:_doFinishTask(taskStep)
	end
end

function TaskController:_getAutoActionTask(taskes)
	if self._autoActionTaskId then
		local cnt = #taskes

		for i = 1, cnt do
			if taskes[i]:getTaskId() == self._autoActionTaskId then
				return taskes[i]
			end
		end
	end
end

function TaskController:getTaskStepByTaskId(taskId)
	local taskStep = TaskModel.instance:getCurrStepOfTask(taskId)

	if not taskStep then
		local task = TaskModel.instance:getUnavailableTaskes(taskId)

		if task then
			taskStep = task.currStep
		end
	end

	return taskStep
end

function TaskController:startAutoActionByTaskId(taskId)
	local taskStep = self:getTaskStepByTaskId(taskId)

	if taskStep then
		TaskController.instance:startAutoAction(taskStep)
	end
end

function TaskController:_doFinishTask(taskStep)
	local taskId = taskStep:getTaskId()
	local nextTaskStep = TaskModel.instance:getCurrStepOfTask(taskId)

	if nextTaskStep and nextTaskStep:getState() == TaskConst.TSTEP_S_FINISHED then
		nextTaskStep = TaskModel.instance:finishTask(taskId)
	end

	if nextTaskStep then
		self:_hidePlayersOnTaskAccepted(nextTaskStep)
		self:_createGoingTaskTargetSceneTrigger(nextTaskStep)
		self:startAutoAction(nextTaskStep)
	end

	self:notify(GlobalNotify.TaskDataUpdate, taskStep:getTaskId())
	self:_clearTaskNpcsRelateToTaskStep(taskStep)
	self:_showPlayersRelateToTaskStep(taskStep)
	self:_removeGoingTaskStepBarrieres(taskStep)
	self:_removeGoingTaskStepDyanamicNpcs(taskStep)
	self:_removeFollowNpcs(taskStep)
	self:_handleTaskNpcsOnThisScene()
	self:_handleFollowNpcsOnThisScene()
end

function TaskController:startAutoAccpeptedAction(taskStep)
	if TaskModel.instance:shouldTaskTrigger(taskStep.task, true) then
		local accNpc = taskStep:getAcceptNpcId()

		if accNpc ~= 0 then
			if accNpc == SceneFacade.InvalidNpcId then
				self:_handleTaskOnSelectNpc(taskStep, accNpc)
			else
				self._runningAction = TActionFactory.createTAction(TaskConst.GOTONPC, taskStep, accNpc)
			end
		elseif taskStep.task:isAutoAccpet() or taskStep.task.acceptedAvailable then
			self:requestAcceptTask(taskStep)
		end
	elseif not self._checkForbidAutoTask then
		taskStep.task:showUnAvailableTips()
	end
end

function TaskController:_startAutoCommitedAction(taskStep)
	if (taskStep.task:getTaskType() == GameEnum.TaskType.ColorfulEggs or self._checkForbidAutoCommit) and taskStep:forbidAutoCommit() then
		return
	end

	local commitNpc = taskStep:getCommitNpcId()

	if commitNpc ~= 0 then
		if commitNpc == SceneFacade.InvalidNpcId then
			self:_handleTaskOnSelectNpc(taskStep, commitNpc)
		else
			self._runningAction = TActionFactory.createTAction(TaskConst.GOTONPC, taskStep, commitNpc)
		end
	else
		self:requestCompeleteTask(taskStep)
	end
end

function TaskController:_startAutoCommpeletedAction(taskStep)
	if self:isForbidAutoTask(taskStep) then
		return
	end

	local performing = taskStep.acceptedPerformed

	if performing and not performing.hasPerformed then
		self:_startPerformed(performing)

		return
	end

	local targets = taskStep.targets

	if not targets then
		self:requestCompeleteTask(taskStep)

		return
	end

	local count = #targets

	for i = 1, count do
		local target = targets[i]

		if not target:isCompeleted() then
			self:_startAutoCommpeletedTarget(target)

			break
		end
	end
end

function TaskController:_startAutoCommpeletedTarget(target)
	self._runningPveBattle = nil

	local targetType = target:getTargetType()

	if targetType == TaskConst.TSTEP_TARGET_BATTLE_NPC then
		self._runningAction = TActionFactory.createTAction(TaskConst.GOTOMONSTER, target, target:getBattleMonsterId())
	elseif targetType == TaskConst.TSTEP_TARGET_CHALLENGE then
		self:_jumpToChallenge(target)
	elseif targetType == TaskConst.TSTEP_TARGET_CHAT_NPC then
		self._runningAction = TActionFactory.createTAction(TaskConst.GOTONPC, target, target:getChatNpcId())
	elseif targetType == TaskConst.TSTEP_TARGET_SEARCH then
		self._runningAction = TActionFactory.createTAction(TaskConst.GOTOSCENETRIGGER, target)
	elseif targetType == TaskConst.TSTEP_TARGET_COLLECT then
		self._runningAction = TActionFactory.createTAction(TaskConst.GOTONPC, target, target:getCollectNpcId())
	elseif targetType == TaskConst.TSTEP_TARGET_USERACTION then
		self:_startUserAction(target)
	elseif targetType == TaskConst.TSTEP_TARGET_USEITEM then
		self._runningAction = TActionFactory.createTAction(TaskConst.GOTOSCENETRIGGER, target)
	elseif targetType == TaskConst.TSTEP_TARGET_PETLEVEL then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_PVE then
		self:_startGuidePveTarget(target)
	elseif targetType == TaskConst.TSTEP_TARGET_HATCHEGG then
		UIStateManager.instance:push(ViewName.petegg)
	elseif targetType == TaskConst.TSTEP_TARGET_TOWER then
		FuncOpenController.instance:openFunc(15)
	elseif targetType == TaskConst.TSTEP_TARGET_KINGROAD then
		FuncOpenController.instance:openFuncByViewName(ViewName.PetTrial)
	elseif targetType == TaskConst.TSTEP_TARGET_KINGROADNEW then
		FuncOpenController.instance:openFuncByViewName(ViewName.KingWay)
	elseif targetType == TaskConst.TSTEP_TARGET_GENIES then
		self:_openTalentView(target:getPetId())
	elseif targetType == TaskConst.TSTEP_TARGET_COLL_PETS then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_FROMATION then
		-- block empty
	elseif targetType == TaskConst.TSTEP_TARGET_EVOLVE then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_INNEREVOLVE then
		self:_openInnerEvolve(target)
	elseif targetType == TaskConst.TSTEP_TARGET_LEVELTO then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_PETRECORD then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_STARGODHUNTTIMERS then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_STARGODQUALITY then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_SOURCEMONLEVEL then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_STARGODLEVEL then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_GENIUSTIMES then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_WUSHENSHOUREWARD then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_DIAMONDACTIVITY then
		UIStateManager.instance:push(ViewName.diamondtask)
	elseif targetType == TaskConst.TSTEP_TARGET_GENIES_LEVEL then
		self:_openTalentView(target:getPetId())
	elseif targetType == TaskConst.TSTEP_TARGET_SANXIAO then
		FuncOpenController.instance:openFuncByViewName(ViewName.Sxgamestart)
	elseif targetType == TaskConst.TSTEP_TARGET_ONLINEGIFT then
		BonusController.instance:openBonusView(ViewName.onlinetime)
	elseif targetType == TaskConst.TSTEP_TARGET_CATCHMONSTER then
		self:_gotoMonsterByTarget(target)
	elseif targetType == TaskConst.TSTEP_TARGET_CATCHSOURCEMON then
		self:_gotoSourceMonByTarget(target)
	elseif targetType == TaskConst.TSTEP_TARGET_PETTRAINNING then
		self:_openTaskPetTrainningGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_JJC then
		self:_openTaskJJCGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_STORYCOPY then
		self:_openTaskStoryCopyGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_SCCOPY then
		ScenariocopyController.instance:openSclevelsView(target.target)
	elseif targetType == TaskConst.TSTEP_TARGET_CSTZ then
		self:_startGuideTaskCSTZTarget(target)
	elseif targetType == TaskConst.TSTEP_TARGET_AOQIXUEYUAN then
		FuncOpenController.instance:openFuncByViewName(ViewName.TeachingDungeonMainView)
	elseif targetType == TaskConst.TSTEP_TARGET_RESCOPY then
		self:_openTaskStoryResCopyGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_EXPEDITIONSTEP then
		FuncOpenController.instance:openFunc(52)
	elseif targetType == TaskConst.TSTEP_TARGET_AWAKENLEVEL then
		FuncOpenController.instance:openFuncByViewName(ViewName.PetShowView)
	elseif targetType == TaskConst.TSTEP_TARGET_ACHIEVEMENTDATA then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_BREAKFMTTIMES then
		FuncOpenController.instance:openFuncByViewName(ViewName.BreakFormation)
	elseif targetType == TaskConst.TSTEP_TARGET_XIAONUOBUYTIMES then
		FuncOpenController.instance:openFuncByViewName(ViewName.IdleGame)
	elseif targetType == TaskConst.TSTEP_TARGET_EQUIPMENTTIMES then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_EQUIPMENTLEVELUPTIMES then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_EQUIPSTARGODTIMES then
		self:_openTaskGuideUI(target)
	elseif targetType == TaskConst.TSTEP_TARGET_JIUGONGBAZHEN then
		FuncOpenController.instance:openFuncByViewName(ViewName.NineplacelvupView)
	elseif targetType == TaskConst.TSTEP_TARGET_GAINPET then
		FuncOpenController.instance:openFuncByViewName(ViewName.PigraiseadoptView)
	elseif targetType == TaskConst.TSTEP_TARGET_DAILYACTIVITY then
		UIStateManager.instance:push(ViewName.diamondtask, GameEnum.TaskViewTab.Daily)
	end
end

function TaskController:clearHandlingTaskes()
	self._runningPveBattle = nil
	self._toHandleTaskIds = nil
end

function TaskController:_startGuidePveTarget(target)
	local npcId = target:getBattleNpcId()

	self._runningPveBattle = target

	if npcId and npcId ~= 0 then
		if npcId == SceneFacade.InvalidNpcId then
			self:_handleTaskOnSelectNpc(target.taskStep, npcId)
		else
			self._runningAction = TActionFactory.createTAction(TaskConst.GOTONPC, target, npcId)
		end
	else
		self:_startPveTarget(target)
	end
end

function TaskController:_startPveTarget(target)
	self._runningPveBattle = target

	BattleFacade.instance:startPve(target:getPveId(), target.target.directStart)
end

function TaskController:_jumpToChallenge(target)
	local npcId

	if target.target.needGoToNpc then
		npcId = UnlockFacade.instance:getChallengeNpc(target:getChallengeId())
	end

	if npcId and npcId ~= 0 then
		if npcId == SceneFacade.InvalidNpcId then
			self:_handleTaskOnSelectNpc(taskStep, npcId)
		else
			self._runningAction = TActionFactory.createTAction(TaskConst.GOTONPC, target, npcId)
		end
	else
		local cId = target:getChallengeId()

		ChallengeFacade.instance:startChallange(cId)
	end
end

function TaskController:_openInnerEvolve(target)
	UIStateManager.instance:push("wuShenShouView", TaskModel.instance:getInnerEvolvePveId(target))
end

function TaskController:startInnerEvolve(taskId)
	local taskStep = TaskModel.instance:getCurrStepOfTask(taskId)
	local target = taskStep:getTargetByType(TaskConst.TSTEP_TARGET_INNEREVOLVE)

	UIStateManager.instance:push(ViewName.Evolve, {
		target.target.petIds[1],
		target.target.petIds[2]
	}, function(petId)
		target.selectPetId = petId

		self:requestCompeleteTaskTarget(target.taskStep, target)
	end)
end

function TaskController:_openTaskCompeleteView(taskStep)
	if SceneMgr.instance.isGogingToEnterBattleScene or not self:_isSceneValid() then
		self._compTaskStepOnExitScene = taskStep
		self._openTaskCompOnSceneLoaded = true

		return
	end

	self._openTaskCompOnSceneLoaded = nil
	self._compTaskStepOnExitScene = nil

	UIStateManager.instance:popByName(ViewName.PlotCopyView)
	UIStateManager.instance:popByName(ViewName.PlotChapterView)
	UIStateManager.instance:popByName(ViewName.MaterialChallengeView)
	UIStateManager.instance:popByName(ViewName.PlotStageView)
	UIStateManager.instance:popByName(ViewName.ResStageView)

	if ViewMgr.instance:isOpen(ViewName.SclevelsView) then
		UIStateManager.instance:clear(true)
	end

	if not taskStep or taskStep:showTaskCompelete() then
		ViewMgr.instance:open(ViewName.TaskCompelete, taskStep)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OpenTaskCompleteView)
end

function TaskController:_openTalentView(petId)
	UIStateManager.instance:push(ViewName.PetShowView, 3, petId)
end

function TaskController:_gotoMonsterByTarget(target)
	self:stopAction()

	if not self:_isSceneValid() then
		return
	end

	local raceId = target:getPetId()
	local mstIds = SceneConfig.instance:getMonstersByRaceId(raceId)

	self:_startGotoSceneMonsterByTarget(mstIds)
end

function TaskController:_startGuideTaskCSTZTarget(target)
	local npcId = target:getBattleNpcId()

	self._runningPveBattle = target

	if npcId and npcId ~= 0 then
		if npcId == SceneFacade.InvalidNpcId then
			FuncOpenController.instance:openFuncByViewName(ViewName.LegendmapView)
		else
			self._runningAction = TActionFactory.createTAction(TaskConst.GOTONPC, target, npcId)
		end
	else
		FuncOpenController.instance:openFuncByViewName(ViewName.LegendmapView)
	end
end

function TaskController:_startGotoSceneMonsterByTarget(mstIds)
	if mstIds then
		local cnt = #mstIds
		local currSceneId = self._currCityScene:getSceneId()

		for i = 1, cnt do
			local sceneId = SceneConfig.instance:getMonsterSceneId(mstIds[i])

			if currSceneId == sceneId then
				self._runningAction = TActionFactory.createTAction(TaskConst.GOTOMONSTER, mstIds[i])

				return
			end
		end

		self._runningAction = TActionFactory.createTAction(TaskConst.GOTOMONSTER, mstIds[1])
	end
end

function TaskController:_gotoSourceMonByTarget(target)
	self:stopAction()
	FloatWordMgr.instance:show("源兽捕捉功能已被移除")
end

function TaskController:startGotoSourceMonByTarget(mstIds)
	self:stopAction()

	if mstIds then
		local cnt = #mstIds
		local currSceneId = self._currCityScene:getSceneId()
		local monsterMgr = self._currCityScene.monsterMgr

		for i = 1, cnt do
			local sceneId = SceneConfig.instance:getMonsterSceneId(mstIds[i])

			if currSceneId == sceneId and monsterMgr then
				local mstInsId = monsterMgr:getMonsterInsIds(mstIds[i])

				if mstInsId then
					self._runningAction = TActionFactory.createTAction(TaskConst.GOTOSOURCEMON, mstIds[i])

					return
				end
			end
		end

		for i = 1, cnt do
			local sceneId = SceneConfig.instance:getMonsterSceneId(mstIds[i])

			if currSceneId == sceneId then
				self._runningAction = TActionFactory.createTAction(TaskConst.GOTOSOURCEMON, mstIds[i])

				return
			end
		end

		self._runningAction = TActionFactory.createTAction(TaskConst.GOTOSOURCEMON, mstIds[1])
	end
end

function TaskController:_startUserAction(target)
	local collectNpc = target:getCollectNpcId()

	if collectNpc and collectNpc > 0 then
		self._runningAction = TActionFactory.createTAction(TaskConst.GOTONPC, target, collectNpc)

		return
	end

	local tSceneId = target:getSceneId()
	local tTriggerId = target:getTriggerId() or 0

	if tSceneId and tSceneId ~= 0 then
		self._runningAction = TActionFactory.createTAction(TaskConst.GOTOSCENETRIGGER, target)

		return
	end
end

function TaskController:_openPetTaskGuideUI(target)
	local targetType = target:getTargetType()

	if targetType == TaskConst.TSTEP_TARGET_EQUIPSTARGODTIMES then
		local petId = BagModel.instance:getPetIdForEquipStargod()

		BagPetsController.instance:openBagPetView(petId, ViewName.StargodplusmainView)

		return true
	end

	if targetType == TaskConst.TSTEP_TARGET_EQUIPMENTTIMES then
		local bagPetId = PetEquipController.instance:getPetIdForEquipLevelUp()

		BagPetsController.instance:openBagPetView(bagPetId, ViewName.PetEquip)

		return true
	end

	if targetType == TaskConst.TSTEP_TARGET_PETLEVEL then
		local petId = BagModel.instance:getPetIdForLevelUp()

		BagPetsController.instance:openBagPetView(petId, ViewName.PetShowInfo)

		return true
	elseif targetType == TaskConst.TSTEP_TARGET_EQUIPMENTLEVELUPTIMES then
		local bagPetId = PetEquipController.instance:getPetIdForEquipLevelUp()

		BagPetsController.instance:openBagPetView(bagPetId, ViewName.PetEquip)

		return true
	elseif targetType == TaskConst.TSTEP_TARGET_LEVELTO then
		local level = target.target.level
		local petId = BagModel.instance:getPetIdForLevelUp(level)

		BagPetsController.instance:openBagPetView(petId, ViewName.PetShowInfo)

		return true
	elseif targetType == TaskConst.TSTEP_TARGET_GENIUSTIMES then
		local petId = target.target.petId
		local bagPetId = BagModel.instance:getPetIdForTalentLevelUp({
			petId
		})

		BagPetsController.instance:openBagPetView(bagPetId, ViewName.PetTalent)

		return true
	elseif targetType == TaskConst.TSTEP_TARGET_GENIES then
		local petIds = target.target.petIds
		local geniusLevel = target.target.geniusLevel
		local bagPetId = BagModel.instance:getPetIdForTalentLevelUp(petIds, geniusLevel)

		BagPetsController.instance:openBagPetView(bagPetId, ViewName.PetTalent)

		return true
	elseif targetType == TaskConst.TSTEP_TARGET_PETRECORD and target.target.recordType == TaskConst.PetRecordType_Genius then
		local level = target.target.level
		local bagPetId = BagModel.instance:getPetIdForTalentLevelUp(nil, level)

		BagPetsController.instance:openBagPetView(bagPetId, ViewName.PetTalent)

		return true
	elseif targetType == TaskConst.TSTEP_TARGET_PETRECORD and target.target.recordType == TaskConst.PetRecordType_Level then
		local level = target.target.level
		local petId = BagModel.instance:getPetIdForLevelUp(level)

		BagPetsController.instance:openBagPetView(petId, ViewName.PetShowInfo)

		return true
	elseif targetType == TaskConst.TSTEP_TARGET_GENIES_LEVEL then
		local petIds = target.target.petIds
		local bagPetId = BagModel.instance:getPetIdForTalentLevelUp(petIds)

		BagPetsController.instance:openBagPetView(bagPetId, ViewName.PetTalent)

		return true
	elseif TaskConst.TSTEP_TARGET_ACHIEVEMENTDATA == targetType then
		local achievementId = target.target.achievementId
		local isHasEnd = AchievementModel.instance:isHasEndOfTask(achievementId)

		if isHasEnd then
			FloatWordMgr.instance:show("已结束")

			return true
		end

		local cfg = AchievementConfig.instance:getCfgById(achievementId)

		if cfg and cfg.root == 2 then
			if cfg.leaf == 1 then
				local petId = BagModel.instance:getPetIdForLevelUp(self:_getAchievementGuideLevel(cfg))

				BagPetsController.instance:openBagPetView(petId, ViewName.PetShowInfo)

				return true
			elseif cfg.leaf == 2 then
				local petId = target.target.petId
				local bagPetId = BagModel.instance:getPetIdForTalentLevelUp({
					petId
				}, self:_getAchievementGuideLevel(cfg))

				BagPetsController.instance:openBagPetView(bagPetId, ViewName.PetTalent)

				return true
			elseif cfg.leaf == 3 then
				local bagPetId = PetEquipController.instance:getPetIdForEquipLevelUp()

				BagPetsController.instance:openBagPetView(bagPetId, ViewName.PetEquip)

				return true
			end
		elseif cfg and cfg.root == 5 and cfg.leaf == 2 then
			UIStateManager.instance:push(ViewName.Lottery)

			return true
		end
	end
end

function TaskController:_getAchievementGuideLevel(cfg)
	if string.nilorempty(cfg.detectorParam) then
		return
	end

	local params = string.split(cfg.detectorParam, ",")

	for i = 1, #params do
		local t_params = string.split(params[i], ":")

		if t_params[1] == "等级" then
			return checknumber(t_params[2])
		end
	end
end

function TaskController:_openTaskGuideUI(target)
	if self:_openPetTaskGuideUI(target) then
		return
	end

	local uiName, uiParams, uiTab = target:getTaskGuideUI()

	if uiName then
		if uiName == ViewName.BagPets then
			uiName = ViewName.PetView
		end

		if uiName == "Arena" then
			ArenaController.instance:openArenaSafe()
		elseif uiName == "jump_challenge" then
			local challengeId = tonumber(uiParams)
			local battleNpc = UnlockFacade.instance:getChallengeNpc(challengeId)

			if not battleNpc or battleNpc == 0 then
				ChallengeFacade.instance:startChallange(challengeId)
			else
				self._runningAction = TActionFactory.createTAction(TaskConst.GOTONPC, target, battleNpc)
			end
		elseif uiName == "jump_catch_monster" then
			self:_gotoMonsterByTarget(target)
		elseif uiName == ViewName.ExpMap then
			FuncOpenController.instance:openFunc(52)
		else
			uiParams = self:_handleUIParams(uiName, uiParams)

			if not uiTab or #uiTab == 0 then
				if not uiParams or #uiParams == 0 then
					UIStateManager.instance:push(uiName)
				else
					UIStateManager.instance:push(uiName, uiParams)
				end
			elseif not uiParams or #uiParams == 0 then
				UIStateManager.instance:push(uiName, tonumber(uiTab))
			else
				UIStateManager.instance:push(uiName, tonumber(uiTab), tonumber(uiParams))
			end
		end
	end
end

function TaskController:_openTaskJJCGuideUI(target)
	local uiName, uiParams, uiTab = target:getTaskGuideUI()

	if uiName then
		self:_openTaskGuideUI(target)
	else
		ArenaController.instance:openArenaSafe()
	end
end

function TaskController:_openTaskStoryCopyGuideUI(target)
	if target.target.battleType == TaskConst.BattleType_None then
		PlotCopyController.instance:enterCopy(target.target.copyId, target.target.levelId)
	elseif target.target.battleType == TaskConst.BattleType_Immediately then
		PlotCopyController.instance:enterCopy(target.target.copyId, target.target.levelId)
	elseif target.target.battleType == TaskConst.BattleType_Mission then
		PlotCopyController.instance:enterCopy(target.target.copyId, target.target.levelId)
	else
		PlotCopyController.instance:enterCopy(target.target.copyId, target.target.levelId)
	end
end

function TaskController:_openTaskStoryResCopyGuideUI(target)
	if target.target.battleType == TaskConst.BattleType_None then
		MaterialChallengeController.instance:enterStageView(target.target.copyId, target.target.levelId)
	elseif target.target.battleType == TaskConst.BattleType_Immediately then
		MaterialChallengeController.instance:enterStageView(target.target.copyId, target.target.levelId)
	elseif target.target.battleType == TaskConst.BattleType_Mission then
		MaterialChallengeController.instance:enterStageView(target.target.copyId, target.target.levelId)
	else
		MaterialChallengeController.instance:enterStageView(target.target.copyId, target.target.levelId)
	end
end

function TaskController:_openTaskPetTrainningGuideUI(target)
	local uiName, uiParams, uiTab = target:getTaskGuideUI()

	if uiName == ViewName.PetTrialDetail then
		if ((uiParams or nil) and checknumber(uiParams)) == 0 then
			uiName = nil
			uiParams = nil
			uiTab = nil
		end
	end

	if not uiName then
		UIStateManager.instance:push(ViewName.PetTrial)
	else
		self:_openTaskGuideUI(target)
	end
end

function TaskController:_handleUIParams(uiName, uiParams)
	if not uiParams or #uiParams == 0 then
		return uiParams
	end

	if uiName == ViewName.PetShowView and uiParams then
		local petIds = string.split(uiParams, "#")

		for i = 1, #petIds do
			local petId = tonumber(petIds[i])

			if BagModel.instance:isExistRaceId(petId) then
				return petIds[i]
			end
		end
	end

	return uiParams
end

function TaskController:_openTaskDialog()
	self:_closeTaskDialogWhileOpening()

	local dialog = self._performeding.dialog

	ViewMgr.instance:open(ViewName.TaskDialog, self._performeding)

	if not TaskConst.isDialogBlockTask(dialog) then
		self:_onTaskDialogSure()
	end
end

function TaskController:_closeTaskDialogWhileOpening()
	if ViewMgr.instance:isOpen(ViewName.TaskDialog) then
		self:_onTaskDialogCancel()
		ViewMgr.instance:close(ViewName.TaskDialog)
	end
end

function TaskController:_onTaskDialogSure()
	if self._performeding and self._performeding.method == TaskConst.PM_DIALOG then
		self:_onPerformingFinish()
	end
end

function TaskController:_onTaskDialogCancel()
	if self._performeding and self._performeding.method == TaskConst.PM_DIALOG then
		self._performeding = nil
	end
end

function TaskController:_openCollectView(target)
	self:_closeCollectViewWhileOpening()

	self._uiActionTarget = nil
	self._collectingTask = nil

	if target.target.actionType == TaskConst.USER_OP_UI_INTERACTIVE and target.target.chatStoryId then
		self._uiActionTarget = target

		GlobalDispatcher:dispatch(GlobalNotify.PushStory, target.target.chatStoryId)

		return
	end

	self._collectingTask = target

	ViewMgr.instance:open(ViewName.TaskCollect, target)
end

function TaskController:_closeCollectViewWhileOpening()
	if ViewMgr.instance:isOpen(ViewName.TaskCollect) then
		ViewMgr.instance:close(ViewName.TaskCollect)
	end

	self._collectingTask = nil
	self._uiActionTarget = nil
end

function TaskController:_onTaskCollectBreak()
	self:_closeCollectViewWhileOpening()

	self._collectingTask = nil
	self._uiActionTarget = nil
end

function TaskController:_onTaskCollectFinish()
	if self._collectingTask:isCompeleted() then
		self:_preHandlerCompeleteTaskTarget(self._collectingTask.taskStep, self._collectingTask)
	else
		self:requestCompeleteTaskTarget(self._collectingTask.taskStep, self._collectingTask)
	end

	self._collectingTask = nil
	self._uiActionTarget = nil
end

function TaskController:onUIInteractiveFinish()
	if not self._uiActionTarget then
		return
	end

	if self._uiActionTarget:isCompeleted() then
		self:_preHandlerCompeleteTaskTarget(self._uiActionTarget.taskStep, self._uiActionTarget)
	else
		self:requestCompeleteTaskTarget(self._uiActionTarget.taskStep, self._uiActionTarget)
	end

	self._uiActionTarget = nil
end

function TaskController:_openUseItemView(target)
	self:_closeUseItemViewWhileOpening()

	self._useItemTask = target

	ViewMgr.instance:open(ViewName.TaskUseItem, target)
end

function TaskController:_closeUseItemViewWhileOpening()
	if ViewMgr.instance:isOpen(ViewName.TaskUseItem) then
		ViewMgr.instance:close(ViewName.TaskUseItem)
	end

	self._useItemTask = nil
end

function TaskController:_onTaskUseItemBreak()
	self:_closeUseItemViewWhileOpening()

	self._useItemTask = nil
end

function TaskController:_onTaskUseItemFinish()
	self:requestCompeleteTaskTarget(self._useItemTask.taskStep, self._useItemTask)

	self._useItemTask = nil
end

function TaskController:_openTaskPerformUI()
	local uiName = self._performeding.uiName
	local uiParams = self._performeding.uiParams

	if uiParams then
		UIStateManager.instance:push(uiName, uiParams)
	else
		UIStateManager.instance:push(uiName)
	end
end

function TaskController:_onTaskPerformUIClose()
	if self._performeding and self._performeding.method == TaskConst.PM_UI then
		self:_onPerformingFinish()
	end
end

function TaskController:onMaterialGet(msg)
	local items = msg.items

	for i, v in ipairs(items) do
		if v.materialType == MatType.Item and v.items then
			local cnt = #v.items

			for i = 1, cnt do
				local taskes = TaskModel.instance:getTaskesRelateToItemId(v.items[i].id)

				if taskes then
					local taskCnt = #taskes

					for k = 1, taskCnt do
						local taskStep = taskes[k]
						local state = taskStep:getState()

						if state == TaskConst.TSTEP_S_UNAVAILABLE then
							self:_handleGetMaterialOnUnTriggered(taskStep, v.items[i].id)
						elseif state == TaskConst.TSTEP_S_ACCEPTED then
							self:_handleGetMaterialOnAccpted(taskStep, v.items[i].id)
						end
					end
				end
			end
		end
	end
end

function TaskController:_handleGetMaterialOnUnTriggered(taskStep, itemId)
	return
end

function TaskController:_handleGetMaterialOnAccpted(taskStep, itemId)
	if taskStep:isCompeleted() then
		taskStep:setState(TaskConst.TSTEP_S_COMPELETED)
	else
		taskStep:setState(TaskConst.TSTEP_S_ACCEPTED)
	end

	self:localNotify(TaskConst.ON_TASK_PROGRESS, taskStep:getTaskId())
end

function TaskController:onSceneLoadedFinish(sceneType, sceneId)
	if sceneType ~= SceneType.City or not TaskModel.instance.isReady then
		self._currCityScene = nil

		return
	else
		self._currCityScene = SceneMgr.instance:getCurScene()
	end

	self:_handleTaskNpcsOnScene(sceneId)
	self:_handleFollowNpcs(sceneId)
	self:_handleSceneTriggerOnScneLoaded(sceneId)
	self:_handleDynamicBarriersOnSceneLoaded(sceneId)
	self:_handleDynamicNpcsOnSceneLoaded(sceneId)
	self:_hidePlayersOnSceneLoaded()
	self:_handleAutoActionOnSceneLoaded()

	self._toHandleTaskIds = nil
	self._runningPveBattle = nil
end

function TaskController:_handleFollowNpcs(sceneId)
	local taskes = TaskModel.instance:getTaskes()

	if not taskes then
		return
	end

	local followDis = 1

	for k, v in pairs(taskes) do
		followDis = self:_checkFollowNpcs(sceneId, v, followDis)
	end
end

function TaskController:_handleFollowNpcsOnThisScene()
	if not self:_isSceneValid() then
		return
	end

	local sceneId = self._currCityScene:getSceneId()

	self:_handleFollowNpcs(sceneId)
end

function TaskController:_checkFollowNpcs(sceneId, task, followDis)
	local currStep = task.currStep

	if currStep and currStep.targets then
		for i = 1, #currStep.targets do
			if not currStep.targets[i]:isCompeleted() and currStep:isTargetRunnable(currStep.targets[i]) then
				local followNpcs = currStep.targets[i]:getFollowNpcIds()

				if followNpcs and #followNpcs > 0 then
					for j = 1, #followNpcs do
						local unitNpc = self:_createNpc(followNpcs[j], sceneId)

						if unitNpc then
							followDis = followDis + 0.2

							local disCfg = {
								0,
								followDis + 0.1,
								followDis
							}

							unitNpc:followTarget(SceneMainPlayer.instance:getMainPlayer(), disCfg)
						end
					end
				end
			end
		end
	end

	return followDis
end

function TaskController:_removeFollowNpcs(taskStep)
	if not self:_isSceneValid() then
		return
	end

	if taskStep and taskStep.targets then
		for i = 1, #taskStep.targets do
			if taskStep.targets[i]:isCompeleted() then
				local followNpcs = taskStep.targets[i]:getFollowNpcIds()

				if followNpcs and #followNpcs > 0 then
					for j = 1, #followNpcs do
						self._currCityScene.unitFactory:destroyNpcById(followNpcs[j])
					end
				end
			end
		end
	end
end

function TaskController:_handleAutoActionOnSceneLoaded()
	if self._performeding then
		if self._performeding.method == TaskConst.PM_PETBATTLE then
			self:_onPerformingFinish()
		end

		return
	end

	if self._runningPveBattle and self._toHandleTaskIds and self._toHandleTaskIds[self._runningPveBattle.taskStep:getTaskId()] then
		local performed = self._runningPveBattle:getBattleResultPerformed()

		if performed and not performed.hasPerformed then
			self._runningPveBattle = nil

			self:_startPerformed(performed)

			return
		end
	end

	if self._runningPveBattle and self._toHandleTaskIds and self._toHandleTaskIds[self._runningPveBattle.taskStep:getTaskId()] then
		self:_handlePveBattleTaskOnSceneLoaded()
	else
		self:_handleLatestTaskesOnSceneLoaded()
	end

	if self._openTaskCompOnSceneLoaded then
		self:_openTaskCompeleteView(self._compTaskStepOnExitScene)
	end
end

function TaskController:_handlePveBattleTaskOnSceneLoaded()
	local playStory
	local pveBattle = self._runningPveBattle

	self._runningPveBattle = nil

	self:startCheckAutoCommit()
	self:startCheckAutoTask()
	self:startAutoActionByTaskId(pveBattle.taskStep:getTaskId())
	self:endCheckAutoCommit()
	self:endCheckAutoTask()
end

function TaskController:_handleLatestTaskesOnSceneLoaded()
	if self._enterFirstly and TaskModel.instance.isReady then
		self._enterFirstly = nil

		if not self._toHandleTaskIds then
			local autoCmtTask = self:_getAutoCommitOrRunTask()

			if autoCmtTask then
				self._toHandleTaskIds = {}
				self._toHandleTaskIds[autoCmtTask:getTaskId()] = true
			end
		end
	end

	if self._toHandleTaskIds then
		self:startCheckAutoCommit()
		self:startCheckAutoTask()

		for k, v in pairs(self._toHandleTaskIds) do
			self:startAutoActionByTaskId(k)

			break
		end

		self:endCheckAutoCommit()
		self:endCheckAutoTask()
	end
end

function TaskController:_getAutoCommitOrRunTask()
	local taskes = TaskModel.instance:getCurrentTriggerTask()

	if not taskes then
		return
	end

	for i = 1, #taskes do
		if taskes[i]:isCompeleted() and not taskes[i]:forbidAutoCommit() then
			return taskes[i]
		end

		if not taskes[i]:forbidAutoTask() then
			local tgts = taskes[i].targets

			if tgts then
				for j = 1, #tgts do
					if not tgts[j]:isCompeleted() and tgts[j]:getTargetType() == TaskConst.TSTEP_TARGET_CHAT_NPC and not SceneConfig.instance:getNpcCo(tgts[j]:getChatNpcId()) then
						return taskes[i]
					end
				end
			end
		end
	end
end

function TaskController:_isSceneValid(sceneId)
	if not self._currCityScene then
		return
	end

	if not self._currCityScene.isReady then
		return
	end

	if self._currCityScene:getSceneType() ~= SceneType.City then
		return
	end

	if sceneId then
		return self._currCityScene:getSceneId() == sceneId
	end

	return true
end

function TaskController:_handleSceneTriggerOnScneLoaded(sceneId)
	local taskSteps = TaskModel.instance:getTaskesRelateToScene(sceneId)
	local count = #taskSteps

	if count > 0 then
		for i = 1, count do
			local taskStep = taskSteps[i]
			local state = taskStep:getState()

			if state == TaskConst.TSTEP_S_UNAVAILABLE then
				self:_handleUnTriggeredOnEnterScene(taskStep, sceneId)
			elseif state == TaskConst.TSTEP_S_ACCEPTED then
				self:_handleAcceptedOnEnterScene(taskStep, sceneId)
			end
		end
	end
end

function TaskController:_handleDynamicBarriersOnSceneLoaded(sceneId)
	self:_handleTaskesDynamicBarriers(TaskModel.instance:getTaskes(), sceneId)
	self:_handleTaskesDynamicBarriers(TaskModel.instance:getAllUnavailableTaskes(), sceneId)
end

function TaskController:_handleTaskesDynamicBarriers(taskes, sceneId)
	if not taskes then
		return
	end

	for k, v in pairs(taskes) do
		local taskId = v:getTaskId()
		local barrierIds = v:getAllBarrierIds()

		if barrierIds then
			local cnt = #barrierIds

			for k = 1, cnt do
				local stepId = barrierIds[k][1]

				if not TaskModel.instance:isTaskStepFinished(taskId, stepId) then
					self:_triggerBarrieres(barrierIds[k], sceneId, true)
				end
			end
		end
	end
end

function TaskController:_triggerBarrieres(barrierIds, sceneId, triggered)
	local cnt = #barrierIds

	for i = 2, cnt do
		local idStr = tostring(barrierIds[i])
		local sceneIdStr = tostring(sceneId)
		local len = #sceneIdStr

		if len <= #idStr then
			local sId = tonumber(string.sub(idStr, 1, len))

			BarriersMgr.instance:triggerBarrierGroup(sId, barrierIds[i], triggered)
		end
	end
end

function TaskController:_removeGoingTaskStepBarrieres(taskStep)
	if not self:_isSceneValid() then
		return
	end

	if self._performeding and self._performeding.method == TaskConst.PM_STORY and self._performeding.taskStep == taskStep then
		return
	end

	local sceneId = self._currCityScene:getSceneId()
	local barrierIds = taskStep.task:getBarrierIds(taskStep:getStepId())

	if barrierIds then
		self:_triggerBarrieres(barrierIds, sceneId, false)
	end
end

function TaskController:_handleDynamicNpcsOnSceneLoaded(sceneId)
	self:_handleTaskesNpcsBarriers(TaskModel.instance:getTaskes(), sceneId)
	self:_handleTaskesNpcsBarriers(TaskModel.instance:getAllUnavailableTaskes(), sceneId)
end

function TaskController:_handleTaskesNpcsBarriers(taskes, sceneId)
	if not taskes then
		return
	end

	for k, v in pairs(taskes) do
		local taskId = v:getTaskId()
		local npcIds = v:getAllBarrierNpcs()

		if npcIds then
			local cnt = #npcIds

			for k = 1, cnt do
				local stepId = npcIds[k][1]

				if not TaskModel.instance:isTaskStepFinished(taskId, stepId) then
					self:_triggerNpcs(npcIds[k], sceneId, true)
				end
			end
		end
	end
end

function TaskController:_triggerNpcs(npcIds, sceneId, triggered)
	local cnt = #npcIds

	for i = 2, cnt do
		local idStr = tostring(npcIds[i])
		local len = #idStr
		local sId = tonumber(string.sub(idStr, 1, len - 4))

		if sId == sceneId then
			self:_createNpc(npcIds[i], sceneId)
			self:_handleSceneNpcHuds(npcIds[i])
		end
	end
end

function TaskController:_removeGoingTaskStepDyanamicNpcs(taskStep)
	if not self:_isSceneValid() then
		return
	end

	if TaskModel.instance:isTaskStepFinished(taskStep:getTaskId(), taskStep:getStepId()) then
		if self._performeding and self._performeding.method == TaskConst.PM_STORY and self._performeding.taskStep == taskStep then
			return
		end

		if TaskModel.instance:isTaskStepFinished(taskStep:getTaskId(), taskStep:getStepId()) then
			local sceneId = self._currCityScene:getSceneId()
			local npcIds = taskStep.task:getBarrierNpcs(taskStep:getStepId())

			if npcIds then
				local cnt = #npcIds

				for i = 2, cnt do
					self._currCityScene.unitFactory:destroyNpcById(npcIds[i])
				end
			end
		end
	end
end

function TaskController:_handleUnTriggeredOnEnterScene(taskStep, sceneId)
	local tSceneId, tTriggerId = taskStep.task:getTriggerSceneIdAndTriggerId()

	if tSceneId and tSceneId == sceneId then
		if tTriggerId and tTriggerId ~= 0 then
			TriggersMgr.instance:createTrigger(tSceneId, tTriggerId)
		else
			self:_onEnterSceneTrigger(sceneId, 0)
		end
	end
end

function TaskController:_handleAcceptedOnEnterScene(taskStep, sceneId)
	if taskStep.targets then
		local tgtCount = #taskStep.targets

		for k = 1, tgtCount do
			local tgt = taskStep.targets[k]
			local tSceneId = tgt:getSceneId()
			local tTriggerId = tgt:getTriggerId()

			if tSceneId and tSceneId == sceneId then
				if tTriggerId and tTriggerId ~= 0 then
					self._currCityScene:createTrigger(tTriggerId)
				else
					self:_onEnterSceneTrigger(sceneId, 0)
				end
			end
		end
	end
end

function TaskController:_onMofangLvUp()
	local taskSteps = TaskModel.instance:getTaskesRelateToMofang()
	local count = #taskSteps

	if count > 0 then
		for i = 1, count do
			local taskStep = taskSteps[i]
			local state = taskStep:getState()

			if state == TaskConst.TSTEP_S_UNAVAILABLE and TaskModel.instance:shouldTaskTrigger(taskStep.task, true) then
				self:triggerTask(taskStep)
			end
		end
	end
end

function TaskController:_onColorfulEggsData(colorfulEggId)
	local eggCo = ColorfulEggConfig.instance:getColorfulEggCo(colorfulEggId)

	if eggCo.taskId > 0 then
		local task = TaskModel.instance:getUnavailableTaskes(eggCo.taskId)

		if task and TaskModel.instance:shouldTaskTrigger(task, true) then
			local taskStep = task.currStep

			self:requestAcceptTask(taskStep)
		end
	end
end

function TaskController:_onPlayerStrengthChange()
	local taskSteps = TaskModel.instance:getTaskesRelateToMaxFP()
	local count = #taskSteps

	if count > 0 then
		for i = 1, count do
			local taskStep = taskSteps[i]
			local state = taskStep:getState()

			if state == TaskConst.TSTEP_S_UNAVAILABLE and TaskModel.instance:shouldTaskTrigger(taskStep.task, true) then
				self:triggerTask(taskStep)
			end
		end
	end
end

function TaskController:_onEnterSceneTrigger(sceneId, triggerId)
	if not self:_isSceneValid(sceneId) then
		return
	end

	local taskSteps = TaskModel.instance:getTaskesRelateToScene(sceneId)
	local count = #taskSteps

	if count > 0 then
		for i = 1, count do
			local taskStep = taskSteps[i]
			local state = taskStep:getState()

			if state == TaskConst.TSTEP_S_UNAVAILABLE then
				self:_handleUnTriggeredOnEnterSceneTrigger(taskStep, sceneId, triggerId, true)
			elseif state == TaskConst.TSTEP_S_ACCEPTED then
				self:_handleAcceptedOnEnterSceneTrigger(taskStep, sceneId, triggerId, true)
			end
		end
	end
end

function TaskController:_onLeaveSceneTrigger(sceneId, triggerId)
	if not self:_isSceneValid(sceneId) then
		return
	end

	local taskSteps = TaskModel.instance:getTaskesRelateToScene(sceneId)
	local count = #taskSteps

	if count > 0 then
		for i = 1, count do
			local taskStep = taskSteps[i]
			local state = taskStep:getState()

			if state == TaskConst.TSTEP_S_UNAVAILABLE then
				self:_handleUnTriggeredOnEnterSceneTrigger(taskStep, sceneId, triggerId, nil)
			elseif state == TaskConst.TSTEP_S_ACCEPTED then
				self:_handleAcceptedOnEnterSceneTrigger(taskStep, sceneId, triggerId, nil)
			end
		end
	end
end

function TaskController:_handleUnTriggeredOnEnterSceneTrigger(taskStep, sceneId, triggerId, enter)
	local tSceneId, tTriggerId = taskStep.task:getTriggerSceneIdAndTriggerId()

	if tSceneId == sceneId and tTriggerId == triggerId then
		if enter then
			self:triggerTask(taskStep)
		else
			self:_closeTaskDialogWhileOpening()
		end
	end
end

function TaskController:_handleAcceptedOnEnterSceneTrigger(taskStep, sceneId, triggerId, enter)
	if taskStep.targets then
		local tgtCount = #taskStep.targets

		for k = 1, tgtCount do
			local tgt = taskStep.targets[k]

			if not tgt:isCompeleted() and not tgt.sendCompeleted and tgt.taskStep:isTargetRunnable(tgt) then
				local tSceneId = tgt:getSceneId()
				local tTriggerId = tgt:getTriggerId()

				if tSceneId == sceneId and tTriggerId == triggerId then
					local targetType = tgt:getTargetType()

					if targetType == TaskConst.TSTEP_TARGET_USERACTION then
						if enter then
							self:_openCollectView(tgt)

							break
						end

						self:_closeCollectViewWhileOpening()

						break
					end

					if enter and targetType == TaskConst.TSTEP_TARGET_USEITEM then
						self:_openUseItemView()

						break
					end

					if enter and not tgt:isCompeleted() then
						if targetType == TaskConst.TSTEP_TARGET_SEARCH then
							self:_preHandlerCompeleteTaskTarget(taskStep, tgt)

							break
						end

						self:requestCompeleteTaskTarget(taskStep, tgt)

						break
					end

					self:_closeTaskDialogWhileOpening()

					break
				end
			end
		end
	end
end

function TaskController:_removeUnTriggeredSceneTrigger(taskStep)
	if not self._currCityScene then
		return
	end

	local tSceneId, tTriggerId = taskStep.task:getTriggerSceneIdAndTriggerId()

	if tSceneId and tTriggerId and not TaskModel.instance:isTriggerUsing(tSceneId, tTriggerId) then
		TriggersMgr.instance:removeTrigger(tSceneId, tTriggerId)
	end
end

function TaskController:_createGoingTaskTargetSceneTrigger(taskStep)
	if not self._currCityScene then
		return
	end

	local sceneId = self._currCityScene:getSceneId()

	if taskStep.targets then
		local count = #taskStep.targets

		for i = 1, count do
			local target = taskStep.targets[i]
			local tSceneId = target:getSceneId()
			local tTriggerId = target:getTriggerId()

			if tSceneId and tTriggerId and sceneId == tSceneId and tTriggerId ~= 0 and not target:isCompeleted() then
				TriggersMgr.instance:createTrigger(tSceneId, tTriggerId)
			end
		end
	end
end

function TaskController:_removeGoingTaskTargetSceneTrigger(target)
	local tSceneId = target:getSceneId()
	local tTriggerId = target:getTriggerId()

	if tSceneId and tTriggerId and not TaskModel.instance:isTriggerUsing(tSceneId, tTriggerId) then
		TriggersMgr.instance:removeTrigger(tSceneId, tTriggerId)
	end
end

function TaskController:_handleTaskNpcsOnScene(sceneId)
	if not self:_isSceneValid(sceneId) then
		return
	end

	local npcIds = TaskModel.instance:getTaskesRelateToSceneWithNpcs(sceneId)

	if npcIds then
		local count = #npcIds

		for i = 1, count do
			self:_createNpc(npcIds[i], sceneId)
			self:_handleSceneNpcHuds(npcIds[i])
		end
	end
end

function TaskController:_handleTaskNpcsOnThisScene()
	if not self:_isSceneValid() then
		return
	end

	local sceneId = self._currCityScene:getSceneId()

	self:_handleTaskNpcsOnScene(sceneId)
end

function TaskController:_handleAllSceneNpcsHuds(sceneId)
	if not self:_isSceneValid(sceneId) then
		return
	end

	local npcIds = TaskModel.instance:getTaskesRelateToSceneWithNpcs(sceneId)

	if npcIds then
		local count = #npcIds

		for i = 1, count do
			self:_handleSceneNpcHuds(npcIds[i])
		end
	end
end

function TaskController:getNpcTaskState(npcId)
	local accepted, compeleted
	local taskes = TaskModel.instance:getTaskesRelateToNpc(npcId)

	if taskes then
		local count = #taskes

		for i = 1, count do
			local taskStep = taskes[i]
			local state = taskStep:getState()

			if state == TaskConst.TSTEP_S_UNAVAILABLE then
				if not accepted then
					local accpetNpcId = taskStep:getAcceptNpcId()

					if accpetNpcId == npcId then
						accepted = true
					end
				end
			elseif state == TaskConst.TSTEP_S_ACCEPTED then
				if not compeleted and taskStep:getTargetNum() == 1 and taskStep.targets[1]:getChatNpcId() == npcId and taskStep:getCommitNpcId() == npcId then
					compeleted = true
				end
			elseif state == TaskConst.TSTEP_S_COMPELETED and not compeleted then
				local cmtNpcId = taskStep:getCommitNpcId()

				if cmtNpcId == npcId and not taskStep.hasSentFinishProto and (not self._performeding or self._performeding.performedType ~= TaskConst.PERFORMED_FINISHED or self._performeding.taskStep ~= taskStep) then
					compeleted = true
				end
			end
		end
	end

	return accepted, going, compeleted
end

function TaskController:_setSceneNpcHudsType(unitNpc, accepted, going, compeleted)
	if compeleted then
		unitNpc.hudTask:setCompeleted(true)
		unitNpc.hudTask:setAccepted(nil)
	elseif accepted then
		unitNpc.hudTask:setCompeleted(nil)
		unitNpc.hudTask:setAccepted(true)
	else
		unitNpc.hudTask:setCompeleted(nil)
		unitNpc.hudTask:setAccepted(nil)
	end
end

function TaskController:_handleSceneNpcHuds(npcId)
	local unitNpc = self._currCityScene.unitFactory:getUnit(UnitTag.Npc, npcId)

	if not unitNpc then
		return
	end

	local accepted, compeleted, going = self:getNpcTaskState(npcId)

	self:_setSceneNpcHudsType(unitNpc, accepted, compeleted, going)
end

function TaskController:_createTaskNpcsOnScene(taskStep)
	if not self:_isSceneValid(sceneId) then
		return
	end

	local sceneId = self._currCityScene:getSceneId()
	local npcIds = taskStep:getAllRelateToNpcIds()

	if npcIds then
		local count = #npcIds

		for i = 1, count do
			self:_createNpc(npcIds[i], sceneId)
			self:_handleSceneNpcHuds(npcIds[i])
		end
	end
end

function TaskController:_clearTaskNpcsRelateToTaskStep(taskStep)
	if not self:_isSceneValid() then
		return
	end

	if self._performeding and self._performeding.method == TaskConst.PM_STORY and self._performeding.taskStep == taskStep then
		return
	end

	local npcIds = taskStep:getAllRelateToNpcIds(true)

	if npcIds then
		local count = #npcIds

		for i = 1, count do
			local npcId = npcIds[i]
			local npcCo = SceneConfig.instance:getNpcCo(npcId)

			if npcCo then
				if npcCo.funcType == UnitConst.NPC_TASK_TRIGGERD then
					local taskes = TaskModel.instance:getTaskesRelateToNpc(npcId, true)
					local isAllFinish = true

					if taskes then
						local tCount = #taskes

						for k = 1, tCount do
							if taskes[k]:getState() ~= TaskConst.TSTEP_S_FINISHED then
								isAllFinish = nil

								break
							end
						end
					end

					if isAllFinish then
						self._currCityScene.unitFactory:destroyNpcById(npcId)
					else
						self:_handleSceneNpcHuds(npcId)
					end
				else
					self:_handleSceneNpcHuds(npcId)
				end
			end
		end
	end
end

function TaskController:_createNpc(npcId, sceneId)
	local npcCo = SceneConfig.instance:getNpcCo(npcId)

	if not npcCo then
		return
	end

	if npcCo.sceneId == sceneId and npcCo.funcType == UnitConst.NPC_TASK_TRIGGERD then
		return self._currCityScene.unitFactory:createNpcById(npcId)
	end
end

function TaskController:handleSelectNpc(npcId)
	self:_closeTaskDialogWhileOpening()

	self._autoActionTaskId = nil

	local taskes = TaskModel.instance:getTaskesRelateToNpc(npcId)
	local taskIds
	local cnt = #taskes

	for i = 1, cnt do
		if self:_checkTaskOnSelectNpc(taskes[i], npcId) then
			taskIds = taskIds or {}

			table.insert(taskIds, taskes[i]:getTaskId())
		end
	end

	return taskIds
end

function TaskController:_checkTaskOnSelectNpc(taskStep, npcId)
	local state = taskStep:getState()

	if state == TaskConst.TSTEP_S_UNAVAILABLE then
		if self:_checkSelectNpcOnUnAccepted(taskStep, npcId) then
			return true
		end
	elseif state == TaskConst.TSTEP_S_ACCEPTED then
		if self:_checkSelectNpcOnAccepted(taskStep, npcId) then
			return true
		end
	elseif state == TaskConst.TSTEP_S_COMPELETED and self:_checkSelectNpcOnCompeleted(taskStep, npcId) then
		return true
	end
end

function TaskController:onSelectNpc(npcId)
	self:_closeTaskDialogWhileOpening()

	local taskes = TaskModel.instance:getTaskesRelateToNpc(npcId)
	local autoTask = self:_getAutoActionTask(taskes)

	self._autoActionTaskId = nil

	if autoTask and self:_handleTaskOnSelectNpc(autoTask, npcId) then
		return true
	end

	local cnt = #taskes

	for i = 1, cnt do
		if self:_handleTaskOnSelectNpc(taskes[i], npcId) then
			return true
		end
	end
end

function TaskController:onSelectNpcWithTask(npcId, taskId)
	self:_closeTaskDialogWhileOpening()

	self._autoActionTaskId = nil

	local task = TaskModel.instance:getTaskById(taskId)

	task = task or TaskModel.instance:getUnavailableTaskes(taskId)

	if task and self:_handleTaskOnSelectNpc(task.currStep, npcId) then
		return true
	end
end

function TaskController:checkNpcChat(npcId)
	local taskes = TaskModel.instance:getTaskesRelateToNpc(npcId)
	local cnt = #taskes

	for i = 1, cnt do
		local tgt = self:_checkTaskChatNpcWithNpc(taskes[i], npcId)

		if tgt then
			if not taskes[i]:isCompeleted() then
				local performing = tgt:getDoingPerformed()
				local finishedPerformed = tgt.finishedPerformed

				if finishedPerformed then
					finishedPerformed.hasPerformed = nil
				end

				if performing then
					performing.hasPerformed = nil

					self:_startPerformed(performing)
				end
			elseif taskes[i]:isCompeleted() then
				self:requestCompeleteTask(taskes[i])
			end

			return true
		end
	end
end

function TaskController:_checkTaskChatNpcWithNpc(taskStep, npcId)
	local tgts = taskStep.targets
	local index

	for j = 1, #tgts do
		local chatStoryId = tgts[j]:getChatStoryId()

		if chatStoryId and chatStoryId > 0 and tgts[j]:getTargetType() == TaskConst.TSTEP_TARGET_CHAT_NPC and tgts[j]:getChatNpcId() == npcId then
			index = j
		end
	end

	if index then
		return tgts[index]
	end
end

function TaskController:_handleTaskOnSelectNpc(taskStep, npcId)
	local state = taskStep:getState()

	if state == TaskConst.TSTEP_S_UNAVAILABLE then
		if self:_handleSelectNpcOnUnAccepted(taskStep, npcId) then
			return true
		end
	elseif state == TaskConst.TSTEP_S_ACCEPTED then
		if self:_handleSelectNpcOnAccepted(taskStep, npcId) then
			return true
		end
	elseif state == TaskConst.TSTEP_S_COMPELETED and self:_handleSelectNpcOnCompeleted(taskStep, npcId) then
		return true
	end
end

function TaskController:_checkSelectNpcOnUnAccepted(taskStep, npcId)
	if TaskModel.instance:shouldTaskTrigger(taskStep.task, true) and taskStep:shouldTrigger() and taskStep:getAcceptNpcId() == npcId then
		return true
	end
end

function TaskController:_handleSelectNpcOnUnAccepted(taskStep, npcId)
	if self:_checkSelectNpcOnUnAccepted(taskStep, npcId) then
		self:requestAcceptTask(taskStep)

		return true
	end
end

function TaskController:_checkSelectNpcOnAccepted(taskStep, npcId)
	if taskStep.targets then
		local tgtCount = #taskStep.targets

		for k = 1, tgtCount do
			local tgt = taskStep.targets[k]

			if not tgt:isCompeleted() and tgt.taskStep:isTargetRunnable(tgt) then
				if tgt:getChatNpcId() == npcId then
					return tgt
				elseif tgt:getCollectNpcId() == npcId then
					return tgt
				elseif tgt:getBattleNpcId() == npcId and tgt:getTargetType() == TaskConst.TSTEP_TARGET_PVE and (tgt.target.directStart or tgt.target.battleNpcOpenUI) then
					return tgt
				end
			end
		end
	end
end

function TaskController:_handleSelectNpcOnAccepted(taskStep, npcId)
	local tgt = self:_checkSelectNpcOnAccepted(taskStep, npcId)

	if tgt then
		if tgt:getChatNpcId() == npcId then
			self:_preHandlerCompeleteTaskTarget(taskStep, tgt)

			return true
		elseif tgt:getCollectNpcId() == npcId then
			self:_openCollectView(tgt)

			return true
		elseif tgt:getBattleNpcId() == npcId and tgt:getTargetType() == TaskConst.TSTEP_TARGET_PVE and (tgt.target.directStart or tgt.target.battleNpcOpenUI) then
			self:_startPveTarget(tgt)

			return true
		end
	end
end

function TaskController:_checkSelectNpcOnCompeleted(taskStep, npcId)
	if taskStep:getCommitNpcId() == npcId then
		return true
	end
end

function TaskController:_handleSelectNpcOnCompeleted(taskStep, npcId)
	if self:_checkSelectNpcOnCompeleted(taskStep, npcId) then
		self:requestCompeleteTask(taskStep)

		return true
	end
end

function TaskController:_onAnimPlayStart()
	return
end

function TaskController:_onAnimPlayFinish()
	if self._performeding and self._performeding.method == TaskConst.PM_ANIMATION then
		self:_onPerformingFinish()
	end
end

function TaskController:_onVideoPlayFinish()
	if self._performeding and self._performeding.method == TaskConst.PM_VIDEO then
		self:_onPerformingFinish()
	end
end

function TaskController:_onStoryStarted(storyId)
	return
end

function TaskController:_handleStoryStart(storyId)
	if self._performeding and self._performeding.method == TaskConst.PM_STORY and self._performeding.storyId == storyId and self._performeding.performedType == TaskConst.PERFORMED_CHATNPC then
		local taskStep = self._performeding.taskStep

		if taskStep.targets then
			local tgtCount = #taskStep.targets

			for k = 1, tgtCount do
				local tgt = taskStep.targets[k]

				if not tgt:isCompeleted() and tgt:getChatNpcId() == npcId and tgt:getChatStoryId() == storyId then
					tgt:prepareCompeleteOnce()
					self:notify(GlobalNotify.TaskDataUpdate, taskStep:getTaskId())
				end
			end
		end
	end
end

function TaskController:_onStoryEnded(storyId)
	if self._performeding and self._performeding.method == TaskConst.PM_STORY and self._performeding.storyId == storyId then
		self:_onPerformingFinish()
	end
end

function TaskController:onSelectMonster(mstInsId)
	local mstUnit = self._currCityScene.unitFactory:getUnit(UnitTag.Monster, mstInsId)
	local taskes = TaskModel.instance:getTaskesRelateToMonster(mstUnit.monsterId)
	local autoTask = self:_getAutoActionTask(taskes)

	self._autoActionTaskId = nil

	if autoTask and self:_handleTaskOnSelectMonster(autoTask, mstUnit.monsterId) then
		return true
	end

	local cnt = #taskes

	for i = 1, cnt do
		if self:_handleTaskOnSelectMonster(taskes[i], mstUnit.monsterId) then
			return true
		end
	end
end

function TaskController:_handleTaskOnSelectMonster(taskStep, monsterId)
	local state = taskStep:getState()

	if state == TaskConst.TSTEP_S_ACCEPTED then
		BattleFacade.instance:selectSceneMonster(monsterId)

		return true
	end
end

function TaskController:_hidePlayersOnSceneLoaded()
	if not self:_isSceneValid() then
		return
	end

	self._currCityScene:showOthersPlayers(true)
	self:_hidePlayersOnSceneLoadedByTaskes(TaskModel.instance:getTaskes())
	self:_hidePlayersOnSceneLoadedByTaskes(TaskModel.instance:getAllUnavailableTaskes())
end

function TaskController:_hidePlayersOnSceneLoadedByTaskes(taskes)
	if taskes then
		for k, v in pairs(taskes) do
			self:_hidePlayersOnTaskAccepted(v.currStep)
		end
	end
end

function TaskController:_hidePlayersOnTaskAccepted(taskStep)
	if not self:_isSceneValid() then
		return
	end

	local isHided = taskStep:isHideOthersPlayers()

	if isHided then
		local sceneIds = taskStep:hidePlayerSceneIds()

		if not sceneIds or #sceneIds == 0 then
			self._currCityScene:showOthersPlayers(false)
		else
			local sceneId = self._currCityScene:getSceneId()

			for i = 1, #sceneIds do
				if sceneIds[i] == sceneId then
					self._currCityScene:showOthersPlayers(false)

					break
				end
			end
		end
	end
end

function TaskController:_showPlayersRelateToTaskStep(taskStep)
	if not self:_isSceneValid() then
		return
	end

	if self._performeding and self._performeding.method == TaskConst.PM_STORY and self._performeding.taskStep == taskStep then
		return
	end

	local isHided = taskStep:isHideOthersPlayers()

	if isHided then
		local taskes = TaskModel.instance:getTaskesRelateToHidePlayers()
		local isAllFinish = true

		if taskes then
			local tCount = #taskes

			for k = 1, tCount do
				if taskes[k]:getState() ~= TaskConst.TSTEP_S_FINISHED then
					isAllFinish = nil

					break
				end
			end
		end

		if isAllFinish then
			self._currCityScene:showOthersPlayers(true)
		end
	end
end

function TaskController:gotoNpc(npcId)
	if self._runningAction then
		self._runningAction:stopAction()

		self._runningAction = nil
	end

	self._escortCallBack = nil
	self._runningPveBattle = nil

	if MountModel.instance:isTeamMountMember() then
		FloatWordMgr.instance:show("双人骑乘不能自动寻路")

		return
	end

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer and not mainPlayer:isFrozenMove() then
		self._runningAction = TActionFactory.createTAction(TaskConst.GOTONPC, nil, npcId)
	end
end

function TaskController:gotoChallenge(challengeId)
	if self._runningAction then
		self._runningAction:stopAction()

		self._runningAction = nil
	end

	self._runningPveBattle = nil
	self._escortCallBack = nil

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer and not mainPlayer:isFrozenMove() then
		local npcId = UnlockFacade.instance:getChallengeNpc(challengeId)

		self._runningAction = TActionFactory.createTAction(TaskConst.GOTONPC, nil, npcId)
	end
end

function TaskController:gotoMonster(monsterId)
	if self._runningAction then
		self._runningAction:stopAction()

		self._runningAction = nil
	end

	self._runningPveBattle = nil
	self._escortCallBack = nil

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer and not mainPlayer:isFrozenMove() then
		self._runningAction = TActionFactory.createTAction(TaskConst.GOTOMONSTER, nil, monsterId)
	end
end

function TaskController:_onViewOpenStart(view)
	if ViewMgr.instance:isNotifyView(view.viewName) then
		return
	end

	self:_checkPauseOnViewChange()
end

function TaskController:_onViewClosed(view)
	if ViewMgr.instance:isNotifyView(view.viewName) then
		return
	end

	self:_checkPauseOnViewChange()
end

function TaskController:_checkPauseOnViewChange()
	local topView = GlobalModel.instance:getTopView()

	if not topView or not topView:attachToWhichRoot() then
		return
	end

	if topView.viewName == ViewName.FlowerAnimaView or topView.viewName == ViewName.WebofficialpaymainView or topView.viewName == UIStateManager.instance:getRoot() then
		self._innerPause = nil

		if self._escortCallBack then
			self._escortCallBack()

			self._escortCallBack = nil
		end

		if not self._isPause then
			self:_doResume()
		end
	else
		if EscortModel.instance:IsPickupEscort() then
			return
		end

		self._innerPause = true

		self:_doPause()
	end
end

function TaskController:checkPauseOnEscort(callBack)
	if not EscortModel.instance:IsPickupEscort() then
		return false
	end

	local topView = GlobalModel.instance:getTopView()

	if not topView or not topView:attachToWhichRoot() then
		return false
	end

	if topView.viewName == ViewName.MainUI then
		return false
	end

	self._innerPause = true

	self:_doPause()

	self._escortCallBack = callBack

	return true
end

function TaskController:_onMainPlayerPosChange(x, z, isTeleport, underBridge)
	if self._runningAction and not self._runningAction:isFinished() then
		self._runningAutoPath = true

		GlobalDispatcher:dispatch(GlobalNotify.StartAutoPath)
	end
end

function TaskController:_resetDailyTaskes()
	local taskes = TaskModel.instance:getCurrentTriggerTaskesByType(GameEnum.TaskType.Daily)

	if not taskes then
		return
	end

	for i = 1, #taskes do
		taskes[i].task.sendAcceptTask = nil
		taskes[i].hasSentFinishProto = nil

		for j = 1, #taskes[i].targets do
			taskes[i].targets[j]:setProgress(0)

			taskes[i].targets[j].sendCompeleted = nil

			GlobalDispatcher:dispatch(GlobalNotify.TaskDataUpdate, taskes[i]:getTaskId())
		end
	end
end

TaskController.instance = TaskController.New()

return TaskController
