-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_map_wall.lua

module("modules.configs.excel2json.lua_assassin_stealth_map_wall", package.seeall)

local lua_assassin_stealth_map_wall = {}

function lua_assassin_stealth_map_wall.onLoad(json)
	lua_assassin_stealth_map_wall.configList, lua_assassin_stealth_map_wall.configDict = lua_assassin_stealth_map_wall.json_parse(json)
end

function lua_assassin_stealth_map_wall.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		local mapCfgDict = configDict[cfg.mapId]

		if not mapCfgDict then
			mapCfgDict = {}
			configDict[cfg.mapId] = mapCfgDict
		end

		mapCfgDict[cfg.wallId] = cfg
	end

	return configList, configDict
end

return lua_assassin_stealth_map_wall
