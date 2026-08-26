-- chunkname: @modules/logic/versionactivity1_6/getian/model/ActGeTianModel.lua

module("modules.logic.versionactivity1_6.getian.model.ActGeTianModel", package.seeall)

local ActGeTianModel = class("ActGeTianModel", BaseModel)

function ActGeTianModel:onInit()
	self:reInit()
end

function ActGeTianModel:reInit()
	self.newFinishStoryLvlId = nil
	self.newFinishFightLvlId = nil
	self.lvlDataDic = nil
end

function ActGeTianModel:initData()
	if not self.lvlDataDic then
		self.lvlDataDic = {}

		local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(ActGeTianEnum.ActivityId)

		for _, storyConfig in ipairs(storyConfigList) do
			local dungeonMO = DungeonModel.instance:getEpisodeInfo(storyConfig.id)
			local _isUnlock = DungeonModel.instance:isUnlock(storyConfig)
			local var_3_0 = {
				config = storyConfig,
				isUnlock = _isUnlock
			}

			if dungeonMO then
				var_3_0.star = dungeonMO.star or 0
			end

			self.lvlDataDic[storyConfig.id] = var_3_0
		end

		local fightConfigList = RoleActivityConfig.instance:getBattleLevelList(ActGeTianEnum.ActivityId)

		for _, fightConfig in ipairs(fightConfigList) do
			local dungeonMO = DungeonModel.instance:getEpisodeInfo(fightConfig.id)
			local _isUnlock = DungeonModel.instance:isUnlock(fightConfig)
			local var_3_1 = {
				config = fightConfig,
				isUnlock = _isUnlock
			}

			if dungeonMO then
				var_3_1.star = dungeonMO.star or 0
			end

			self.lvlDataDic[fightConfig.id] = var_3_1
		end
	end

	if not self.storyChapteId or not self.fightChapterId then
		local enterConfig = RoleActivityConfig.instance:getActivityEnterInfo(ActGeTianEnum.ActivityId)

		self.storyChapteId = enterConfig.storyGroupId
		self.fightChapterId = enterConfig.episodeGroupId
	end
end

function ActGeTianModel:updateData()
	for id, lvlData in pairs(self.lvlDataDic) do
		local dungeonMO = DungeonModel.instance:getEpisodeInfo(id)

		lvlData.isUnlock = DungeonModel.instance:isUnlock(lvlData.config)

		if dungeonMO then
			lvlData.star = dungeonMO.star or 0
		end
	end
end

function ActGeTianModel:isLevelUnlock(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].isUnlock
end

function ActGeTianModel:isLevelPass(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].star > 0
end

function ActGeTianModel:checkFinishLevel(episodeId, star)
	if not self.lvlDataDic then
		return
	end

	local lvlData = self.lvlDataDic[episodeId]

	if lvlData and lvlData.star == 0 and star > 0 then
		local chapterId = lvlData.config.chapterId

		if chapterId == self.storyChapteId then
			self.newFinishStoryLvlId = episodeId
		elseif chapterId == self.fightChapterId then
			self.newFinishFightLvlId = episodeId
		end
	end
end

function ActGeTianModel:getNewFinishStoryLvl()
	return self.newFinishStoryLvlId
end

function ActGeTianModel:clearNewFinishStoryLvl()
	self.newFinishStoryLvlId = nil
end

function ActGeTianModel:getNewFinishFightLvl()
	return self.newFinishFightLvlId
end

function ActGeTianModel:clearNewFinishFightLvl()
	self.newFinishFightLvlId = nil
end

function ActGeTianModel:setFirstEnter()
	self.firstEnter = true
end

function ActGeTianModel:getFirstEnter()
	return self.firstEnter
end

function ActGeTianModel:clearFirstEnter()
	self.firstEnter = nil
end

function ActGeTianModel:setEnterFightIndex(index)
	self.recordFightIndex = index
end

function ActGeTianModel:getEnterFightIndex()
	self.recordFightIndex = nil

	return self.recordFightIndex
end

ActGeTianModel.instance = ActGeTianModel.New()

return ActGeTianModel
