-- chunkname: @modules/configs/excel2json/lua_racing_effect.lua

module("modules.configs.excel2json.lua_racing_effect", package.seeall)

local lua_racing_effect = {}
local fields = {
	param = 4,
	effectType = 3,
	id = 1,
	carAnimation = 2,
	limit = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_racing_effect.onLoad(json)
	lua_racing_effect.configList, lua_racing_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_racing_effect
