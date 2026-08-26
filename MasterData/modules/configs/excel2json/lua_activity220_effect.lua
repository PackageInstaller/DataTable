-- chunkname: @modules/configs/excel2json/lua_activity220_effect.lua

module("modules.configs.excel2json.lua_activity220_effect", package.seeall)

local lua_activity220_effect = {}
local fields = {
	audio = 7,
	effect = 4,
	damage = 9,
	effectId = 1,
	effectSpeed = 5,
	effectTime = 6,
	keyTime = 8,
	percent = 10,
	isHurt = 3,
	isShow = 2
}
local primaryKey = {
	"effectId"
}
local mlStringKey = {}

function lua_activity220_effect.onLoad(json)
	lua_activity220_effect.configList, lua_activity220_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_effect
