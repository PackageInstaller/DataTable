-- chunkname: @modules/configs/excel2json/lua_activity144_buff.lua

module("modules.configs.excel2json.lua_activity144_buff", package.seeall)

local lua_activity144_buff = {}
local fields = {
	effectParam = 5,
	effectType = 4,
	buffId = 2,
	type = 3,
	effectDesc = 6,
	reduction = 7,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"buffId"
}
local mlStringKey = {
	effectDesc = 1
}

function lua_activity144_buff.onLoad(json)
	lua_activity144_buff.configList, lua_activity144_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_buff
