-- chunkname: @modules/logic/versionactivity3_5/dungeon/config/VersionActivity3_5DungeonConfig.lua

module("modules.logic.versionactivity3_5.dungeon.config.VersionActivity3_5DungeonConfig", package.seeall)

local VersionActivity3_5DungeonConfig = class("VersionActivity3_5DungeonConfig", BaseConfig)

function VersionActivity3_5DungeonConfig:ctor()
	return
end

function VersionActivity3_5DungeonConfig:reqConfigNames()
	return {
		"v3a2_chapter_map",
		"v3a2_chapter_option",
		"v3a2_chapter_result",
		"v3a2_chapter_report",
		"v3a2_chapter_reward"
	}
end

function VersionActivity3_5DungeonConfig:onConfigLoaded(configName, configTable)
	return
end

function VersionActivity3_5DungeonConfig:getOptionConfigs()
	local _reportList = {}

	for i = #lua_chapter_map_element.configList, 1, -1 do
		local config = lua_chapter_map_element.configList[i]

		if config.type == DungeonEnum.ElementType.V3a4BBS then
			table.insert(_reportList, config)
		elseif #_reportList > 0 then
			break
		end
	end

	return _reportList
end

function VersionActivity3_5DungeonConfig:getChapterMap(episodeId)
	return lua_v3a2_chapter_map.configDict[episodeId]
end

function VersionActivity3_5DungeonConfig:getChapterReward(id)
	return lua_v3a2_chapter_reward.configDict[id]
end

function VersionActivity3_5DungeonConfig:getChapterResult(id)
	return lua_v3a2_chapter_result.configDict[id]
end

function VersionActivity3_5DungeonConfig:getChapterReport(id)
	return lua_v3a2_chapter_report.configDict[id]
end

function VersionActivity3_5DungeonConfig:getElementsChapterReport()
	local list = lua_v3a2_chapter_report.configList
	local resultList = {}

	for i, config in ipairs(list) do
		if DungeonMapModel.instance:elementIsFinished(config.element) then
			table.insert(resultList, config.element)
		end
	end

	return resultList
end

VersionActivity3_5DungeonConfig.instance = VersionActivity3_5DungeonConfig.New()

return VersionActivity3_5DungeonConfig
