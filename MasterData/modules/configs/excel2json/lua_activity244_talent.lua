-- chunkname: @modules/configs/excel2json/lua_activity244_talent.lua

module("modules.configs.excel2json.lua_activity244_talent", package.seeall)

local lua_activity244_talent = {}
local fields = {
	nodeIndex = 3,
	nodeId = 1,
	prevNodeId = 4,
	branch = 2,
	name = 10,
	desc = 8,
	costItemId = 5,
	teamCondition = 6,
	skillId = 7,
	icon = 9
}
local primaryKey = {
	"nodeId"
}
local mlStringKey = {
	name = 2,
	desc = 1
}

function lua_activity244_talent.onLoad(json)
	lua_activity244_talent.configList, lua_activity244_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_talent
