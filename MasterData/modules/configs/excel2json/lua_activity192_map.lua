-- chunkname: @modules/configs/excel2json/lua_activity192_map.lua

module("modules.configs.excel2json.lua_activity192_map", package.seeall)

local lua_activity192_map = {}

function lua_activity192_map.onLoad(json)
	lua_activity192_map.configList, lua_activity192_map.configDict = lua_activity192_map.json_parse(json)
end

function lua_activity192_map.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		local mapCfgDict = configDict[cfg.mapId]

		if not mapCfgDict then
			mapCfgDict = {}
			configDict[cfg.mapId] = mapCfgDict
		end

		mapCfgDict[cfg.componentId] = cfg
	end

	return configList, configDict
end

return lua_activity192_map
