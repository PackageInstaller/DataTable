-- chunkname: @modules/configs/excel2json/lua_match3_talent.lua

module("modules.configs.excel2json.lua_match3_talent", package.seeall)

local lua_match3_talent = {}
local fields = {
	costItemId = 5,
	nodeId = 1,
	branch = 2,
	unlockCondition = 8,
	desc = 9,
	effectType = 6,
	prevNodeId = 4,
	nodeIndex = 3,
	effectParam = 7
}
local primaryKey = {
	"nodeId"
}
local mlStringKey = {
	desc = 1
}

function lua_match3_talent.onLoad(json)
	lua_match3_talent.configList, lua_match3_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_match3_talent
