-- chunkname: @modules/logic/versionactivity1_5/dungeon/model/VersionActivity1_5RevivalTaskModel.lua

module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5RevivalTaskModel", package.seeall)

local VersionActivity1_5RevivalTaskModel = class("VersionActivity1_5RevivalTaskModel", BaseModel)

function VersionActivity1_5RevivalTaskModel:onInit()
	return
end

function VersionActivity1_5RevivalTaskModel:reInit()
	self.playedIdList = nil
end

function VersionActivity1_5RevivalTaskModel:updateExploreTaskInfo(gainedExploreReward)
	self.heroTaskMoList = self.heroTaskMoList or {}

	if not DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.exploreTaskUnlockEpisodeId) then
		return
	end

	local taskMo = self:getTaskMo(VersionActivity1_5DungeonEnum.ExploreTaskId)

	if not taskMo then
		taskMo = VersionActivity1_5HeroTaskMo.New()

		taskMo:initByCo({
			id = VersionActivity1_5DungeonEnum.ExploreTaskId,
			preEpisodeId = VersionActivity1_5DungeonConfig.instance:getExploreUnlockEpisodeId(),
			toastId = VersionActivity1_5DungeonConfig.instance.exploreTaskLockToastId
		})
		table.insert(self.heroTaskMoList, taskMo)
	end

	taskMo:updateGainedReward(gainedExploreReward)
end

function VersionActivity1_5RevivalTaskModel:updateHeroTaskInfos(heroTaskInfos)
	self.heroTaskMoList = self.heroTaskMoList or {}

	for _, heroTaskInfo in ipairs(heroTaskInfos) do
		local taskMo = self:getTaskMo(heroTaskInfo.id)

		if not taskMo then
			taskMo = VersionActivity1_5HeroTaskMo.New()

			taskMo:initById(heroTaskInfo.id)
			table.insert(self.heroTaskMoList, taskMo)
		end

		taskMo:updateGainedReward(heroTaskInfo.gainedReward)
		taskMo:updateSubHeroTaskGainedReward(heroTaskInfo.gainedSubTaskIds)
	end
end

function VersionActivity1_5RevivalTaskModel:getTaskMoList()
	return self.heroTaskMoList
end

function VersionActivity1_5RevivalTaskModel:getTaskMo(taskId)
	if not self.heroTaskMoList then
		return nil
	end

	for _, heroTaskMo in ipairs(self.heroTaskMoList) do
		if heroTaskMo.id == taskId then
			return heroTaskMo
		end
	end

	return nil
end

function VersionActivity1_5RevivalTaskModel:setSelectHeroTaskId(taskId)
	if taskId == self.selectTaskId then
		return
	end

	self.selectTaskId = taskId

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.SelectHeroTaskTabChange)
end

function VersionActivity1_5RevivalTaskModel:getSelectHeroTaskId()
	return self.selectTaskId
end

function VersionActivity1_5RevivalTaskModel:getSubHeroTaskStatus(subTaskCo)
	if self:checkSubHeroTaskGainedReward(subTaskCo) then
		return VersionActivity1_5DungeonEnum.SubHeroTaskStatus.GainedReward
	end

	if self:checkSubHeroTaskIsFinish(subTaskCo) then
		return VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished
	end

	if self:checkSubHeroTaskIsUnlock(subTaskCo) then
		return VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal
	end

	return VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Lock
end

function VersionActivity1_5RevivalTaskModel:checkSubHeroTaskGainedReward(subTaskCo)
	local taskMo = self:getTaskMo(subTaskCo.taskId)

	return taskMo and taskMo:subTaskIsGainedReward(subTaskCo.id)
end

function VersionActivity1_5RevivalTaskModel:checkSubHeroTaskIsFinish(taskCo)
	local elementIdList = string.splitToNumber(taskCo.elementIds, "#")

	for _, elementId in ipairs(elementIdList) do
		if not DungeonMapModel.instance:elementIsFinished(elementId) then
			return false
		end
	end

	return true
end

