-- chunkname: @modules/configs/excel2json/lua_room_scene_ambient.lua

module("modules.configs.excel2json.lua_room_scene_ambient", package.seeall)

local lua_room_scene_ambient = {}

function lua_room_scene_ambient.onLoad(json)
	lua_room_scene_ambient.confgData = json
	lua_room_scene_ambient.configList, lua_room_scene_ambient.configDict = lua_room_scene_ambient.json_parse(json)
end

function lua_room_scene_ambient.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		configDict[cfg.id] = cfg
	end

	return configList, configDict
end

return lua_room_scene_ambient
