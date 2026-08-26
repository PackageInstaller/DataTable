-- chunkname: @modules/configs/excel2json/lua_activity239.lua

module("modules.configs.excel2json.lua_activity239", package.seeall)

local lua_activity239 = {}
local fields = {
	text = 5,
	openTime = 7,
	preId = 3,
	pic = 6,
	id = 2,
	title = 4,
	activityId = 1,
	bonus = 8
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	text = 2,
	title = 1
}

function lua_activity239.onLoad(json)
	lua_activity239.configList, lua_activity239.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity239
