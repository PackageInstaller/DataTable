-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/target/TaskTargetBase.lua

module("logic.extensions.task.model.branch.TaskTargetBase", package.seeall)

local TaskTargetBase = class("TaskTargetBase")

function TaskTargetBase:ctor(taskStep, target)
	self.taskStep = taskStep
	self.target = target
	self._progress = 0
	self._toprogress = 0
end

function TaskTargetBase:getProgress()
	return self._progress
end

function TaskTargetBase:setProgress(progress)
	self._progress = progress
	self._toprogress = progress
end

function TaskTargetBase:getBattleResultPerformed()
	return
end

function TaskTargetBase:prepareCompeleteOnce()
	self._toprogress = self._progress + 1
end

function TaskTargetBase:isPrepareCompeleted()
	if self:isCompeleted() then
		return true
	end

	return self._toprogress >= self:getTargetNum()
end

function TaskTargetBase:getTargetNum()
	return 1
end

function TaskTargetBase:compelete()
	self._progress = self:getTargetNum()
end

function TaskTargetBase:isCompeleted()
	return self:getProgress() >= self:getTargetNum()
end

function TaskTargetBase:getDesc()
	return (TaskConfig.instance:getTaskInstruction(self.target.instruction))
end

function TaskTargetBase:getTargetsExtraData()
	if self:isCompeleted() then
		return "{\"f\":1}"
	else
		return "{\"c\":1}"
	end
end

function TaskTargetBase:getBattleNpcId(isRemove)
	if self.target then
		if self:getTargetType() == TaskConst.TSTEP_TARGET_CSTZ then
			if isRemove then
				return 0
			end

			local isUnlock = UnlockModel.instance:isFunctionUnlock(self.target.copyId)

			if not isUnlock then
				return 0
			end
		end

		return self.target.battleNpc
	end

	return 0
end

function TaskTargetBase:getChallengesNpcId()
	if self.target and self.target.challengeId then
		return UnlockConfig.instance:getChallengeNpcs(self.target.challengeId)
	end
end

function TaskTargetBase:getBattleLevels()
	if self.target then
		return self.target.levels
	end

	return nil
end

function TaskTargetBase:hasBattleLevel(levelId)
	if self.target and self.target.levels then
		local count = #self.target.levels

		for i = 1, count do
			if self.target.levels[i] == levelId then
				return true
			end
		end
	end

	return nil
end

function TaskTargetBase:getTaskGuideUI()
	if self.target then
		return self.target.uiName, self.target.uiParams, self.target.uiTab
	end
end

function TaskTargetBase:getChatNpcId()
	if self.target then
		return self.target.chatNpcId
	end

	return 0
end

function TaskTargetBase:getChatStoryId()
	if self.target then
		return self.target.chatStoryId
	end

	return 0
end

function TaskTargetBase:getDoingPerformed()
	return
end

function TaskTargetBase:getFollowNpcIds()
	if self.target then
		return self.target.followNpcs
	end
end

function TaskTargetBase:getBattleMonsterId()
	if self.target then
		return self.target.monsterId
	end

	return 0
end

function TaskTargetBase:getSceneId()
	if self.target then
		return self.target.sceneId
	end

	return 0
end

function TaskTargetBase:getTriggerId()
	if self.target then
		return self.target.triggerId
	end

	return 0
end

function TaskTargetBase:getCollectNpcId()
	if self.target then
		return self.target.collectNpcId
	end

	return 0
end

function TaskTargetBase:getItemId()
	if self.target then
		return self.target.itemId
	end

	return 0
end

function TaskTargetBase:getStoryId()
	if self.target then
		return self.target.storyId
	end

	return 0
end

function TaskTargetBase:getTargetType()
	if not self.target then
		return TaskConst.TSTEP_TARGET_NONE
	end

	return self.target.targetType
end

function TaskTargetBase:getChallengeId()
	if self.target then
		return self.target.challengeId, self.target.parseId, self.target.brancheId
	end

	return nil
end

function TaskTargetBase:getPveId()
	if self.target then
		return self.target.pveId
	end

	return nil
end

function TaskTargetBase:getSourceMonType()
	if self.target then
		return self.target.sourceMonType
	end

	return -1
end

function TaskTargetBase:getPetId()
	if self.target then
		if self.target.petId then
			return self.target.petId
		end

		if self.target.petIds then
			return self.target.petIds[1]
		end
	end

	return 0
end

function TaskTargetBase:getBattleStoryId()
	if self.target then
		return self.target.battleStoryId
	end

	return nil
end

function TaskTargetBase:getBattleStoryMode()
	if self.target then
		return self.target.battleStoryMode
	end

	return nil
end

function TaskTargetBase:getBattleStoryPet()
	if self.target then
		return self.target.battleStoryPet
	end

	return nil
end

function TaskTargetBase:getBattleStoryRound()
	if self.target then
		return self.target.battleStoryRound
	end

	return nil
end

return TaskTargetBase
