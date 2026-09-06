-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/facade/TaskFacade.lua

module("logic.extensions.task.facade.TaskFacade", package.seeall)

local TaskFacade = class("TaskFacade", BaseFacade)

function TaskFacade:loadUserTasks()
	TaskAgent.instance:sendLoadUserTasksReq()
end

function TaskFacade:isTesting()
	return TaskModel.instance.isTesting
end

function TaskFacade:sendTaskFightMonsterReq(fightMasterId, withOutFmtCheck)
	if not withOutFmtCheck and FormationFacade.instance:checkFormationEmpty() then
		TaskController.instance:clearHandlingTaskes()

		return
	end

	local function start_fight_mst()
		TaskAgent.instance:sendTaskFightMonsterReq(fightMasterId)
	end

	if not withOutFmtCheck then
		if not FormationFacade.instance:checkFormationPosNumber(start_fight_mst) then
			start_fight_mst()
		else
			TaskController.instance:clearHandlingTaskes()
		end
	else
		start_fight_mst()
	end
end

function TaskFacade:parseTaskBonus(bonusCfg, bonusType)
	if not bonusCfg then
		return
	end

	local rwdStr = string.gsub(bonusCfg, ",", ":")
	local bonus

	if bonusType == 7 then
		local items = string.split(rwdStr, "#")
		local level = checknumber(items[1])

		bonus = bonus or {}

		table.insert(bonus, MatType.Pet .. ":10057:" .. level)
		table.insert(bonus, MatType.Pet .. ":10058:" .. level)
		table.insert(bonus, MatType.Pet .. ":10059:" .. level)
		table.insert(bonus, MatType.Pet .. ":10060:" .. level)
	else
		local items = string.split(rwdStr, "#")

		for i = 1, #items do
			bonus = bonus or {}

			table.insert(bonus, items[i])
		end
	end

	return bonus
end

function TaskFacade:isExistintBonuedTask(taskType)
	local taskes = not taskType and self:getCurrentTriggerTaskesShowedOnUI() or TaskModel.instance:getCurrentTriggerTaskesByType(taskType)

	if taskes then
		for i = 1, #taskes do
			if not taskes[i].hasSentFinishProto and taskes[i]:forbidAutoCommit() and taskes[i]:isCompeleted() and taskes[i]:hasStepBonus() then
				return true
			end
		end
	end
end

function TaskFacade:getCurrentTriggerTaskesShowedOnUI()
	return TaskModel.instance:getCurrentTriggerTaskShowedOnUI()
end

function TaskFacade:startAutoAction(taskId)
	TaskController.instance:startAutoActionByTaskId(taskId)
end

function TaskFacade:isTaskStepFinished(taskId, stepId)
	local isFinished = TaskModel.instance:isTaskFinished(taskId)

	if isFinished or not stepId or stepId == 0 then
		return isFinished
	end

	return TaskModel.instance:isTaskStepFinished(taskId, stepId)
end

function TaskFacade:isTaskFinished(taskId)
	return TaskModel.instance:isTaskFinished(taskId)
end

function TaskFacade:isTaskStepCompeleted(taskId, stepId)
	return TaskModel.instance:isTaskStepComelete(taskId, stepId)
end

function TaskFacade:isTaskCompelete(taskId)
	if self:isTaskFinished(taskId) then
		return true
	end

	local lastId = TaskConfig.instance:getStepEnd(taskId)

	return self:isTaskStepCompeleted(taskId, lastId)
end

function TaskFacade:getTaskCurStepId(taskId)
	local _currStep = TaskModel.instance:getCurrStepOfTask(taskId)

	if _currStep then
		return _currStep:getStepId()
	end

	return nil
end

function TaskFacade:isTaskRunning(taskId, stepId)
	return TaskModel.instance:isTaskStepDoing(taskId, stepId)
end

function TaskFacade:getPveTaskIdByPveId(pveId)
	local taskId, stepId = TaskConfig.instance:getWuShenShouTaskId(pveId)

	return taskId, stepId
end

function TaskFacade:isPveTaskCompelete(pveId)
	local taskId, stepId = TaskConfig.instance:getWuShenShouTaskId(pveId)

	if taskId and stepId then
		return TaskModel.instance:isTaskStepTargetComelete(taskId, stepId, TaskConst.TSTEP_TARGET_PVE)
	end
end

function TaskFacade:isPveTaskFinished(pveId)
	local taskId, stepId = TaskConfig.instance:getWuShenShouTaskId(pveId)

	if taskId and stepId then
		if TaskModel.instance:isTaskStepFinished(taskId, stepId) then
			return true
		end

		local task = TaskModel.instance:getTaskById(taskId)

		if not task or not task.currStep then
			return false
		end

		if stepId == task.currStep:getStepId() then
			local target = task.currStep:getTargetByType(TaskConst.TSTEP_TARGET_PVE)

			if not target then
				return true
			end

			if not target:isCompeleted() then
				return false
			end

			local pveId = target:getPveId()
			local pveCo = WuShenConfig.instance:getMasterCoById(pveId)

			if target.target.needCompInUI and pveCo.hasUI then
				return false
			end

			if TaskModel.instance:isPveNeedEvolve(target:getPveId()) then
				local targetEvolve = task.currStep:getTargetByType(TaskConst.TSTEP_TARGET_INNEREVOLVE)

				if not targetEvolve then
					return false
				end

				if targetEvolve:isCompeleted() then
					return true
				end

				return false
			end

			return true
		end
	end
end

function TaskFacade:isPveTaskAccepted(pveId)
	local taskId, stepId = TaskConfig.instance:getWuShenShouTaskId(pveId)

	if taskId and stepId then
		return TaskModel.instance:isTaskStepAccpeted(taskId, stepId)
	end
end

