-- chunkname: @modules/configs/excel2json/lua_activity126_buff.lua

module("modules.configs.excel2json.lua_activity126_buff", package.seeall)

local lua_activity126_buff = {}
local fields = {
	cost = 9,
	name = 4,
	dreamlandCard = 7,
	type = 3,
	taskId = 10,
	bigIcon = 12,
	desc = 5,
	preBuffId = 8,
	skillId = 6,
	id = 1,
	icon = 11,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity126_buff.onLoad(json)
	lua_activity126_buff.configList, lua_activity126_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity126_buff
