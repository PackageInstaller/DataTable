-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/task/TaskBase.lua

module("logic.extensions.task.model.branch.TaskBase", package.seeall)

local TaskBase = class("TaskBase")

function TaskBase:ctor(taskCo)
	self.taskCo = taskCo
	self.trigger = TaskConst.getTaskTrigger(self)
	self.triggerdPerformed = TaskConst.getPerformed(TaskConst.PERFORMED_TRIGERED, self.taskCo.triggerPerformed)

	if self.triggerdPerformed then
		self.triggerdPerformed.task = self
	end

	self.currStep = nil
	self._finishTimes = nil
	self._acceptTime = nil
	self._finishTime = nil
	self.acceptedAvailable = nil

	self:_calOpenTime()
end

function TaskBase:_calOpenTime()
	if not string.nilorempty(self.taskCo.dateStart) then
		self.taskOpenTimeStamp = GameUtil.string2time(self.taskCo.dateStart)
	end

	if not string.nilorempty(self.taskCo.dateEnd) then
		self.taskCloseTimeStamp = GameUtil.string2time(self.taskCo.dateEnd)
	end
end

function TaskBase:isInPeriod()
	if not self.taskOpenTimeStamp then
		local taskOpenTimeStamp = 0

		if not self.taskCloseTimeStamp then
			local taskCloseTimeStamp = 0

			if taskOpenTimeStamp == 0 and taskCloseTimeStamp == 0 then
				return true
			end

			local now = ServerTime.now()
			local isStarted = taskOpenTimeStamp == 0 or taskOpenTimeStamp <= now
			local isEnded = taskCloseTimeStamp ~= 0 and taskCloseTimeStamp <= now

			return isStarted and not isEnded
		end
	end
end

function TaskBase:isAutoAccpet()
	return self.taskCo.autoOpen
end

function TaskBase:isTriggered()
	if self.taskCo.taskStarterState ~= TaskConst.TASK_S_ONLINE then
		return
	end

	if not ColorfulEggsController.instance:checkTaskTriggered(self:getTaskId()) then
		return false
	end

	if not self:isInPeriod() then
		return false
	end

	if not self:isTimeOpen() then
		return false
	end

	if not self.trigger then
		return true
	end

	if self.acceptedAvailable then
		return true
	end

	if self.trigger.trigger == TaskConst.TSTEP_TG_GETITEM then
		return MaterialFacade.instance:getMatNumber(MatType.Item, self.trigger.itemId) > 0
	elseif self.trigger.trigger == TaskConst.TSTEP_TG_MOFANG then
		return MofangModel.instance:getCurLv() >= self.trigger.mofangLevel
	elseif self.trigger.trigger == TaskConst.TSTEP_TG_MAXFP then
		return RoleModel.instance:getMaxPower() >= self.trigger.maxFightingPower
	elseif self.trigger.trigger == TaskConst.TSTEP_TG_CHALLENGE then
		return nil
	elseif self.trigger.trigger == TaskConst.TSTEP_TG_ENTERSCENE then
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene:getSceneId() == self.trigger.sceneId then
			return true
		end
	end
end

function TaskBase:isTimeOpen()
	if self.taskCo.taskStarterState ~= TaskConst.TASK_S_ONLINE then
		return false
	end

	if not self:isInPeriod() then
		return false
	end

	if self.isTimeOk then
		return true
	end

	if self.taskCo.openHours > 0 then
		return self:timeToOpen() <= 0
	end

	return true
end

function TaskBase:timeToOpen()
	if self.isTimeOk then
		return 0
	end

	if self.taskCo.openHours > 0 then
		local startTime
		local activeTime = checknumber(RoleModel.instance:getActiveTime()) / 1000

		if self.taskCo.useAbsTime then
			startTime = activeTime
		else
			local now = ServerTime.nowDateServerLook()
			local refreshTime = ClockMgr.instance._refreshTime
			local dateTime = os.time({
				min = 0,
				sec = 0,
				year = now.year,
				month = now.month,
				day = now.day,
				hour = refreshTime
			})

			if dateTime <= activeTime then
				startTime = dateTime
			else
				return 0
			end
		end

		local nowTime = checknumber(ServerTime.now())
		local deltaTime = self.taskCo.openHours * 3600

		if nowTime < startTime then
			return math.huge
		end

		if deltaTime < nowTime - startTime then
			return 0
		end

		return deltaTime - (nowTime - startTime)
	end

	return 0
