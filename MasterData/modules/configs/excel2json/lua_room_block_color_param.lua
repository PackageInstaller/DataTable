-- chunkname: @modules/configs/excel2json/lua_room_block_color_param.lua

module("modules.configs.excel2json.lua_room_block_color_param", package.seeall)

local lua_room_block_color_param = {}

function lua_room_block_color_param.onLoad(json)
	lua_room_block_color_param.confgData = json
	lua_room_block_color_param.configList, lua_room_block_color_param.configDict = lua_room_block_color_param.json_parse(json)
end

function lua_room_block_color_param.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		configDict[cfg.id] = cfg
	end

	return configList, configDict
end

return lua_room_block_color_param
