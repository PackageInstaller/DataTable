-- chunkname: @modules/configs/excel2json/lua_explore_signs.lua

module("modules.configs.excel2json.lua_explore_signs", package.seeall)

local lua_explore_signs = {}
local fields = {
	id = 1,
	icon = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_explore_signs.onLoad(json)
	lua_explore_signs.configList, lua_explore_signs.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_explore_signs
