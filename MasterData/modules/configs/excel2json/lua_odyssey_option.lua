-- chunkname: @modules/configs/excel2json/lua_odyssey_option.lua

module("modules.configs.excel2json.lua_odyssey_option", package.seeall)

local lua_odyssey_option = {}
local fields = {
	reward = 6,
	id = 1,
	story = 8,
	subDesc = 5,
	notFinish = 3,
	unlockCondition = 2,
	dataBase = 7,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	subDesc = 2,
	desc = 1
}

function lua_odyssey_option.onLoad(json)
	lua_odyssey_option.configList, lua_odyssey_option.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_option
