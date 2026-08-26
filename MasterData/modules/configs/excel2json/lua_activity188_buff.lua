-- chunkname: @modules/configs/excel2json/lua_activity188_buff.lua

module("modules.configs.excel2json.lua_activity188_buff", package.seeall)

local lua_activity188_buff = {}
local fields = {
	desc = 6,
	name = 5,
	buffId = 2,
	icon = 7,
	maxLayer = 4,
	activityId = 1,
	laminate = 3
}
local primaryKey = {
	"activityId",
	"buffId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity188_buff.onLoad(json)
	lua_activity188_buff.configList, lua_activity188_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity188_buff
