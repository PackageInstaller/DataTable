-- chunkname: @modules/configs/excel2json/lua_activity231_seat.lua

module("modules.configs.excel2json.lua_activity231_seat", package.seeall)

local lua_activity231_seat = {}
local fields = {
	cost = 4,
	preId = 3,
	id = 2,
	orientation = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity231_seat.onLoad(json)
	lua_activity231_seat.configList, lua_activity231_seat.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_seat
