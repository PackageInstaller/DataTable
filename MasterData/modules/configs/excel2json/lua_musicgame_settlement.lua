-- chunkname: @modules/configs/excel2json/lua_musicgame_settlement.lua

module("modules.configs.excel2json.lua_musicgame_settlement", package.seeall)

local lua_musicgame_settlement = {}
local fields = {
	id = 1,
	audioId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_musicgame_settlement.onLoad(json)
	lua_musicgame_settlement.configList, lua_musicgame_settlement.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_musicgame_settlement
