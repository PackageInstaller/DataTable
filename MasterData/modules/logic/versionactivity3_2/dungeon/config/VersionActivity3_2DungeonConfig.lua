-- chunkname: @modules/logic/versionactivity3_2/dungeon/config/VersionActivity3_2DungeonConfig.lua

module("modules.logic.versionactivity3_2.dungeon.config.VersionActivity3_2DungeonConfig", package.seeall)

local VersionActivity3_2DungeonConfig = class("VersionActivity3_2DungeonConfig", BaseConfig)

function VersionActivity3_2DungeonConfig:ctor()
	return
end

function VersionActivity3_2DungeonConfig:reqConfigNames()
	return {
		"v3a2_chapter_map",
		"v3a2_chapter_option",
		"v3a2_chapter_result",
		"v3a2_chapter_report",
		"v3a2_chapter_reward"
	}
end

function VersionActivity3_2DungeonConfig:onConfigLoaded(configName, configTable)
	return
end

function VersionActivity3_2DungeonConfig:getOptionConfigs()
	local _reportList = {}

	for i = #lua_chapter_map_element.configList, 1, -1 do
		local config = lua_chapter_map_element.configList[i]

		if config.type == DungeonEnum.ElementType.V3a2Option then
			table.insert(_reportList, config)
		elseif #_reportList > 0 then
			break
		end
	end

	return _reportList
end

VersionActivity3_2DungeonConfig.instance = VersionActivity3_2DungeonConfig.New()

return VersionActivity3_2DungeonConfig
