-- chunkname: @modules/configs/excel2json/lua_tower_assist_talent.lua

module("modules.configs.excel2json.lua_tower_assist_talent", package.seeall)

local lua_tower_assist_talent = {}
local fields = {
	bossId = 1,
	nodeId = 2,
	startNode = 4,
	nodeType = 12,
	extraRule = 9,
	nodeName = 13,
	nodeGroup = 8,
	nodeDesc = 14,
	isBigNode = 11,
	consume = 5,
	heroPassiveSkills = 7,
	position = 10,
	preNodeIds = 3,
	bossPassiveSkills = 6
}
local primaryKey = {
	"bossId",
	"nodeId"
}
local mlStringKey = {
	nodeName = 1,
	nodeDesc = 2
}

function lua_tower_assist_talent.onLoad(json)
	lua_tower_assist_talent.configList, lua_tower_assist_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_assist_talent
