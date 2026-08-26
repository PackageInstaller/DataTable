-- chunkname: @modules/configs/excel2json/lua_activity225_npc.lua

module("modules.configs.excel2json.lua_activity225_npc", package.seeall)

local lua_activity225_npc = {}
local fields = {
	npcType = 3,
	npcName = 5,
	titleId = 6,
	skinId = 7,
	weight = 9,
	interactiveId = 8,
	eggTxt = 11,
	keepTime = 10,
	npcId = 2,
	npcRace = 4,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"npcId"
}
local mlStringKey = {
	eggTxt = 2,
	npcName = 1
}

function lua_activity225_npc.onLoad(json)
	lua_activity225_npc.configList, lua_activity225_npc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity225_npc
