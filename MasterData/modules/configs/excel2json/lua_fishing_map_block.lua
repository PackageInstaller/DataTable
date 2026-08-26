-- chunkname: @modules/configs/excel2json/lua_fishing_map_block.lua

module("modules.configs.excel2json.lua_fishing_map_block", package.seeall)

local lua_fishing_map_block = {}

function lua_fishing_map_block.onLoad(json)
	lua_fishing_map_block.configList, lua_fishing_map_block.configDict = lua_fishing_map_block.json_parse(json)
end

function lua_fishing_map_block.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		local mapCfgDict = configDict[cfg.mapId]

		if not mapCfgDict then
			mapCfgDict = {}
			configDict[cfg.mapId] = mapCfgDict
		end

		mapCfgDict[cfg.defineId] = cfg
	end

	return configList, configDict
end

return lua_fishing_map_block
