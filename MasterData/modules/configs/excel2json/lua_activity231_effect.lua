-- chunkname: @modules/configs/excel2json/lua_activity231_effect.lua

module("modules.configs.excel2json.lua_activity231_effect", package.seeall)

local lua_activity231_effect = {}
local fields = {
	id = 1,
	effectVx = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity231_effect.onLoad(json)
	lua_activity231_effect.configList, lua_activity231_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_effect
