-- chunkname: @modules/configs/excel2json/lua_fishing_map_building.lua

module("modules.configs.excel2json.lua_fishing_map_building", package.seeall)

local lua_fishing_map_building = {}

function lua_fishing_map_building.onLoad(json)
	lua_fishing_map_building.configList, lua_fishing_map_building.configDict = lua_fishing_map_building.json_parse(json)
end

function lua_fishing_map_building.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		cfg.isFishingBuilding = true

		table.insert(configList, cfg)

		local mapCfgDict = configDict[cfg.mapId]

		if not mapCfgDict then
			mapCfgDict = {}
			configDict[cfg.mapId] = mapCfgDict
		end

		mapCfgDict[cfg.uid] = cfg
	end

	return configList, configDict
end

return lua_fishing_map_building
