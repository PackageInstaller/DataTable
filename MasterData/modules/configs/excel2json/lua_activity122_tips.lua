-- chunkname: @modules/configs/excel2json/lua_activity122_tips.lua

module("modules.configs.excel2json.lua_activity122_tips", package.seeall)

local lua_activity122_tips = {}
local fields = {
	id = 2,
	content = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	content = 1
}

function lua_activity122_tips.onLoad(json)
	lua_activity122_tips.configList, lua_activity122_tips.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity122_tips
