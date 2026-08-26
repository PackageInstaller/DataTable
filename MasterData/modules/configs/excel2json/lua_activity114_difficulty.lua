-- chunkname: @modules/configs/excel2json/lua_activity114_difficulty.lua

module("modules.configs.excel2json.lua_activity114_difficulty", package.seeall)

local lua_activity114_difficulty = {}
local fields = {
	interval = 2,
	id = 1,
	word = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	word = 1
}

function lua_activity114_difficulty.onLoad(json)
	lua_activity114_difficulty.configList, lua_activity114_difficulty.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity114_difficulty
