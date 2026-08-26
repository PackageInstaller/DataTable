-- chunkname: @modules/configs/excel2json/lua_atomic_option.lua

module("modules.configs.excel2json.lua_atomic_option", package.seeall)

local lua_atomic_option = {}
local fields = {
	reward = 6,
	id = 1,
	warning = 7,
	story = 9,
	unlockCondition = 2,
	dataBase = 8,
	desc = 4,
	subDesc = 5,
	notFinish = 3,
	puzzle = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	subDesc = 2,
	desc = 1
}

function lua_atomic_option.onLoad(json)
	lua_atomic_option.configList, lua_atomic_option.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_option
