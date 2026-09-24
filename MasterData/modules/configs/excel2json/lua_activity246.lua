-- chunkname: @modules/configs/excel2json/lua_activity246.lua

module("modules.configs.excel2json.lua_activity246", package.seeall)

local lua_activity246 = {}
local fields = {
	cardId = 2,
	cost = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"cardId"
}
local mlStringKey = {}

function lua_activity246.onLoad(json)
	lua_activity246.configList, lua_activity246.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity246