function VersionActivity1_5RevivalTaskModel:checkSubHeroTaskIsUnlock(taskCo)
	local param = taskCo.unlockParam

	if taskCo.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishElement then
		return self:_checkFinishElement(tonumber(param))
	elseif taskCo.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishEpisode then
		return self:_checkFinishEpisode(tonumber(param))
	elseif taskCo.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishSubHeroTask then
		return self:_checkFinishSubTask(tonumber(param))
	elseif taskCo.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishElementAndEpisode then
		local paramList = string.splitToNumber(param, "#")

		return self:_checkFinishElement(paramList[1]) and self:_checkFinishEpisode(paramList[2])
	elseif taskCo.unlockType == VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType.FinishSubHeroTaskAndEpisode then
		local paramList = string.splitToNumber(param, "#")

		return self:_checkFinishSubTask(paramList[1]) and self:_checkFinishEpisode(paramList[2])
	else
		return true
	end
end

function VersionActivity1_5RevivalTaskModel:_checkFinishElement(elementId)
	return DungeonMapModel.instance:elementIsFinished(elementId)
end

function VersionActivity1_5RevivalTaskModel:_checkFinishAnyOneElement(elementIdList)
	for _, elementId in ipairs(elementIdList) do
		if self:_checkFinishElement(elementId) then
			return true
		end
	end

	return false
end

function VersionActivity1_5RevivalTaskModel:_checkFinishEpisode(episodeId)
	local dungeonMo = DungeonModel.instance:getEpisodeInfo(episodeId)

	return dungeonMo and dungeonMo.star >= DungeonEnum.StarType.Normal
end

function VersionActivity1_5RevivalTaskModel:_checkFinishSubTask(subTaskId)
	local subTaskCo = lua_act139_sub_hero_task.configDict[subTaskId]

	return subTaskCo and self:getSubHeroTaskStatus(subTaskCo) >= VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished
end

function VersionActivity1_5RevivalTaskModel:gainedExploreTaskReward()
	local taskMo = self:getTaskMo(VersionActivity1_5DungeonEnum.ExploreTaskId)

	taskMo:updateGainedReward(true)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnGainedExploreReward)
end

function VersionActivity1_5RevivalTaskModel:gainedHeroTaskReward(heroTaskId)
	local taskMo = self:getTaskMo(heroTaskId)

	taskMo:updateGainedReward(true)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnGainedHeroTaskReward, heroTaskId)
end

function VersionActivity1_5RevivalTaskModel:gainedSubTaskReward(subTaskId)
	local subTaskCo = lua_act139_sub_hero_task.configDict[subTaskId]
	local taskMo = self:getTaskMo(subTaskCo.taskId)

	taskMo:gainedSubHeroTaskId(subTaskId)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnGainedSubHeroTaskReward, subTaskId)
end

function VersionActivity1_5RevivalTaskModel:checkExploreTaskGainedTotalReward()
	local taskMo = self:getTaskMo(VersionActivity1_5DungeonEnum.ExploreTaskId)

	return taskMo and taskMo.gainedReward
end

function VersionActivity1_5RevivalTaskModel:getExploreTaskStatus(taskCo)
	if not self:checkExploreTaskUnlock(taskCo) then
		return VersionActivity1_5DungeonEnum.ExploreTaskStatus.Lock
	end

	if self:checkExploreTaskRunning(taskCo) then
		return VersionActivity1_5DungeonEnum.ExploreTaskStatus.Running
	end

	if self:checkExploreTaskGainedReward(taskCo) then
		return VersionActivity1_5DungeonEnum.ExploreTaskStatus.GainedReward
	end

	if self:checkExploreTaskFinish(taskCo) then
		return VersionActivity1_5DungeonEnum.ExploreTaskStatus.Finished
	end

	return VersionActivity1_5DungeonEnum.ExploreTaskStatus.Normal
end

