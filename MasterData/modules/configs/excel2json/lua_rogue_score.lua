-- chunkname: @modules/configs/excel2json/lua_rogue_score.lua

module("modules.configs.excel2json.lua_rogue_score", package.seeall)

local lua_rogue_score = {}
local fields = {
	reward = 3,
	score = 2,
	special = 5,
	id = 1,
	stage = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rogue_score.onLoad(json)
	lua_rogue_score.configList, lua_rogue_score.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_score