end

function TaskBase:isTaskNeedShowedOnUIWhileNoTrigger()
	if self.taskCo.taskStarterState ~= TaskConst.TASK_S_ONLINE then
		return
	end

	if not ColorfulEggsController.instance:checkTaskTriggered(self:getTaskId()) then
		return
	end

	if not self:isInPeriod() then
		return false
	end

	if not self.trigger and self:openHours() == 0 then
		return
	end

	if self.acceptedAvailable then
		return true
	end

	if not TaskModel.instance:isPreTaskesFinished(self.taskCo) then
		return
	end

	if self.trigger then
		return self.trigger.showOnUI
	else
		return self:openHours() <= 0
	end
end

function TaskBase:showUnAvailableTips()
	local tips = self:getUnAvailableTips(true)

	if not string.nilorempty(tips) then
		TipsFacade.instance:openCommonTips(tips)
	end
end

function TaskBase:getUnAvailableTips(isTip)
	local tips = ""

	if self.taskCo.taskStarterState ~= TaskConst.TASK_S_ONLINE then
		return tips
	end

	if not TaskModel.instance:isPreTaskesFinished(self.taskCo) then
		local taskes = TaskModel.instance:getUnFinishedPreTaskes(self.taskCo)

		if taskes then
			local cnt = #taskes

			if cnt > 0 then
				local tips = {}

				for i = 1, cnt do
					local taskCo = TaskConfig.instance:getTaskCo(taskes[i])
					local color = ConstString.TaskColor[taskCo.taskStarterType]
					local typeName = ConstString.Task[taskCo.taskStarterType]
					local taskName = string.format("<color=#%s>[%s]</color> %s", color, typeName, taskCo.name)

					table.insert(tips, taskName)

					if i ~= cnt then
						table.insert(tips, "  ")
					end
				end

				local tipsStr = table.concat(tips)

				tips = string.format(lang("ui_pretask_tips"), tipsStr)

				return tips
			end
		end

		return tips
	end

	if not self:isTimeOpen() then
		local remain = self:timeToOpen()

		if remain < 3600 then
			local mins = math.ceil(remain / 60)

			tips = string.format(lang("task_opentime_mins"), mins)
		elseif remain < 86400 then
			local hours = math.ceil(remain / 3600)

			tips = string.format(lang("task_opentime_hours"), hours)
		else
			local days = math.ceil(remain / 86400)

			tips = string.format(lang("task_opentime_day"), days)
		end

		return tips
	end

	if self.trigger and not self:isTriggered() then
		if self.trigger.trigger == TaskConst.TSTEP_TG_ENTERSCENE then
			local sceneCo = SceneConfig.instance:getSceneCo(self.trigger.sceneId)

			if sceneCo then
				tips = string.format(lang("task_trigger_scene"), sceneCo.scene_name)
			end
		elseif self.trigger.trigger == TaskConst.TSTEP_TG_SCENETRIGGER then
			local sceneCo = SceneConfig.instance:getSceneCo(self.trigger.sceneId)

			if sceneCo then
				tips = string.format(lang("task_trigger_scene_zone"), sceneCo.scene_name)
			end
		elseif self.trigger.trigger == TaskConst.TSTEP_TG_GETITEM then
			local cfg = ItemConfig.instance:getCfgById(self.trigger.itemId)

			if cfg then
				tips = string.format(lang("task_trigger_item"), cfg.name)
			end
		elseif self.trigger.trigger == TaskConst.TSTEP_TG_CHALLENGE then
			local missionCfg = ChallengeConfig.instance:getChallengeMissionCfg(self.trigger.challengeId, self.trigger.challengeParseId, self.trigger.challengeBranchId)
			local cCo = ChallengeConfig.instance:getChallengeCfg(self.trigger.challengeId)

			if cCo and missionCfg then
				tips = string.format(lang("task_trigger_challenge"), cCo.name, missionCfg.name)
			end
		elseif self.trigger.trigger == TaskConst.TSTEP_TG_MOFANG then
			local name = TaskFacade.instance:getTaskShowName(self.taskCo.taskId)
			local taskStarterType = self.taskCo.taskStarterType
			local color = ConstString.TaskColor[taskStarterType]
			local typeName = ConstString.Task[taskStarterType]

			if isTip then
				local content = string.format("<color=#%s>[%s]</color> %s", color, typeName, name)
				local level = self.trigger.mofangLevel

				TipsFacade.instance:openLockTips(level, 0, content)
			else
				tips = string.format("人物等级%s级解锁", self.trigger.mofangLevel)
			end
		elseif self.trigger.trigger == TaskConst.TSTEP_TG_MAXFP then
			local name = TaskFacade.instance:getTaskShowName(self.taskCo.taskId)

			tips = string.format("最大战斗力达到%s解锁", self.trigger.maxFightingPower)
		end

		return tips
	end
