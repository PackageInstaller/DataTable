-- chunkname: @modules/configs/excel2json/lua_auto_chess_master.lua

module("modules.configs.excel2json.lua_auto_chess_master", package.seeall)

local lua_auto_chess_master = {}
local fields = {
	unlockSkill = 8,
	name = 2,
	spUdimoGoodsId = 19,
	isSelf = 4,
	udimoCase = 17,
	skillIcon = 13,
	spUdimo = 18,
	totalTriggerCountLimit = 11,
	skillId = 9,
	skillName = 12,
	skillDesc = 14,
	skillLockDesc = 16,
	roundTriggerCountLimit = 10,
	illustrationShow = 3,
	image = 7,
	isSpMaster = 5,
	hp = 6,
	skillProgressDesc = 15,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	skillProgressDesc = 4,
	skillName = 2,
	skillDesc = 3,
	skillLockDesc = 5
}

function lua_auto_chess_master.onLoad(json)
	lua_auto_chess_master.configList, lua_auto_chess_master.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_master
