-- chunkname: @modules/configs/excel2json/lua_challenge_condition.lua

module("modules.configs.excel2json.lua_challenge_condition", package.seeall)

local lua_challenge_condition = {}
local fields = {
	decs1 = 4,
	decs2 = 6,
	id = 1,
	type = 2,
	value = 3,
	rule = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	decs2 = 2,
	decs1 = 1
}

function lua_challenge_condition.onLoad(json)
	lua_challenge_condition.configList, lua_challenge_condition.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_challenge_condition