function TaskFacade:requestEvEBattle(eveA, eveB)
	if eveA == 0 and eveB == 0 then
		return
	end

	if eveA ~= 0 and eveB ~= 0 then
		TaskAgent.instance:sendTaskEVEMonsterFightReq(eveA, eveB)
	elseif eveA ~= 0 then
		self:sendTaskFightMonsterReq(eveA)
	else
		self:sendTaskFightMonsterReq(eveB)
	end
end

function TaskFacade:getAllTaskTargets(taskId)
	local allSteps = TaskConfig.instance:getAllTaskStepCoes(taskId)
	local cnt = #allSteps
	local isSelfFinished = TaskModel.instance:isTaskFinished(taskId)
	local isSelfAccepted = TaskModel.instance:isTaskAccpeted(taskId)
	local isAcceptable = TaskModel.instance:shouldTaskTriggerByTaskId(taskId)
	local taskIns = TaskFactory.createTask(taskId)
	local taskSteps = {}

	for i = 1, cnt do
		local stepCO = allSteps[i]
		local stepIns = TaskStepFactory.createTaskStep(stepCO.stepId, taskIns)

		table.insert(taskSteps, stepIns)
	end

	local targets = {}

	for i = 1, cnt do
		local tCnt = #taskSteps[i].targets

		for k = 1, tCnt do
			local tgt = taskSteps[i].targets[k]

			table.insert(targets, tgt)

			tgt.valid = true

			if isSelfFinished then
				tgt:compelete()
			else
				local taskStep

				if isSelfAccepted then
					taskStep = TaskModel.instance:getCurrStepOfTask(taskId)
				elseif isAcceptable then
					local task = TaskModel.instance:getUnavailableTaskes(taskId)

					if task then
						taskStep = task.currStep
					end

					taskStep = taskStep or TaskModel.instance:getCurrStepOfTask(taskId)
				end

				if taskStep then
					local currStepId = taskStep:getStepId()
					local stepId = taskSteps[i]:getStepId()

					if stepId < currStepId then
						tgt:compelete()
					elseif stepId == currStepId then
						local tgt1 = taskStep.targets[k]

						if tgt1:isCompeleted() then
							tgt:compelete()
						else
							tgt:setProgress(tgt1:getProgress())
						end
					elseif currStepId < stepId then
						tgt.valid = nil
					end
				end
			end
		end
	end

	table.sort(targets, function(first, second)
		if first == second then
			return
		end

		local firstStepId = first.taskStep:getStepId()
		local secondStepId = second.taskStep:getStepId()

		if firstStepId < secondStepId then
			return
		end

		if secondStepId < firstStepId then
			return true
		end

		if first:isCompeleted() and not second:isCompeleted() then
			return
		end

		if not first:isCompeleted() and second:isCompeleted() then
			return true
		end
	end)

	return targets
end

function TaskFacade:getBattleStoryConfig(eveA, eveB, pveId, challengeId)
	local performing = TaskController.instance:getPerformed()

	if performing and performing.method == TaskConst.PM_PETBATTLE and (eveA == performing.eveBattleIdA and eveB == performing.eveBattleIdB or eveB == performing.eveBattleIdA and eveA == performing.eveBattleIdB) and performing.battleStoryId then
		return {
			storyId = performing.battleStoryId,
			mode = performing.battleStoryMode,
			petId = performing.battleStoryPet,
			round = performing.battleStoryRound
		}
	end

	if pveId then
		local taskes = TaskModel.instance:getTaskesRelateToPve(pveId)

		if taskes then
			for i = 1, #taskes do
				local targets = taskes[i].targets

				if targets then
					local count = #targets

					for i = 1, count do
						local tgt = targets[i]

						if tgt:getPveId() == pveId and tgt:getBattleStoryId() then
							return {
								storyId = tgt:getBattleStoryId(),
								mode = tgt:getBattleStoryMode(),
								petId = tgt:getBattleStoryPet(),
								round = tgt:getBattleStoryRound()
							}
						end
					end
				end
			end
		end
	end

	if challengeId then
		local taskes = TaskModel.instance:getTaskesRelateToChallengeId(challengeId)

		if taskes then
			for i = 1, #taskes do
				local targets = taskes[i].targets

				if targets then
					local count = #targets

					for i = 1, count do
						local tgt = targets[i]
						local cId, pId, bId = tgt:getChallengeId()

						if cId and pId and bId and BattleFacade.instance:getChallengeTeamIdById(cId, pId, bId) == challengeId and tgt:getBattleStoryId() then
							return {
								storyId = tgt:getBattleStoryId(),
								mode = tgt:getBattleStoryMode(),
								petId = tgt:getBattleStoryPet(),
								round = tgt:getBattleStoryRound()
							}
						end
					end
				end
			end
		end
	end
end

function TaskFacade:getTaskShowName(taskId)
	local taskCo = TaskConfig.instance:getTaskCo(taskId)
	local chapterId = checknumber(taskCo.chapterId)
	local chapterOrder = checknumber(taskCo.chapterOrder)

	if chapterId > 0 then
		if chapterId == 1 then
			return string.format("序章 %s", taskCo.name)
		else
			return string.format("第%d章 %s", chapterId - 1, taskCo.name)
		end
	else
		return taskCo.name
	end
end

function TaskFacade:getCurrMainChapterId()
	local mainTaskes = TaskModel.instance:getCurrentTriggerTaskesByType(GameEnum.TaskType.Main)

	if not mainTaskes or #mainTaskes == 0 then
		return TaskConfig.maxChapterId
	end

	local taskCo = TaskConfig.instance:getTaskCo(mainTaskes[1]:getTaskId())

	return checknumber(taskCo.chapterId)
end

TaskFacade.instance = TaskFacade.New()

return TaskFacade
