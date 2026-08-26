-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/config/V1a6_CachotConfig.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotConfig", package.seeall)

local V1a6_CachotConfig = class("V1a6_CachotConfig", BaseConfig)

function V1a6_CachotConfig:reqConfigNames()
	return {
		"rogue_const",
		"rogue_difficulty",
		"rogue_room",
		"rogue_field",
		"rogue_heartbeat",
		"rogue_score",
		"rogue_scene_level"
	}
end

function V1a6_CachotConfig:onInit()
	return
end

function V1a6_CachotConfig:onConfigLoaded(configName, configTable)
	if configName == "rogue_score" then
		V1a6_CachotScoreConfig.instance:init(configTable)
	elseif configName == "rogue_room" then
		V1a6_CachotRoomConfig.instance:init(configTable)
	end
end

function V1a6_CachotConfig:getHeartConfig(heartNum)
	local co

	for _, v in pairs(lua_rogue_heartbeat.configList) do
		local arr = string.splitToNumber(v.range, "#")

		if heartNum >= arr[1] and heartNum <= arr[2] then
			co = v

			break
		end
	end

	if not co then
		logError("没有心跳对应的配置:" .. heartNum)

		co = lua_rogue_heartbeat.configList[1]
	end

	return co
end

function V1a6_CachotConfig:getDifficultyConfig(difficulty)
	local co

	for i, v in ipairs(lua_rogue_difficulty.configList) do
		if difficulty == i then
			co = v

			break
		end
	end

	if not co then
		logError("没有难度对应的配置:" .. difficulty)

		co = lua_rogue_difficulty.configList[1]
	end

	return co
end

function V1a6_CachotConfig:getDifficultyCount()
	return #lua_rogue_difficulty.configList
end

function V1a6_CachotConfig:getConstConfig(id)
	local co

	for i, v in ipairs(lua_rogue_const.configList) do
		if id == i then
			co = v

			break
		end
	end

	if not co then
		logError("没有常量对应的配置:" .. id)

		co = lua_rogue_const.configList[1]
	end

	return co
end

function V1a6_CachotConfig:getSceneLevelId(id)
	local co = lua_rogue_scene_level.configDict[id]

	co = co or lua_rogue_scene_level.configList[1]

	return co.sceneLevel
end

V1a6_CachotConfig.instance = V1a6_CachotConfig.New()

return V1a6_CachotConfig
