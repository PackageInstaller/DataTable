-- chunkname: @modules/logic/versionactivity1_8/windsong/model/ActWindSongModel.lua

module("modules.logic.versionactivity1_8.windsong.model.ActWindSongModel", package.seeall)

local ActWindSongModel = class("ActWindSongModel", BaseModel)

function ActWindSongModel:onInit()
	self:reInit()
end

function ActWindSongModel:reInit()
	self.newFinishStoryLvlId = nil
	self.newFinishFightLvlId = nil
	self.lvlDataDic = nil
end

function ActWindSongModel:initData()
	local actId = VersionActivity1_8Enum.ActivityId.WindSong

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

function ActWindSongModel:updateData()
	for id, lvlData in pairs(self.lvlDataDic) do
		local dungeonMO = DungeonModel.instance:getEpisodeInfo(id)

		lvlData.isUnlock = DungeonModel.instance:isUnlock(lvlData.config)

		if dungeonMO then
			lvlData.star = dungeonMO.star or 0
		end
	end
end

function ActWindSongModel:isLevelUnlock(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].isUnlock
end

function ActWindSongModel:isLevelPass(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].star > 0
end

function ActWindSongModel:checkFinishLevel(episodeId, star)
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

function ActWindSongModel:getNewFinishStoryLvl()
	return self.newFinishStoryLvlId
end

function ActWindSongModel:clearNewFinishStoryLvl()
	self.newFinishStoryLvlId = nil
end

function ActWindSongModel:getNewFinishFightLvl()
	return self.newFinishFightLvlId
end

function ActWindSongModel:clearNewFinishFightLvl()
	self.newFinishFightLvlId = nil
end

function ActWindSongModel:setEnterFightIndex(index)
	self.recordFightIndex = index
end

function ActWindSongModel:getEnterFightIndex()
	self.recordFightIndex = nil

	return self.recordFightIndex
end

ActWindSongModel.instance = ActWindSongModel.New()

return ActWindSongModel
