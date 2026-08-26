-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/config/VersionActivity1_2DungeonConfig.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.config.VersionActivity1_2DungeonConfig", package.seeall)

local VersionActivity1_2DungeonConfig = class("VersionActivity1_2DungeonConfig", BaseConfig)

function VersionActivity1_2DungeonConfig:ctor()
	self._elements = {}
end

function VersionActivity1_2DungeonConfig:reqConfigNames()
	return {
		"activity116_building",
		"activity116_episode_sp"
	}
end

function VersionActivity1_2DungeonConfig:onConfigLoaded(configName, configTable)
	if configName == "activity116_building" then
		self:_initConfig()
	end
end

function VersionActivity1_2DungeonConfig:_initConfig()
	for i, v in ipairs(lua_activity116_building.configList) do
		self._elements[v.elementId] = self._elements[v.elementId] or {}
		self._elements[v.elementId][v.id] = v
	end
end

function VersionActivity1_2DungeonConfig:getBuildingConfigsByElementID(element_id)
	return self._elements and self._elements[element_id]
end

function VersionActivity1_2DungeonConfig:get1_2EpisodeMapConfig(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local num = episodeId % 100
	local id = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1)[1].id

	id = id - id % 100 + num
	episodeCo = DungeonConfig.instance:getEpisodeCO(id)

	return DungeonConfig.instance:getChapterMapCfg(episodeCo.chapterId, episodeCo.preEpisode)
end

function VersionActivity1_2DungeonConfig:getEpisodeIndex(episodeId)
	local episodeList = DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(episodeId)

	if episodeList then
		local var_7_0 = DungeonConfig.instance:getEpisodeCO(episodeList[1])

		if not var_7_0 then
			var_7_0 = DungeonConfig.instance:getEpisodeCO(episodeId)

			local config = var_7_0

			if config.chapterId == VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard then
				local num = episodeId % 100
				local id = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1)[1].id

				id = id - id % 100 + num

				return DungeonConfig.instance:getChapterEpisodeIndexWithSP(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1, id)
			else
				return DungeonConfig.instance:getChapterEpisodeIndexWithSP(config.chapterId, config.id)
			end
		end
	end
end

function VersionActivity1_2DungeonConfig:getConfigByEpisodeId(episodeId)
	if not self._buildingType4 then
		local tarList = self:getType4List()

		for i, v in ipairs(self._buildingType4) do
			local episodeArr = string.splitToNumber(v.configType, "#")

			for index, id in ipairs(episodeArr) do
				if id == episodeId then
					return v
				end
			end
		end
	end
end

function VersionActivity1_2DungeonConfig:getType4List()
	if self._buildingType4 then
		return self._buildingType4
	end

	self._buildingType4 = {}

	for i, v in ipairs(lua_activity116_building.configList) do
		if v.buildingType == 4 then
			table.insert(self._buildingType4, v)
		end
	end

	return self._buildingType4
end

VersionActivity1_2DungeonConfig.instance = VersionActivity1_2DungeonConfig.New()

return VersionActivity1_2DungeonConfig