function VersionActivity1_5RevivalTaskModel:checkExploreTaskGainedReward(taskCo)
	for _, elementId in ipairs(taskCo.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(elementId) then
			return false
		end
	end

	return true
end

function VersionActivity1_5RevivalTaskModel:checkExploreTaskFinish(taskCo)
	local elementId = taskCo.elementList[1]

	if taskCo.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Dispatch then
		local dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(elementId)

		return dispatchMo and dispatchMo:isFinish()
	end

	local elementCo = lua_chapter_map_element.configDict[elementId]
	local episodeId = tonumber(elementCo.param)

	return DungeonModel.instance:hasPassLevel(episodeId)
end

function VersionActivity1_5RevivalTaskModel:checkExploreTaskRunning(taskCo)
	if taskCo.type == VersionActivity1_5DungeonEnum.ExploreTaskType.Fight then
		return false
	end

	local elementId = taskCo.elementList[1]
	local dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMoByElementId(elementId)

	return dispatchMo and dispatchMo:isRunning()
end

function VersionActivity1_5RevivalTaskModel:checkExploreTaskUnlock(taskCo)
	if taskCo.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishElement then
		return self:_checkFinishElement(tonumber(taskCo.unlockParam))
	elseif taskCo.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishEpisode then
		return self:_checkFinishEpisode(tonumber(taskCo.unlockParam))
	elseif taskCo.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishElementAndEpisode then
		local paramList = string.splitToNumber(taskCo.unlockParam, "#")

		return self:_checkFinishElement(paramList[1]) and self:_checkFinishEpisode(paramList[2])
	elseif taskCo.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishAnyOneElement then
		local paramList = string.splitToNumber(taskCo.unlockParam, "#")

		return self:_checkFinishAnyOneElement(paramList)
	elseif taskCo.unlockType == VersionActivity1_5DungeonEnum.ExploreTaskUnLockType.FinishEpisodeAndAnyOneElement then
		local paramList = string.split(taskCo.unlockParam, "#")

		return self:_checkFinishEpisode(tonumber(paramList[1])) and self:_checkFinishAnyOneElement(string.splitToNumber(paramList[2], "|"))
	else
		return true
	end
end

function VersionActivity1_5RevivalTaskModel:clear()
	self.heroTaskMoList = nil

	self:clearSelectTaskId()
end

function VersionActivity1_5RevivalTaskModel:clearSelectTaskId()
	self.selectTaskId = nil
end

function VersionActivity1_5RevivalTaskModel:checkIsPlayedUnlockAnimation(subHeroTaskId)
	self:initPlayedUnlockDict()

	return tabletool.indexOf(self.playedIdList, subHeroTaskId)
end

function VersionActivity1_5RevivalTaskModel:playedUnlockAnimation(subHeroTaskId)
	self:initPlayedUnlockDict()

	if tabletool.indexOf(self.playedIdList, subHeroTaskId) then
		return
	end

	table.insert(self.playedIdList, subHeroTaskId)

	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_5RevivalTaskUnlockKey)

	PlayerPrefsHelper.setString(key, table.concat(self.playedIdList, "|"))
end

function VersionActivity1_5RevivalTaskModel:initPlayedUnlockDict()
	if not self.playedIdList then
		self.playedIdList = {}

		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_5RevivalTaskUnlockKey)

		self.playedIdList = string.splitToNumber(PlayerPrefsHelper.getString(key, ""), "|")
	end
end

function VersionActivity1_5RevivalTaskModel:checkNeedShowElementRedDot()
	if self.preCalculateFrame == Time.frameCount then
		return self.isShowElementRedDot
	end

	self.preCalculateFrame = Time.frameCount
	self.isShowElementRedDot = false

	local taskList = VersionActivity1_5DungeonConfig.instance:getExploreTaskList()

	for _, taskCo in ipairs(taskList) do
		for _, elementId in ipairs(taskCo.elementList) do
			if not DungeonMapModel.instance:elementIsFinished(elementId) then
				local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
				local type = elementCo.type
				local isFinish = false

				if type == DungeonEnum.ElementType.Fight then
					isFinish = DungeonModel.instance:hasPassLevel(tonumber(elementCo.param))
				elseif type == DungeonEnum.ElementType.EnterDialogue then
					isFinish = DialogueModel.instance:isFinishDialogue(tonumber(elementCo.param))
				elseif type == DungeonEnum.ElementType.EnterDispatch then
					local dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMo(tonumber(elementCo.param))

					isFinish = dispatchMo and dispatchMo:isFinish()
				end

				if isFinish then
					self.isShowElementRedDot = true

					if SLFramework.FrameworkSettings.IsEditor then
						logNormal("need show element reddot, id : " .. tostring(elementId))
					end

					return self.isShowElementRedDot
				end
			end
		end
	end

	return self.isShowElementRedDot
end

function VersionActivity1_5RevivalTaskModel:setIsPlayingOpenAnim(playing)
	self.isPlayingOpenAnim = playing

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OpenAnimPlayingStatusChange, self.isPlayingOpenAnim)
end

function VersionActivity1_5RevivalTaskModel:getIsPlayingOpenAnim()
	return self.isPlayingOpenAnim
end

VersionActivity1_5RevivalTaskModel.instance = VersionActivity1_5RevivalTaskModel.New()

return VersionActivity1_5RevivalTaskModel
