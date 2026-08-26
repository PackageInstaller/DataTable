-- chunkname: @modules/configs/excel2json/lua_siege_battle.lua

module("modules.configs.excel2json.lua_siege_battle", package.seeall)

local lua_siege_battle = {}
local fields = {
	stage = 2,
	heroId = 5,
	instructionDesc = 6,
	episodeId = 7,
	id = 1,
	unlockCondition = 4,
	sort = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	instructionDesc = 1
}

function lua_siege_battle.onLoad(json)
	lua_siege_battle.configList, lua_siege_battle.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_siege_battle
