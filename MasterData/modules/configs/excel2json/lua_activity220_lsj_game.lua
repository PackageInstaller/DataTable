-- chunkname: @modules/configs/excel2json/lua_activity220_lsj_game.lua

module("modules.configs.excel2json.lua_activity220_lsj_game", package.seeall)

local lua_activity220_lsj_game = {}
local fields = {
	groupId = 1,
	source = 3,
	gameId = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}

function lua_activity220_lsj_game.onLoad(json)
	lua_activity220_lsj_game.configList, lua_activity220_lsj_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_lsj_game
