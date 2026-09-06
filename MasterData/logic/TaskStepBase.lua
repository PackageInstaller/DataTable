-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/step/TaskStepBase.lua

module("logic.extensions.task.model.task.TaskStepBase", package.seeall)

local TaskStepBase = class("TaskStepBase")

function TaskStepBase:ctor(stepCo, task)
	self.stepCo = stepCo
	self.task = task
	self._stepStat = TaskConst.TSTEP_S_UNAVAILABLE
	self.acceptedPerformed = TaskConst.getPerformed(TaskConst.PERFORMED_ACCEPTED, self.stepCo.acceptPerformed)
	self.finishedPerformed = TaskConst.getPerformed(TaskConst.PERFORMED_FINISHED, self.stepCo.compeletePerformed)

	if self.acceptedPerformed then
		self.acceptedPerformed.taskStep = self
	end

	if self.finishedPerformed then
		self.finishedPerformed.taskStep = self
	end

	self:_buildTargets()
end

function TaskStepBase:setState(state)
	self._stepStat = state
end

function TaskStepBase:getState()
	return self._stepStat
end

function TaskStepBase:shouldTrigger()
	return true
end

function TaskStepBase:forbidAutoCommit()
	return self.stepCo.forbidAutoCommit
end

function TaskStepBase:forbidAutoTask()
	return self.stepCo.forbidAutoTask
end

function TaskStepBase:orderingTargets()
	return self.stepCo.ordering
end

function TaskStepBase:showTaskCompelete()
	return not self.stepCo.noshowTaskCompolete
end

function TaskStepBase:isCompeleted()
	if self.targets then
		local count = #self.targets

		for i = 1, count do
			if not self.targets[i]:isCompeleted() then
				return nil
			end
		end
	end

	return true
end

function TaskStepBase:isPrepareCompeleted()
	if self.targets then
		local count = #self.targets

		for i = 1, count do
			if not self.targets[i]:isPrepareCompeleted() then
				return nil
			end
		end
	end

	return true
end

function TaskStepBase:getTargetNum()
	if self.targets then
		return #self.targets
	end

	return 0
end

function TaskStepBase:getCompeleteTargetNum()
	if self.targets then
		local cnt = #self.targets
		local num = 0

		for i = 1, cnt do
			if self.targets[i]:isCompeleted() then
				num = num + 1
			end
		end

		return num
	end

	return 0
end

function TaskStepBase:isTargetRunnableByIndex(idx)
	if self:orderingTargets() and self.targets then
		for i = 1, idx - 1 do
			if self.targets[i] and not self.targets[i]:isCompeleted() then
				return
			end
		end
	end

	return true
end

function TaskStepBase:isTargetRunnable(target)
	return self:isTargetRunnableByIndex(target.index + 1)
end

function TaskStepBase:getTarget(idx)
	if self.targets then
		local cnt = #self.targets

		for i = 1, cnt do
			if self.targets[i].index == idx then
				return self.targets[i]
			end
		end
	end
end

function TaskStepBase:getTargetByType(tgtType)
	if self.targets then
		local cnt = #self.targets

		for i = 1, cnt do
			if self.targets[i]:getTargetType() == tgtType then
				return self.targets[i]
			end
		end
	end
end

function TaskStepBase:getTargetsExtraData()
	if self.targets then
		local cnt = #self.targets
		local extraData = {}

		for i = 1, cnt do
			extraData[i] = self.targets[i]:getTargetsExtraData()
		end

		return extraData
	end
end

function TaskStepBase:getStepName()
	return self.stepCo.stepName
end

function TaskStepBase:getStepDesc()
	return self.stepCo.stepDesc
end

function TaskStepBase:getTaskId()
	return self.stepCo.taskId
end

function TaskStepBase:getStepId()
	return self.stepCo.stepId
end

function TaskStepBase:getTaskBonus()
	return self.task:getBonus()
end

function TaskStepBase:hasStepBonus()
	local bonus, bonusType = TaskConfig.instance:getTaskeStepBonus(self:getTaskId(), self:getStepId())

	return bonusType and bonus and #bonus > 0
end

function TaskStepBase:getStepBonus(showLast)
	if not showLast and not self:_isBonusValid() then
		return
	end

	return TaskConfig.instance:getTaskeStepBonus(self:getTaskId(), self:getStepId())
