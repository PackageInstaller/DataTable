-- chunkname: @modules/configs/excel2json/lua_activity220_igor_base.lua

module("modules.configs.excel2json.lua_activity220_igor_base", package.seeall)

local lua_activity220_igor_base = {}
local fields = {
	cost = 4,
	costLimit = 3,
	damage = 7,
	attackRange = 6,
	skill1Times = 9,
	attackSpeed = 5,
	skill2Times = 10,
	health = 8,
	id = 1,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {}

function lua_activity220_igor_base.onLoad(json)
	lua_activity220_igor_base.configList, lua_activity220_igor_base.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_igor_base
