-- chunkname: @modules/configs/excel2json/lua_survival_reputation.lua

module("modules.configs.excel2json.lua_survival_reputation", package.seeall)

local lua_survival_reputation = {}
local fields = {
	cost = 4,
	name = 6,
	reward = 7,
	type = 3,
	id = 1,
	icon = 5,
	lv = 2
}
local primaryKey = {
	"id",
	"lv"
}
local mlStringKey = {
	name = 1
}

function lua_survival_reputation.onLoad(json)
	lua_survival_reputation.configList, lua_survival_reputation.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_reputation
