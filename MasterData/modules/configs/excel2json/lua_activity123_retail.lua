-- chunkname: @modules/configs/excel2json/lua_activity123_retail.lua

module("modules.configs.excel2json.lua_activity123_retail", package.seeall)

local lua_activity123_retail = {}
local fields = {
	desc = 4,
	bonus = 5,
	id = 2,
	activityId = 1,
	episodeId = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity123_retail.onLoad(json)
	lua_activity123_retail.configList, lua_activity123_retail.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity123_retail
