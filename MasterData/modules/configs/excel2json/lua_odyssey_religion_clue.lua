-- chunkname: @modules/configs/excel2json/lua_odyssey_religion_clue.lua

module("modules.configs.excel2json.lua_odyssey_religion_clue", package.seeall)

local lua_odyssey_religion_clue = {}
local fields = {
	id = 1,
	unlockCondition = 3,
	clue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	clue = 1
}

function lua_odyssey_religion_clue.onLoad(json)
	lua_odyssey_religion_clue.configList, lua_odyssey_religion_clue.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_religion_clue
