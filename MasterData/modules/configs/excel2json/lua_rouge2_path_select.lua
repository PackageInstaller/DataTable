-- chunkname: @modules/configs/excel2json/lua_rouge2_path_select.lua

module("modules.configs.excel2json.lua_rouge2_path_select", package.seeall)

local lua_rouge2_path_select = {}
local fields = {
	simageMapPos = 3,
	startPos = 4,
	confirmDesc = 6,
	id = 1,
	startDesc = 5,
	mapRes = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	startDesc = 1,
	confirmDesc = 2
}

function lua_rouge2_path_select.onLoad(json)
	lua_rouge2_path_select.configList, lua_rouge2_path_select.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_path_select
