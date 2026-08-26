-- chunkname: @modules/configs/excel2json/lua_activity231_rating.lua

module("modules.configs.excel2json.lua_activity231_rating", package.seeall)

local lua_activity231_rating = {}
local fields = {
	id = 2,
	rating = 3,
	activityId = 1,
	icon = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity231_rating.onLoad(json)
	lua_activity231_rating.configList, lua_activity231_rating.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_rating
