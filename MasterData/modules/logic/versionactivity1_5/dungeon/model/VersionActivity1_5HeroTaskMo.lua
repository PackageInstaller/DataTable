-- chunkname: @modules/logic/versionactivity1_5/dungeon/model/VersionActivity1_5HeroTaskMo.lua

module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5HeroTaskMo", package.seeall)

local VersionActivity1_5HeroTaskMo = pureTable("DispatchMo")

function VersionActivity1_5HeroTaskMo:initById(taskId)
	self.id = taskId
	self.config = VersionActivity1_5DungeonConfig.instance:getHeroTaskCo(self.id)
	self.subTaskCoList = VersionActivity1_5DungeonConfig.instance:getSubHeroTaskList(self.id)
	self.gainedReward = false
	self.subTaskGainedRewardList = nil
end

function VersionActivity1_5HeroTaskMo:initByCo(taskCo)
	self.id = taskCo.id
	self.config = taskCo
	self.gainedReward = false
	self.subTaskGainedRewardList = nil
end

function VersionActivity1_5HeroTaskMo:updateGainedReward(gainedReward)
	self.gainedReward = gainedReward
end

function VersionActivity1_5HeroTaskMo:updateSubHeroTaskGainedReward(gainedSubTaskIds)
	if self:isExploreTask() then
		return
	end

	self.subTaskGainedRewardList = {}

	if not gainedSubTaskIds then
		return
	end

	for _, subTaskId in ipairs(gainedSubTaskIds) do
		table.insert(self.subTaskGainedRewardList, subTaskId)
	end
end

function VersionActivity1_5HeroTaskMo:gainedSubHeroTaskId(subTaskId)
	table.insert(self.subTaskGainedRewardList, subTaskId)
end

function VersionActivity1_5HeroTaskMo:isExploreTask()
	return self.id == VersionActivity1_5DungeonEnum.ExploreTaskId
end

function VersionActivity1_5HeroTaskMo:isUnlock()
	return DungeonModel.instance:hasPassLevelAndStory(self.config.preEpisodeId)
end

function VersionActivity1_5HeroTaskMo:isFinish()
	if self:isExploreTask() then
		return false
	end

	for _, subTaskCo in ipairs(self.subTaskCoList) do
		if not VersionActivity1_5RevivalTaskModel.instance:checkSubHeroTaskIsFinish(subTaskCo) then
			return false
		end
	end

	return true
end

function VersionActivity1_5HeroTaskMo:getSpriteName()
	if self.id == VersionActivity1_5DungeonEnum.ExploreTaskId then
		return (self.isSelect or nil) and (VersionActivity1_5DungeonEnum.ExploreTabImageSelect or VersionActivity1_5DungeonEnum.ExploreTabImageNotSelect)
	end

	return (self.isSelect or nil) and (self.config.heroTabIcon .. 1 or self.config.heroTabIcon .. 2)
end

function VersionActivity1_5HeroTaskMo:subTaskIsGainedReward(subTaskId)
	return self.subTaskGainedRewardList and tabletool.indexOf(self.subTaskGainedRewardList, subTaskId)
end

function VersionActivity1_5HeroTaskMo:getSubTaskFinishCount()
	local count = 0

	for _, subTaskCo in ipairs(self.subTaskCoList) do
		if VersionActivity1_5RevivalTaskModel.instance:checkSubHeroTaskIsFinish(subTaskCo) then
			count = count + 1
		end
	end

	return count
end

function VersionActivity1_5HeroTaskMo:getSubTaskCount()
	return (self.subTaskCoList or nil) and (#self.subTaskCoList or 0)
end

function VersionActivity1_5HeroTaskMo:getSubTaskCoList()
	return self.subTaskCoList
end

return VersionActivity1_5HeroTaskMo
