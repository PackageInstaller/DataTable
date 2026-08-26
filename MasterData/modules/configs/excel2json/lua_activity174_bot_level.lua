-- chunkname: @modules/configs/excel2json/lua_activity174_bot_level.lua

module("modules.configs.excel2json.lua_activity174_bot_level", package.seeall)

local lua_activity174_bot_level = {}
local fields = {
	upWin = 3,
	downLost = 4,
	rank = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_activity174_bot_level.onLoad(json)
	lua_activity174_bot_level.configList, lua_activity174_bot_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_bot_level
