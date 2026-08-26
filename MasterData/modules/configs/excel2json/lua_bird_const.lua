-- chunkname: @modules/configs/excel2json/lua_bird_const.lua

module("modules.configs.excel2json.lua_bird_const", package.seeall)

local lua_bird_const = {}
local fields = {
	id = 2,
	value = 3,
	activityId = 1,
	value2 = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	value2 = 1
}

function lua_bird_const.onLoad(json)
	lua_bird_const.configList, lua_bird_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bird_const
