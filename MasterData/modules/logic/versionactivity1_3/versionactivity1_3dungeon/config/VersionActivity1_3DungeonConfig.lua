-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/config/VersionActivity1_3DungeonConfig.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.config.VersionActivity1_3DungeonConfig", package.seeall)

local VersionActivity1_3DungeonConfig = class("VersionActivity1_3DungeonConfig", BaseConfig)

function VersionActivity1_3DungeonConfig:ctor()
	return
end

function VersionActivity1_3DungeonConfig:reqConfigNames()
	return {
		"activity113_const"
	}
end

function VersionActivity1_3DungeonConfig:onConfigLoaded(configName, configTable)
	return
end

function VersionActivity1_3DungeonConfig:getDungeonConst(key)
	return lua_activity113_const.configDict[VersionActivity1_3Enum.ActivityId.Dungeon][key]
end

VersionActivity1_3DungeonConfig.instance = VersionActivity1_3DungeonConfig.New()

return VersionActivity1_3DungeonConfig
