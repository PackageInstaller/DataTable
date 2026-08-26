-- chunkname: @modules/logic/versionactivity1_7/isolde/model/ActIsoldeModel.lua

module("modules.logic.versionactivity1_7.isolde.model.ActIsoldeModel", package.seeall)

local ActIsoldeModel = class("ActIsoldeModel", BaseModel)

function ActIsoldeModel:onInit()
	self:reInit()
end

function ActIsoldeModel:reInit()
	self.newFinishStoryLvlId = nil
	self.newFinishFightLvlId = nil
	self.lvlDataDic = nil
end

function ActIsoldeModel:initData()
	local actId = VersionActivity1_7Enum.ActivityId.Isolde

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

function ActIsoldeModel:updateData()
	for id, lvlData in pairs(self.lvlDataDic) do
		local dungeonMO = DungeonModel.instance:getEpisodeInfo(id)

		lvlData.isUnlock = DungeonModel.instance:isUnlock(lvlData.config)

		if dungeonMO then
			lvlData.star = dungeonMO.star or 0
		end
	end
end

function ActIsoldeModel:isLevelUnlock(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].isUnlock
end

function ActIsoldeModel:isLevelPass(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].star > 0
end

function ActIsoldeModel:checkFinishLevel(episodeId, star)
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

function ActIsoldeModel:getNewFinishStoryLvl()
	return self.newFinishStoryLvlId
end

function ActIsoldeModel:clearNewFinishStoryLvl()
	self.newFinishStoryLvlId = nil
end

function ActIsoldeModel:getNewFinishFightLvl()
	return self.newFinishFightLvlId
end

function ActIsoldeModel:clearNewFinishFightLvl()
	self.newFinishFightLvlId = nil
end

function ActIsoldeModel:setFirstEnter()
	self.firstEnter = true
end

function ActIsoldeModel:getFirstEnter()
	return self.firstEnter
end

function ActIsoldeModel:clearFirstEnter()
	self.firstEnter = nil
end

function ActIsoldeModel:setEnterFightIndex(index)
	self.recordFightIndex = index
end

function ActIsoldeModel:getEnterFightIndex()
	self.recordFightIndex = nil

	return self.recordFightIndex
end

ActIsoldeModel.instance = ActIsoldeModel.New()

return ActIsoldeModel