end

function TaskBase:firstStepId()
	return TaskConfig.instance:getStepStart(self:getTaskId())
end

function TaskBase:lastStepId()
	return TaskConfig.instance:getStepEnd(self:getTaskId())
end

function TaskBase:getTaskId()
	return self.taskCo.taskId
end

function TaskBase:openHours()
	return self.taskCo.openHours
end

function TaskBase:hoursUseAbsTime()
	return self.taskCo.useAbsTime
end

function TaskBase:getBonus()
	return self.taskCo.taskReward
end

function TaskBase:getTaskType()
	return self.taskCo.taskStarterType
end

function TaskBase:getTimes()
	return self._finishTimes or 0
end

function TaskBase:setTimes(time)
	self._finishTimes = times
end

function TaskBase:setAcceptTime(time)
	self._acceptTime = times
end

function TaskBase:setFinishTime(time)
	self._finishTime = times
end

function TaskBase:getTimesAvailable()
	if self.taskCo.timesLimit == 0 then
		return -1
	end

	local fTimes = self:getFinishTimes()

	if fTimes >= self.taskCo.timesLimit then
		return 0
	end

	return self.taskCo.timesLimit - fTimes
end

function TaskBase:isTimesAvailable()
	return self:getTimesAvailable() ~= 0
end

function TaskBase:isTriggerInScene(sceneId)
	if self.trigger and self.trigger.sceneId == sceneId then
		return true
	end

	return nil
end

function TaskBase:isTriggerWithMofang()
	if self.trigger and self.trigger.trigger == TaskConst.TSTEP_TG_MOFANG then
		return true
	end

	return nil
end

function TaskBase:isTriggerWithMaxFP()
	if self.trigger and self.trigger.trigger == TaskConst.TSTEP_TG_MAXFP then
		return true
	end

	return nil
end

function TaskBase:getBarrierNpcs(stepId)
	if self.taskCo.barrierNpcs then
		local cnt = #self.taskCo.barrierNpcs

		for i = 1, cnt do
			local npcs = self.taskCo.barrierNpcs[i]

			if npcs[1] == stepId then
				return npcs
			end
		end
	end
end

function TaskBase:getBarrierIds(stepId)
	if self.taskCo.barrierIds then
		local cnt = #self.taskCo.barrierIds

		for i = 1, cnt do
			local ids = self.taskCo.barrierIds[i]

			if ids[1] == stepId then
				return ids
			end
		end
	end
end

function TaskBase:getAllBarrierNpcs()
	return self.taskCo.barrierNpcs
end

function TaskBase:getAllBarrierIds()
	return self.taskCo.barrierIds
end

function TaskBase:getTriggerSceneIdAndTriggerId()
	if self.trigger then
		return self.trigger.sceneId, self.trigger.triggerId or 0
	end
end

function TaskBase:isTriggerWithItemId(itemId)
	if self.trigger and self.trigger.itemId == itemId then
		return true
	end

	return nil
end

function TaskBase:getTriggerItemId()
	if self.trigger then
		return self.trigger.itemId
	end
end

function TaskBase:isTriggerWithChallenge(itemId)
	if self.trigger and self.trigger.trigger == TaskConst.TSTEP_TG_CHALLENGE then
		return true
	end

	return nil
end

function TaskBase:getTriggerChallengeParams()
	if self.trigger then
		return self.trigger.challengeId, self.trigger.challengeParseId, self.trigger.challengeBranchId
	end
end

return TaskBase
