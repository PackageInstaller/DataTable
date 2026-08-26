-- chunkname: @modules/configs/excel2json/lua_activity220_date.lua

module("modules.configs.excel2json.lua_activity220_date", package.seeall)

local lua_activity220_date = {}
local fields = {
	eventType = 3,
	day = 2,
	difficult = 5,
	eventParam = 4,
	gameId = 1
}
local primaryKey = {
	"gameId",
	"day"
}
local mlStringKey = {}

function lua_activity220_date.onLoad(json)
	lua_activity220_date.configList, lua_activity220_date.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_date
