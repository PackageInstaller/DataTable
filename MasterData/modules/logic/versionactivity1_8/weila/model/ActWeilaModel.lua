-- chunkname: @modules/logic/versionactivity1_8/weila/model/ActWeilaModel.lua

module("modules.logic.versionactivity1_8.weila.model.ActWeilaModel", package.seeall)

local ActWeilaModel = class("ActWeilaModel", BaseModel)

function ActWeilaModel:onInit()
	self:reInit()
end

function ActWeilaModel:reInit()
	self.newFinishStoryLvlId = nil
	self.newFinishFightLvlId = nil
	self.lvlDataDic = nil
end

function ActWeilaModel:initData()
	local actId = VersionActivity1_8Enum.ActivityId.Weila

	if not self.lvlDataDic then
		self.lvlDataDic = {}

		local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(actId)

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

		local fightConfigList = RoleActivityConfig.instance:getBattleLevelList(actId)

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
		local enterConfig = RoleActivityConfig.instance:getActivityEnterInfo(actId)

		self.storyChapteId = enterConfig.storyGroupId
		self.fightChapterId = enterConfig.episodeGroupId
	end
end

function ActWeilaModel:updateData()
	for id, lvlData in pairs(self.lvlDataDic) do
		local dungeonMO = DungeonModel.instance:getEpisodeInfo(id)

		lvlData.isUnlock = DungeonModel.instance:isUnlock(lvlData.config)

		if dungeonMO then
			lvlData.star = dungeonMO.star or 0
		end
	end
end

function ActWeilaModel:isLevelUnlock(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].isUnlock
end

function ActWeilaModel:isLevelPass(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].star > 0
end

function ActWeilaModel:checkFinishLevel(episodeId, star)
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

function ActWeilaModel:getNewFinishStoryLvl()
	return self.newFinishStoryLvlId
end

function ActWeilaModel:clearNewFinishStoryLvl()
	self.newFinishStoryLvlId = nil
end

function ActWeilaModel:getNewFinishFightLvl()
	return self.newFinishFightLvlId
end

function ActWeilaModel:clearNewFinishFightLvl()
	self.newFinishFightLvlId = nil
end

function ActWeilaModel:setEnterFightIndex(index)
	self.recordFightIndex = index
end

function ActWeilaModel:getEnterFightIndex()
	self.recordFightIndex = nil

	return self.recordFightIndex
end

ActWeilaModel.instance = ActWeilaModel.New()

return ActWeilaModel
