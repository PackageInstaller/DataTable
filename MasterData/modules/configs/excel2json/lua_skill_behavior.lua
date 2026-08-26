-- chunkname: @modules/configs/excel2json/lua_skill_behavior.lua

module("modules.configs.excel2json.lua_skill_behavior", package.seeall)

local lua_skill_behavior = {}
local fields = {
	audioId = 5,
	effect = 3,
	id = 1,
	type = 2,
	effectHangPoint = 4,
	dec_Type = 6,
	dec = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	dec = 1
}

function lua_skill_behavior.onLoad(json)
	lua_skill_behavior.configList, lua_skill_behavior.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_behavior
