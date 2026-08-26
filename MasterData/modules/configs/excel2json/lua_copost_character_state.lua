-- chunkname: @modules/configs/excel2json/lua_copost_character_state.lua

module("modules.configs.excel2json.lua_copost_character_state", package.seeall)

local lua_copost_character_state = {}
local fields = {
	chaChange = 7,
	relationshipCha = 8,
	positionId = 4,
	state = 5,
	stateId = 1,
	relationshipTxt = 9,
	isClick = 6,
	relationshipType = 10,
	chaTxt = 11,
	chaId = 2,
	otherId = 3
}
local primaryKey = {
	"stateId"
}
local mlStringKey = {}

function lua_copost_character_state.onLoad(json)
	lua_copost_character_state.configList, lua_copost_character_state.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_character_state
