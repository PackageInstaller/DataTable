-- chunkname: @modules/configs/excel2json/lua_activity226_boxlist.lua

module("modules.configs.excel2json.lua_activity226_boxlist", package.seeall)

local lua_activity226_boxlist = {}
local fields = {
	cardId = 2,
	id = 3,
	bonusWeight = 5,
	activityId = 1,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"cardId",
	"id"
}
local mlStringKey = {}

function lua_activity226_boxlist.onLoad(json)
	lua_activity226_boxlist.configList, lua_activity226_boxlist.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity226_boxlist
