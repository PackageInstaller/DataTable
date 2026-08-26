-- chunkname: @modules/configs/excel2json/lua_auto_chess_master_skill.lua

module("modules.configs.excel2json.lua_auto_chess_master_skill", package.seeall)

local lua_auto_chess_master_skill = {}
local fields = {
	cost = 2,
	abilities = 6,
	targetType = 11,
	activeChessSkill = 5,
	passiveChessSkills = 4,
	skillIndex = 9,
	type = 3,
	skillaction = 7,
	useeffect = 8,
	id = 1,
	needTarget = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_master_skill.onLoad(json)
	lua_auto_chess_master_skill.configList, lua_auto_chess_master_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_master_skill
