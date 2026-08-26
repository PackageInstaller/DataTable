-- chunkname: @modules/configs/excel2json/lua_activity168_effect.lua

module("modules.configs.excel2json.lua_activity168_effect", package.seeall)

local lua_activity168_effect = {}
local fields = {
	effectParams = 3,
	effectType = 2,
	desc = 4,
	effectId = 1
}
local primaryKey = {
	"effectId"
}
local mlStringKey = {
	desc = 1
}

function lua_activity168_effect.onLoad(json)
	lua_activity168_effect.configList, lua_activity168_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity168_effect