end

function TaskStepBase:_isBonusValid()
	local isLast = self.task:lastStepId() == self:getStepId()

	if isLast and (not self.task.taskCo.taskReward or #self.task.taskCo.taskReward == 0) then
		return
	end

	return true
end

function TaskStepBase:getNextStepId()
	if not self.stepCo.isEndStep and self.stepCo.nextStep and self.stepCo.nextStep ~= 0 then
		return self.stepCo.nextStep
	end
end

function TaskStepBase:getAcceptNpcId()
	if self.task:firstStepId() == self.stepCo.stepId then
		return self.task.taskCo.receiveNpcId
	end

	return 0
end

function TaskStepBase:getPerformedNpcIds()
	return self.stepCo.stepNpcs
end

function TaskStepBase:getCommitNpcId()
	return self.stepCo.commitNpcId
end

function TaskStepBase:getAllRelateToNpcIds(isRemove)
	local npcIds, npcIdsMap = self:_addRelateToNpcId(self:getAcceptNpcId())

	npcIds, npcIdsMap = self:_addRelateToNpcId(self:getCommitNpcId(), npcIds, npcIdsMap)

	if self.targets then
		local count = #self.targets

		for i = 1, count do
			local tgt = self.targets[i]

			npcIds, npcIdsMap = self:_addRelateToNpcId(tgt:getBattleNpcId(isRemove), npcIds, npcIdsMap)
			npcIds, npcIdsMap = self:_addRelateToNpcId(tgt:getChatNpcId(), npcIds, npcIdsMap)
			npcIds, npcIdsMap = self:_addRelateToNpcId(tgt:getCollectNpcId(), npcIds, npcIdsMap)

			local cIds = tgt:getChallengesNpcId()

			if cIds then
				local cCount = #cIds

				for j = 1, cCount do
					npcIds, npcIdsMap = self:_addRelateToNpcId(cIds[j], npcIds, npcIdsMap)
				end
			end

			local fIds = tgt:getFollowNpcIds()

			if fIds then
				local cCount = #fIds

				for j = 1, cCount do
					npcIds, npcIdsMap = self:_addRelateToNpcId(fIds[j], npcIds, npcIdsMap)
				end
			end
		end
	end

	if self.stepCo.stepNpcs then
		local count = #self.stepCo.stepNpcs

		for i = 1, count do
			npcIds, npcIdsMap = self:_addRelateToNpcId(self.stepCo.stepNpcs[i], npcIds, npcIdsMap)
		end
	end

	return npcIds
end

function TaskStepBase:_addRelateToNpcId(npcId, npcIds, npcIdsMap)
	if npcId and npcId ~= 0 then
		npcIdsMap = npcIdsMap or {}

		if not npcIdsMap[npcId] then
			npcIdsMap[npcId] = true
			npcIds = npcIds or {}
			npcIds[#npcIds + 1] = npcId
		end
	end

	return npcIds, npcIdsMap
end

function TaskStepBase:isRelateToNpc(npcId)
	if self:getAcceptNpcId() == npcId or self:getCommitNpcId() == npcId then
		return true
	end

	if self.targets ~= nil then
		local count = #self.targets

		for i = 1, count do
			local tgt = self.targets[i]

			if tgt:getBattleNpcId() == npcId or tgt:getChatNpcId() == npcId or tgt:getCollectNpcId() == npcId then
				return true
			end

			local cIds = tgt:getChallengesNpcId()

			if cIds then
				local cCount = #cIds

				for j = 1, cCount do
					if cIds[j] == npcId then
						return true
					end
				end
			end

			local fIds = tgt:getFollowNpcIds()

			if fIds then
				local cCount = #fIds

				for j = 1, cCount do
					if fIds[j] == npcId then
						return true
					end
				end
			end
		end
	end

	if self.stepCo.stepNpcs then
		local count = #self.stepCo.stepNpcs

		for i = 1, count do
			if self.stepCo.stepNpcs[i] == npcId then
				return true
			end
		end
	end
end

function TaskStepBase:isRelateToMonster(mstId)
	if self.targets ~= nil then
		local count = #self.targets

		for i = 1, count do
			local tgt = self.targets[i]

			if tgt:getBattleMonsterId() == mstId then
				return true
			end
		end
	end
end

function TaskStepBase:isTriggerUsing(sceneId, triggerId)
	if self.targets ~= nil then
		local count = #self.targets

		for i = 1, count do
			if not self.targets[i]:isCompeleted() and self:isTargetRunnable(self.targets[i]) then
				local tSceneId = self.targets[i]:getSceneId()
				local tTriggerId = self.targets[i]:getTriggerId()

				if tSceneId and tTriggerId and tSceneId == sceneId and tTriggerId == triggerId then
					return true
				end
			end
		end
	end
end

function TaskStepBase:getMonsters()
	if self.targets ~= nil then
		local count = #self.targets
		local msts

		for i = 1, count do
			local tgt = self.targets[i]
			local mstId = tgt:getBattleMonsterId() or 0

			if mstId ~= 0 then
				msts = msts or {}

				table.insert(msts, mstId)
			end
		end

		return msts
	end
end

function TaskStepBase:isRelateToScene(sceneId)
	if self.targets ~= nil then
		local count = #self.targets

		for i = 1, count do
			local tgt = self.targets[i]

			if tgt:getSceneId() == sceneId then
				return true
			end
		end
	end
end

function TaskStepBase:isRelateToItemId(itemId)
	if self.targets ~= nil then
		local count = #self.targets

		for i = 1, count do
			local tgt = self.targets[i]

			if tgt:getItemId() == itemId then
				return true
			end
		end
	end
end

function TaskStepBase:isRelateToCopyId(copyId, stageId)
	if self.targets ~= nil then
		local count = #self.targets

		for i = 1, count do
			local tgt = self.targets[i]

			if not tgt:isCompeleted() and tgt.target and tgt.target.copyId == copyId and tgt.target.levelId == stageId then
				return true
			end
		end
	end
end

function TaskStepBase:isRelateToSCCopyId(activityId, typeId, chapterId)
	if self.targets ~= nil then
		local count = #self.targets

		for i = 1, count do
			local tgt = self.targets[i]

			if not tgt:isCompeleted() and tgt.target and tgt.target.activityId == activityId and tgt.target.typeId == typeId and tgt.target.chapterId == chapterId then
				return true
			end
		end
	end
end

function TaskStepBase:isHideOthersPlayers()
	return self.stepCo.hidePlayers
end

function TaskStepBase:hidePlayerSceneIds()
	return self.stepCo.hidePlayerSceneIds
end

function TaskStepBase:isRelateToPve(pveId)
	if self.targets ~= nil then
		local count = #self.targets

		for i = 1, count do
			local tgt = self.targets[i]

			if tgt:getPveId() == pveId then
				return true
			end
		end
	end
end

function TaskStepBase:isRelateToChallenge(challengeId)
	if self.targets ~= nil then
		local count = #self.targets

		for i = 1, count do
			local tgt = self.targets[i]
			local cId, pId, bId = tgt:getChallengeId()

			if cId and pId and bId and BattleFacade.instance:getChallengeTeamIdById(cId, pId, bId) == challengeId then
				return true
			end
		end
	end
end

function TaskStepBase:jumpCompeleteUI()
	if self.targets then
		local count = #self.targets

		for i = 1, count do
			local tgt = self.targets[i]

			if tgt:getTargetType() == TaskConst.TSTEP_TARGET_PVE and tgt.target.battleNpc and tgt.target.needCompInUI then
				local innerET = self:getTargetByType(TaskConst.TSTEP_TARGET_INNEREVOLVE)

				if not innerET or innerET.index < tgt.index then
					local pveId = tgt:getPveId()
					local pveCo = WuShenConfig.instance:getMasterCoById(pveId)

					if pveCo.hasUI then
						UIStateManager.instance:push("wuShenShouView", pveId)

						return true
					end
				end
			end
		end
	end
end

function TaskStepBase:_buildTargets()
	if self.stepCo.target and #self.stepCo.target > 0 then
		self.targets = {}

		local count = #self.stepCo.target

		for i = 1, count do
			local target = TaskConst.getTaskStepTarget(self.stepCo.target[i], self)

			target.instruction = self.stepCo.instruction[i]

			local stepTarget = TaskTargetFactory.createTaskTarget(self, target)

			stepTarget.index = i - 1
			self.targets[#self.targets + 1] = stepTarget
		end
	end
end

return TaskStepBase
