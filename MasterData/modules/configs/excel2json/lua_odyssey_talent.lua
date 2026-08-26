-- chunkname: @modules/configs/excel2json/lua_odyssey_talent.lua

module("modules.configs.excel2json.lua_odyssey_talent", package.seeall)

local lua_odyssey_talent = {}
local fields = {
	position = 11,
	nodeId = 1,
	nodeName = 6,
	type = 5,
	unlockCondition = 4,
	addRule = 10,
	nodeDesc = 7,
	consume = 3,
	addSkill = 9,
	icon = 8,
	level = 2
}
local primaryKey = {
	"nodeId",
	"level"
}
local mlStringKey = {
	nodeName = 1,
	nodeDesc = 2
}

function lua_odyssey_talent.onLoad(json)
	lua_odyssey_talent.configList, lua_odyssey_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_talent
